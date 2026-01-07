<template>
    <!-- 对话框表单 -->
    <!-- 建议使用 Prettier 格式化代码 -->
    <!-- el-form 内可以混用 el-form-item、FormItem、ba-input 等输入组件 -->
    <el-dialog
        class="ba-operate-dialog"
        :close-on-click-modal="false"
        :model-value="['Add', 'Edit'].includes(baTable.form.operate!)"
        @close="baTable.toggleForm"
        width="70%"
    >
        <template #header>
            <div class="title" v-drag="['.ba-operate-dialog', '.el-dialog__header']" v-zoom="'.ba-operate-dialog'">
                {{ baTable.form.operate ? t(baTable.form.operate) : '' }}
            </div>
        </template>
        <el-scrollbar v-loading="baTable.form.loading" class="ba-table-form-scrollbar">
            <div
                class="ba-operate-form"
                :class="'ba-' + baTable.form.operate + '-form'"
                :style="config.layout.shrink ? '' : 'width: calc(100% - ' + baTable.form.labelWidth! / 2 + 'px)'"
            >
                <el-form
                    v-if="!baTable.form.loading"
                    ref="formRef"
                    @submit.prevent=""
                    @keyup.enter="baTable.onSubmit(formRef)"
                    :model="baTable.form.items"
                    :label-position="config.layout.shrink ? 'top' : 'right'"
                    :label-width="baTable.form.labelWidth + 'px'"
                    :rules="rules"
                >
                    <FormItem
                        :label="t('requirement.forms.contact_info')"
                        type="string"
                        v-model="baTable.form.items!.contact_info"
                        prop="contact_info"
                        :placeholder="t('Please input field', { field: t('requirement.forms.contact_info') })"
                    />
                    <FormItem
                        :label="t('requirement.forms.requirement_type')"
                        type="radio"
                        v-model="baTable.form.items!.requirement_type"
                        prop="requirement_type"
                        :input-attr="{
                            content: {
                                策划文档: 'requirement_type 策划文档',
                                '美术/视频': 'requirement_type 美术/视频',
                                Demo原型: 'requirement_type Demo原型',
                                定制开发: 'requirement_type 定制开发',
                                咨询: 'requirement_type 咨询',
                                其他: 'requirement_type 其他',
                            },
                        }"
                        :placeholder="t('Please select field', { field: t('requirement.forms.requirement_type') })"
                    />
                    <FormItem
                        :label="t('requirement.forms.requirement_content')"
                        type="editor"
                        v-model="baTable.form.items!.requirement_content"
                        prop="requirement_content"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('requirement.forms.requirement_content') })"
                    />
                    <FormItem
                        :label="t('requirement.forms.payment_method')"
                        type="string"
                        v-model="baTable.form.items!.payment_method"
                        prop="payment_method"
                        :placeholder="t('Please input field', { field: t('requirement.forms.payment_method') })"
                    />
                    <FormItem
                        :label="t('requirement.forms.payment_amount')"
                        type="number"
                        v-model="baTable.form.items!.payment_amount"
                        prop="payment_amount"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('requirement.forms.payment_amount') })"
                    />
                    <FormItem
                        :label="t('requirement.forms.status')"
                        type="radio"
                        v-model="baTable.form.items!.status"
                        prop="status"
                        :input-attr="{ content: { 待处理: 'status 待处理', 已确认: 'status 已确认', 已完成: 'status 已完成' } }"
                        :placeholder="t('Please select field', { field: t('requirement.forms.status') })"
                    />
                    <FormItem
                        :label="t('requirement.forms.pay_status1')"
                        type="switch"
                        v-model="baTable.form.items!.pay_status1"
                        prop="pay_status1"
                        :input-attr="{ content: { '0': t('requirement.forms.pay_status1 0'), '1': t('requirement.forms.pay_status1 1') } }"
                    />
                    <FormItem
                        :label="t('requirement.forms.is_deleted')"
                        type="number"
                        v-model="baTable.form.items!.is_deleted"
                        prop="is_deleted"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('requirement.forms.is_deleted') })"
                    />
                </el-form>
            </div>
        </el-scrollbar>
        <template #footer>
            <div :style="'width: calc(100% - ' + baTable.form.labelWidth! / 1.8 + 'px)'">
                <el-button @click="baTable.toggleForm()">{{ t('Cancel') }}</el-button>
                <el-button v-blur :loading="baTable.form.submitLoading" @click="baTable.onSubmit(formRef)" type="primary">
                    {{ baTable.form.operateIds && baTable.form.operateIds.length > 1 ? t('Save and edit next item') : t('Save') }}
                </el-button>
            </div>
        </template>
    </el-dialog>
</template>

<script setup lang="ts">
import type { FormItemRule } from 'element-plus'
import { inject, reactive, useTemplateRef } from 'vue'
import { useI18n } from 'vue-i18n'
import FormItem from '/@/components/formItem/index.vue'
import { useConfig } from '/@/stores/config'
import type baTableClass from '/@/utils/baTable'
import { buildValidatorData } from '/@/utils/validate'

const config = useConfig()
const formRef = useTemplateRef('formRef')
const baTable = inject('baTable') as baTableClass

const { t } = useI18n()

const rules: Partial<Record<string, FormItemRule[]>> = reactive({
    requirement_content: [buildValidatorData({ name: 'editorRequired', title: t('requirement.forms.requirement_content') })],
    payment_amount: [buildValidatorData({ name: 'number', title: t('requirement.forms.payment_amount') })],
    create_time: [buildValidatorData({ name: 'date', title: t('requirement.forms.create_time') })],
    is_deleted: [buildValidatorData({ name: 'number', title: t('requirement.forms.is_deleted') })],
})
</script>

<style scoped lang="scss"></style>
