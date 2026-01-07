<?php

namespace app\api\controller;

use Throwable;
use app\admin\model\requirement\Forms;
use app\common\controller\Frontend;

class Requirement extends Frontend
{
    protected array $noNeedLogin = ['create', 'detail', 'findByContact'];

    public function initialize(): void
    {
        parent::initialize();
    }

    public function create(): void
    {
        $params = $this->request->only(['contact', 'type', 'detail', 'payment_method', 'payment_amount']);

        $contact = trim((string)($params['contact'] ?? ''));
        $type = trim((string)($params['type'] ?? ''));
        $detail = trim((string)($params['detail'] ?? ''));
        $paymentMethod = trim((string)($params['payment_method'] ?? ''));
        $paymentAmount = $params['payment_amount'] ?? null;

        if ($contact === '') {
            $this->error('请填写联系方式');
        }
        if ($detail === '') {
            $this->error('请填写需求详细');
        }

        // 约束 type 必须在枚举范围内（空表示不选）
        $allowedTypes = ['策划文档', '美术/视频', 'Demo原型', '定制开发', '咨询', '其他'];
        if ($type !== '' && !in_array($type, $allowedTypes, true)) {
            $this->error('需求类型不正确');
        }

        if ($paymentMethod === '') {
            $paymentMethod = null;
        }

        if ($paymentAmount !== null && $paymentAmount !== '') {
            if (!is_numeric($paymentAmount) || (float)$paymentAmount < 0) {
                $this->error('支付金额不正确');
            }
            $paymentAmount = (float)$paymentAmount;
        } else {
            $paymentAmount = null;
        }

        try {
            $model = new Forms();
            $model->save([
                'contact_info' => $contact,
                'requirement_type' => $type ?: null,
                'requirement_content' => $detail,
                'payment_method' => $paymentMethod,
                'payment_amount' => $paymentAmount,
                // create_time 由模型自动写入
            ]);
        } catch (Throwable $e) {
            $this->error($e->getMessage());
        }

        $this->success('', [
            'id' => $model->id,
        ]);
    }

    public function detail(): void
    {
        $id = (int)$this->request->get('id', 0);
        if ($id <= 0) {
            $this->error('参数不正确');
        }

        $row = Forms::where('id', $id)->find();
        if (!$row) {
            $this->error('记录不存在');
        }

        $this->success('', [
            'id' => (int)$row->id,
            'contact_info' => (string)$row->contact_info,
            'requirement_type' => (string)($row->requirement_type ?? ''),
            'requirement_content' => (string)$row->requirement_content,
            'payment_method' => (string)($row->payment_method ?? ''),
            'payment_amount' => $row->payment_amount,
            'pay_status' => (int)($row->pay_status ?? 0),
            'create_time' => (int)$row->create_time,
        ]);
    }

    public function findByContact(): void
    {
        $contact = trim((string)$this->request->get('contact', ''));
        if ($contact === '') {
            $this->error('请填写联系方式');
        }

        $row = Forms::where('contact_info', $contact)
            ->order('id', 'desc')
            ->find();

        if (!$row) {
            $this->error('未找到相关需求');
        }

        $this->success('', [
            'id' => (int)$row->id,
        ]);
    }
}
