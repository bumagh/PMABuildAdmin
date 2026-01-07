<?php

namespace app\api\controller;

use app\admin\model\requirement\Forms;
use app\common\controller\Frontend;
use Throwable;

class Payworld extends Frontend
{
    protected array $noNeedLogin = ['payTest', 'notify', 'return'];

    public function initialize(): void
    {
        parent::initialize();
    }

    public function payTest(): void
    {
        $money = (string)$this->request->post('money', '1.00');
        $type  = (string)$this->request->post('type', 'alipay');
        $name  = (string)$this->request->post('name', '支付测试(1元)');
        $param = (string)$this->request->post('param', '');

        if (!preg_match('/^\d+(\.\d{1,2})?$/', $money) || (float)$money <= 0) {
            $this->error('金额不正确');
        }
        if ($type !== '' && !in_array($type, ['alipay', 'wxpay', 'qqpay', 'bank'], true)) {
            $this->error('支付方式不正确');
        }

        $outTradeNo = 'PW' . date('YmdHis') . random_int(100, 999);

        $notifyUrl = $this->request->domain() . '/api/payworld/notify';
        $returnUrl = $this->request->domain() . '/api/payworld/return';

        $configFile = root_path() . 'app/api/controller/paysdk/lib/epay.config.php';
        if (!is_file($configFile)) {
            $this->error('支付配置缺失');
        }
        $epay_config = [];
        require $configFile;

        if (empty($epay_config['apiurl']) || empty($epay_config['pid']) || empty($epay_config['merchant_private_key'])) {
            $this->error('支付配置不完整');
        }

        $apiurl = rtrim((string)$epay_config['apiurl'], '/') . '/';
        $submitUrl = $apiurl . 'api/pay/submit';

        $timestamp = (string)time();

        $params = [
            'pid'         => (string)$epay_config['pid'],
            'out_trade_no'=> $outTradeNo,
            'notify_url'  => $notifyUrl,
            'return_url'  => $returnUrl,
            'name'        => $name,
            'money'       => $money,
            'param'       => $param,
            'timestamp'   => $timestamp,
        ];
        if ($type !== '') {
            $params['type'] = $type;
        }

        $params['sign'] = $this->rsaSign($this->buildSignContent($params), (string)$epay_config['merchant_private_key']);
        $params['sign_type'] = 'RSA';

        $this->success('', [
            'method' => 'POST',
            'url'    => $submitUrl,
            'params' => $params,
        ]);
    }

    public function notify(): void
    {
        // 彩虹易支付异步通知：必须输出 success 才代表处理成功
        $configFile = root_path() . 'app/api/controller/paysdk/lib/epay.config.php';
        if (!is_file($configFile)) {
            echo 'fail';
            return;
        }
        $epay_config = [];
        require $configFile;

        $sdkFile = root_path() . 'app/api/controller/paysdk/lib/EpayCore.class.php';
        if (!is_file($sdkFile)) {
            echo 'fail';
            return;
        }
        require_once $sdkFile;

        try {
            $epay = new \EpayCore($epay_config);
            $verify = $epay->verify($this->request->get());
            if (!$verify) {
                echo 'fail';
                return;
            }

            $tradeStatus = (string)$this->request->get('trade_status', '');
            if ($tradeStatus !== 'TRADE_SUCCESS') {
                echo 'success';
                return;
            }

            $paramStr = (string)$this->request->get('param', '');
            $requirementId = $this->extractRequirementId($paramStr);
            if ($requirementId > 0) {
                // 更新支付状态
                Forms::where('id', $requirementId)->update(['pay_status' => 1]);
            }

            echo 'success';
        } catch (Throwable $e) {
            echo 'fail';
        }
    }

    public function return(): void
    {
        // 同步回调：用于前端展示结果（仍需验签）
        $configFile = root_path() . 'app/api/controller/paysdk/lib/epay.config.php';
        if (!is_file($configFile)) {
            $this->error('支付配置缺失');
        }
        $epay_config = [];
        require $configFile;

        $sdkFile = root_path() . 'app/api/controller/paysdk/lib/EpayCore.class.php';
        if (!is_file($sdkFile)) {
            $this->error('支付SDK缺失');
        }
        require_once $sdkFile;

        $epay = new \EpayCore($epay_config);
        if (!$epay->verify($this->request->get())) {
            $this->error('验签失败');
        }

        $tradeStatus = (string)$this->request->get('trade_status', '');
        if ($tradeStatus !== 'TRADE_SUCCESS') {
            $this->error('支付未成功：' . $tradeStatus);
        }

        $paramStr = (string)$this->request->get('param', '');
        $requirementId = $this->extractRequirementId($paramStr);
        if ($requirementId <= 0) {
            $this->success('支付成功');
        }

        // 保险起见，同步回调也更新一次
        Forms::where('id', $requirementId)->update(['pay_status' => 1]);

        // 跳转到前端“需求详情页”
        $url = $this->request->domain() . '/index.html/#/requirement/' . $requirementId;
        header('Location: ' . $url);
        exit;
    }

    private function extractRequirementId(string $paramStr): int
    {
        $paramStr = trim($paramStr);
        if ($paramStr === '') {
            return 0;
        }

        $data = json_decode($paramStr, true);
        if (json_last_error() === JSON_ERROR_NONE && is_array($data)) {
            $id = (int)($data['requirement_id'] ?? 0);
            return $id > 0 ? $id : 0;
        }

        // 兼容 param 不是 JSON 的情况：尝试从 querystring 提取
        parse_str($paramStr, $arr);
        $id = (int)($arr['requirement_id'] ?? 0);
        return $id > 0 ? $id : 0;
    }

    private function buildSignContent(array $params): string
    {
        ksort($params);
        $signstr = '';
        foreach ($params as $k => $v) {
            if (is_array($v) || $v === null) {
                continue;
            }
            $v = trim((string)$v);
            if ($v === '' || $k === 'sign' || $k === 'sign_type') {
                continue;
            }
            $signstr .= '&' . $k . '=' . $v;
        }
        return ltrim($signstr, '&');
    }

    private function rsaSign(string $data, string $merchantPrivateKey): string
    {
        $key = "-----BEGIN PRIVATE KEY-----\n" . wordwrap($merchantPrivateKey, 64, "\n", true) . "\n-----END PRIVATE KEY-----";
        $privateKey = openssl_get_privatekey($key);
        if (!$privateKey) {
            $this->error('签名失败');
        }
        openssl_sign($data, $sign, $privateKey, OPENSSL_ALGO_SHA256);
        return base64_encode($sign);
    }
}
