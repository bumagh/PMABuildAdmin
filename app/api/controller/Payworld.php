<?php

namespace app\api\controller;

use app\common\controller\Frontend;

class Payworld extends Frontend
{
    protected array $noNeedLogin = ['payTest'];

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
        echo 'success';
    }

    public function return(): void
    {
        $this->success('ok');
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
