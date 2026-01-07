<?php

namespace app\admin\controller\requirement;

use app\common\controller\Backend;

/**
 * 简化需求表单管理
 */
class Forms extends Backend
{
    /**
     * Forms模型对象
     * @var object
     * @phpstan-var \app\admin\model\requirement\Forms
     */
    protected object $model;

    protected array|string $preExcludeFields = ['id', 'create_time'];

    protected string|array $quickSearchField = ['id'];

    public function initialize(): void
    {
        parent::initialize();
        $this->model = new \app\admin\model\requirement\Forms();
        $this->request->filter('clean_xss');
    }


    /**
     * 若需重写查看、编辑、删除等方法，请复制 @see \app\admin\library\traits\Backend 中对应的方法至此进行重写
     */
}