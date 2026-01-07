<?php

namespace app\admin\model\requirement;

use think\Model;

/**
 * Forms
 */
class Forms extends Model
{
    // 表名
    protected $name = 'requirement_forms';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;
    protected $updateTime = false;


    public function getRequirementContentAttr($value): string
    {
        return !$value ? '' : htmlspecialchars_decode($value);
    }

    public function getPaymentAmountAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }
}