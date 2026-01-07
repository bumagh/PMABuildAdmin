<?php

namespace app\api\controller;

use app\admin\model\requirement\Forms;
use app\common\controller\Frontend;
use Throwable;
use think\facade\Log;

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

        // 本地调试环境可能需要 index.php 入口
        $notifyUrl = $this->request->domain() . '/index.php/api/payworld/notify';
        $returnUrl = $this->request->domain() . '/index.php/api/payworld/return';

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
        // 使用原始 $_GET 避免框架对参数的过滤/转换影响验签（尤其是 sign/+/
        $rawGet = $_GET ?? [];

        Log::info('[payworld.notify] incoming', [
            'get' => $rawGet,
            'ip' => $this->request->ip(),
        ]);

        // 彩虹易支付异步通知：必须输出 success 才代表处理成功
        $configFile = root_path() . 'app/api/controller/paysdk/lib/epay.config.php';
        if (!is_file($configFile)) {
            Log::error('[payworld.notify] missing config', ['configFile' => $configFile]);
            echo 'fail';
            return;
        }
        $epay_config = [];
        require $configFile;

        $sdkFile = root_path() . 'app/api/controller/paysdk/lib/EpayCore.class.php';
        if (!is_file($sdkFile)) {
            Log::error('[payworld.notify] missing sdk', ['sdkFile' => $sdkFile]);
            echo 'fail';
            return;
        }
        require_once $sdkFile;

        try {
            $epay = new \EpayCore($epay_config);
            $verify = $epay->verify($rawGet);
            Log::info('[payworld.notify] verify', [
                'ok' => $verify ? 1 : 0,
                'sign' => $rawGet['sign'] ?? null,
                'sign_type' => $rawGet['sign_type'] ?? null,
                'timestamp' => $rawGet['timestamp'] ?? null,
            ]);
            if (!$verify) {
                echo 'fail';
                return;
            }

            $tradeStatus = (string)($rawGet['trade_status'] ?? '');
            $outTradeNo = (string)($rawGet['out_trade_no'] ?? '');
            $tradeNo = (string)($rawGet['trade_no'] ?? '');
            $money = (string)($rawGet['money'] ?? '');
            $payType = (string)($rawGet['type'] ?? '');

            Log::info('[payworld.notify] verified payload', [
                'trade_status' => $tradeStatus,
                'out_trade_no' => $outTradeNo,
                'trade_no' => $tradeNo,
                'money' => $money,
                'type' => $payType,
            ]);

            if ($tradeStatus !== 'TRADE_SUCCESS') {
                echo 'success';
                return;
            }

            $paramStr = (string)($rawGet['param'] ?? '');
            $requirementId = $this->extractRequirementId($paramStr);
            Log::info('[payworld.notify] requirement', ['requirement_id' => $requirementId, 'param' => $paramStr]);

            if ($requirementId > 0) {
                // 更新支付状态
                $rows = Forms::where('id', $requirementId)->update(['pay_status' => 1]);
                Log::info('[payworld.notify] updated pay_status', ['requirement_id' => $requirementId, 'rows' => $rows]);
            } else {
                Log::warning('[payworld.notify] requirement_id missing', ['param' => $paramStr]);
            }

            echo 'success';
        } catch (Throwable $e) {
            Log::error('[payworld.notify] exception', [
                'message' => $e->getMessage(),
                'file' => $e->getFile(),
                'line' => $e->getLine(),
            ]);
            echo 'fail';
        }
    }

    public function return(): void
    {
        // 使用原始 $_GET 避免框架对参数的过滤/转换影响验签
        $rawGet = $_GET ?? [];

        Log::info('[payworld.return] incoming', [
            'get' => $rawGet,
            'ip' => $this->request->ip(),
        ]);

        // 同步回调：用于前端展示结果（仍需验签）
        $configFile = root_path() . 'app/api/controller/paysdk/lib/epay.config.php';
        if (!is_file($configFile)) {
            Log::error('[payworld.return] missing config', ['configFile' => $configFile]);
            $this->error('支付配置缺失');
        }
        $epay_config = [];
        require $configFile;

        $sdkFile = root_path() . 'app/api/controller/paysdk/lib/EpayCore.class.php';
        if (!is_file($sdkFile)) {
            Log::error('[payworld.return] missing sdk', ['sdkFile' => $sdkFile]);
            $this->error('支付SDK缺失');
        }
        require_once $sdkFile;

        $epay = new \EpayCore($epay_config);
        $verify = $epay->verify($rawGet);
        Log::info('[payworld.return] verify', [
            'ok' => $verify ? 1 : 0,
            'sign' => $rawGet['sign'] ?? null,
            'sign_type' => $rawGet['sign_type'] ?? null,
            'timestamp' => $rawGet['timestamp'] ?? null,
        ]);
        if (!$verify) {
            Log::warning('[payworld.return] verify failed payload', $rawGet);
            $this->error('验签失败');
        }

        $tradeStatus = (string)($rawGet['trade_status'] ?? '');
        $outTradeNo = (string)($rawGet['out_trade_no'] ?? '');
        $tradeNo = (string)($rawGet['trade_no'] ?? '');
        $money = (string)($rawGet['money'] ?? '');
        $payType = (string)($rawGet['type'] ?? '');
        Log::info('[payworld.return] verified payload', [
            'trade_status' => $tradeStatus,
            'out_trade_no' => $outTradeNo,
            'trade_no' => $tradeNo,
            'money' => $money,
            'type' => $payType,
        ]);

        if ($tradeStatus !== 'TRADE_SUCCESS') {
            $this->error('支付未成功：' . $tradeStatus);
        }

        $paramStr = (string)($rawGet['param'] ?? '');
        $requirementId = $this->extractRequirementId($paramStr);
        Log::info('[payworld.return] requirement', ['requirement_id' => $requirementId, 'param' => $paramStr]);

        if ($requirementId <= 0) {
            $this->success('支付成功');
        }

        // 保险起见，同步回调也更新一次
        $rows = Forms::where('id', $requirementId)->update(['pay_status' => 1]);
        Log::info('[payworld.return] updated pay_status', ['requirement_id' => $requirementId, 'rows' => $rows]);

        // 跳转到前端“需求详情页”
        $url = $this->request->domain() . '/index.html/#/requirement/' . $requirementId;
        Log::info('[payworld.return] redirect', ['url' => $url]);
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
        // 1) 获取所有非空参数；剔除 sign/sign_type；不包含数组、字节流等复杂类型
        $filtered = [];
        foreach ($params as $k => $v) {
            if ($k === 'sign' || $k === 'sign_type') {
                continue;
            }
            if (is_array($v) || is_object($v)) {
                continue;
            }
            if ($v === null) {
                continue;
            }
            $v = trim((string)$v);
            if ($v === '') {
                continue;
            }
            $filtered[$k] = $v;
        }

        // 2) 按 ASCII 升序排序
        ksort($filtered);

        // 3) 参数=参数值 以 & 拼接
        $pairs = [];
        foreach ($filtered as $k => $v) {
            $pairs[] = $k . '=' . $v;
        }
        return implode('&', $pairs);
    }

    private function rsaSign(string $data, string $merchantPrivateKey): string
    {
        // SHA256WithRSA
        $key = "-----BEGIN PRIVATE KEY-----\n" . wordwrap($merchantPrivateKey, 64, "\n", true) . "\n-----END PRIVATE KEY-----";
        $privateKey = openssl_get_privatekey($key);
        if (!$privateKey) {
            $this->error('签名失败');
        }
        openssl_sign($data, $sign, $privateKey, OPENSSL_ALGO_SHA256);
        return base64_encode($sign);
    }
}
