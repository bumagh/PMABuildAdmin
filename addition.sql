-- 简化版需求表单表
CREATE TABLE ba_requirement_forms (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    
    -- 核心字段
    contact_info VARCHAR(200) NOT NULL COMMENT '联系方式（电话/邮箱等）',
    requirement_type ENUM('策划文档', '美术/视频', 'Demo原型', '定制开发', '咨询', '其他') 
        DEFAULT NULL COMMENT '需求类型（可选）',
    requirement_content TEXT NOT NULL COMMENT '需求详细内容（必填）',
    
    -- 支付相关（可选字段）
    payment_method VARCHAR(50) DEFAULT NULL COMMENT '支付方式',
    payment_amount DECIMAL(10,2) DEFAULT NULL COMMENT '支付金额',
    
    -- 时间字段
    create_time BIGINT NOT NULL COMMENT '创建时间（毫秒时间戳）',
    
    -- 状态字段
    status ENUM('待处理', '已确认', '已完成') DEFAULT '待处理' COMMENT '处理状态',
    
    -- 系统字段
    is_deleted TINYINT DEFAULT 0 COMMENT '软删除标记(0:正常 1:删除)',
    
    -- 索引
    INDEX idx_create_time (create_time),
    INDEX idx_status (status),
    INDEX idx_contact_info (contact_info(20))
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='简化需求表单表';

-- 插入示例数据
INSERT INTO ba_requirement_forms (
    contact_info,
    requirement_type,
    requirement_content,
    payment_method,
    payment_amount,
    create_time
) VALUES 
(
    '13800138000',
    '咨询',
    '需要开发一个用户管理系统，包含用户注册、登录、权限管理等功能。',
    '在线支付',
    5000.00,
    UNIX_TIMESTAMP() * 1000
),
(
    'example@email.com',
    '咨询',
    '想咨询关于系统架构设计的最佳实践，以及微服务与传统单体架构的对比。',
    NULL,
    NULL,
    UNIX_TIMESTAMP() * 1000
);