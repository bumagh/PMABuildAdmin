<template>
  <div class="settings-panel">
    <div class="settings-header">
      <h2>设置面板</h2>
      <button class="btn-close" @click="$emit('close')">×</button>
    </div>

    <div class="settings-content">
      <!-- 隐私设置 -->
      <section class="settings-section">
        <h3>隐私设置</h3>
        <div class="settings-group">
          <div class="setting-item">
            <label class="setting-label">
              <span class="label-text">隐私级别</span>
              <span class="label-description">控制你的数据可见范围</span>
            </label>
            <div class="setting-control">
              <select v-model="localSettings.privacy_level" class="select-input">
                <option value="private">完全私密</option>
                <option value="community">仅限社区</option>
                <option value="public">公开可见</option>
              </select>
            </div>
          </div>

          <div class="setting-item">
            <label class="setting-label">
              <span class="label-text">数据分享</span>
              <span class="label-description">选择愿意分享的数据类型</span>
            </label>
            <div class="setting-control">
              <div class="checkbox-group">
                <label v-for="option in dataSharingOptions" :key="option.id" class="checkbox-label">
                  <input 
                    type="checkbox" 
                    v-model="localSettings.data_sharing" 
                    :value="option.id"
                    class="checkbox-input"
                  >
                  <span class="checkbox-custom"></span>
                  <span class="checkbox-text">{{ option.label }}</span>
                </label>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- 通知设置 -->
      <section class="settings-section">
        <h3>通知设置</h3>
        <div class="settings-group">
          <div v-for="setting in notificationSettings" :key="setting.id" class="setting-item">
            <label class="setting-label">
              <span class="label-text">{{ setting.label }}</span>
              <span class="label-description">{{ setting.description }}</span>
            </label>
            <div class="setting-control">
              <label class="switch">
                <input 
                  type="checkbox" 
                  v-model="localSettings.notification_settings[setting.id]"
                  class="switch-input"
                >
                <span class="switch-slider"></span>
              </label>
            </div>
          </div>
        </div>
      </section>

      <!-- 数据管理 -->
      <section class="settings-section">
        <h3>数据管理</h3>
        <div class="settings-group">
          <div class="setting-item">
            <label class="setting-label">
              <span class="label-text">数据保留期限</span>
              <span class="label-description">自动删除超过此期限的数据</span>
            </label>
            <div class="setting-control">
              <select v-model="dataRetention" class="select-input">
                <option value="1month">1个月</option>
                <option value="3months">3个月</option>
                <option value="6months">6个月</option>
                <option value="1year">1年</option>
                <option value="forever">永久保留</option>
              </select>
            </div>
          </div>

          <div class="setting-item">
            <label class="setting-label">
              <span class="label-text">数据导出</span>
              <span class="label-description">导出你的所有数据</span>
            </label>
            <div class="setting-control">
              <button class="btn-secondary" @click="exportData">
                <span class="icon">📥</span>
                导出数据
              </button>
            </div>
          </div>

          <div class="setting-item">
            <label class="setting-label">
              <span class="label-text">数据重置</span>
              <span class="label-description">清除所有个人数据（不可恢复）</span>
            </label>
            <div class="setting-control">
              <button class="btn-danger" @click="confirmReset">
                <span class="icon">🗑️</span>
                重置数据
              </button>
            </div>
          </div>
        </div>
      </section>

      <!-- 外观设置 -->
      <section class="settings-section">
        <h3>外观设置</h3>
        <div class="settings-group">
          <div class="setting-item">
            <label class="setting-label">
              <span class="label-text">主题模式</span>
              <span class="label-description">选择界面主题</span>
            </label>
            <div class="setting-control">
              <div class="theme-selector">
                <button 
                  v-for="theme in themes" 
                  :key="theme.id"
                  class="theme-option"
                  :class="{ 'active': theme.id === activeTheme }"
                  @click="selectTheme(theme.id)"
                >
                  <div class="theme-preview" :style="theme.style"></div>
                  <span class="theme-name">{{ theme.name }}</span>
                </button>
              </div>
            </div>
          </div>

          <div class="setting-item">
            <label class="setting-label">
              <span class="label-text">数据可视化</span>
              <span class="label-description">选择数据展示方式</span>
            </label>
            <div class="setting-control">
              <div class="radio-group">
                <label v-for="option in visualizationOptions" :key="option.id" class="radio-label">
                  <input 
                    type="radio" 
                    v-model="visualizationMode" 
                    :value="option.id"
                    name="visualization"
                    class="radio-input"
                  >
                  <span class="radio-custom"></span>
                  <span class="radio-text">{{ option.label }}</span>
                </label>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- 账户设置 -->
      <section class="settings-section">
        <h3>账户设置</h3>
        <div class="settings-group">
          <div class="setting-item">
            <label class="setting-label">
              <span class="label-text">生物识别登录</span>
              <span class="label-description">使用指纹或面容ID登录</span>
            </label>
            <div class="setting-control">
              <label class="switch">
                <input type="checkbox" v-model="biometricAuth" class="switch-input">
                <span class="switch-slider"></span>
              </label>
            </div>
          </div>

          <div class="setting-item">
            <label class="setting-label">
              <span class="label-text">两步验证</span>
              <span class="label-description">增强账户安全性</span>
            </label>
            <div class="setting-control">
              <label class="switch">
                <input type="checkbox" v-model="twoFactorAuth" class="switch-input">
                <span class="switch-slider"></span>
              </label>
            </div>
          </div>

          <div class="setting-item">
            <label class="setting-label">
              <span class="label-text">账户同步</span>
              <span class="label-description">自动同步数据到云端</span>
            </label>
            <div class="setting-control">
              <label class="switch">
                <input type="checkbox" v-model="cloudSync" class="switch-input">
                <span class="switch-slider"></span>
              </label>
            </div>
          </div>
        </div>
      </section>
    </div>

    <div class="settings-footer">
      <button class="btn-cancel" @click="$emit('close')">取消</button>
      <button class="btn-save" @click="saveSettings">保存设置</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch, defineProps, defineEmits } from 'vue'

interface Settings {
  privacy_level: string
  data_sharing: string[]
  notification_settings: Record<string, boolean>
}

const props = defineProps<{
  profile: any
}>()

const emit = defineEmits(['save', 'close'])

// 本地设置副本
const localSettings = ref<Settings>({
  privacy_level: props.profile.preferences.privacy_level,
  data_sharing: [...props.profile.preferences.data_sharing],
  notification_settings: { ...props.profile.preferences.notification_settings }
})

// 其他设置状态
const dataRetention = ref('1year')
const activeTheme = ref('dark')
const visualizationMode = ref('detailed')
const biometricAuth = ref(true)
const twoFactorAuth = ref(false)
const cloudSync = ref(true)

// 数据分享选项
const dataSharingOptions = [
  { id: 'health', label: '健康数据' },
  { id: 'cognitive', label: '认知数据' },
  { id: 'enhancement', label: '增强数据' },
  { id: 'progress', label: '进化进度' },
  { id: 'contributions', label: '贡献记录' }
]

// 通知设置选项
const notificationSettings = [
  { 
    id: 'daily_summary', 
    label: '每日总结', 
    description: '每天接收个人数据总结' 
  },
  { 
    id: 'milestone_alerts', 
    label: '里程碑提醒', 
    description: '达到重要里程碑时通知' 
  },
  { 
    id: 'community_updates', 
    label: '社区更新', 
    description: '接收社区活动和更新' 
  },
  { 
    id: 'system_notices', 
    label: '系统通知', 
    description: '重要系统更新和维护通知' 
  },
  { 
    id: 'research_opportunities', 
    label: '研究机会', 
    description: '参与超人类主义研究的机会' 
  }
]

// 主题选项
const themes = [
  { 
    id: 'dark', 
    name: '深色', 
    style: 'background: linear-gradient(135deg, #0a0a0a, #1a1a2e); border-color: #333;' 
  },
  { 
    id: 'light', 
    name: '浅色', 
    style: 'background: linear-gradient(135deg, #ffffff, #f5f5f5); border-color: #ddd;' 
  },
  { 
    id: 'blue', 
    name: '科技蓝', 
    style: 'background: linear-gradient(135deg, #0f2027, #203a43, #2c5364); border-color: #0088ff;' 
  },
  { 
    id: 'purple', 
    name: '幻影紫', 
    style: 'background: linear-gradient(135deg, #667eea, #764ba2); border-color: #9c27b0;' 
  },
  { 
    id: 'cyberpunk', 
    name: '赛博朋克', 
    style: 'background: linear-gradient(135deg, #0f0c29, #302b63, #24243e); border-color: #ff00ff;' 
  }
]

// 可视化选项
const visualizationOptions = [
  { id: 'detailed', label: '详细模式' },
  { id: 'minimal', label: '简洁模式' },
  { id: 'advanced', label: '高级图表' },
  { id: 'holographic', label: '全息投影' }
]

// 保存设置
const saveSettings = () => {
  emit('save', localSettings.value)
  emit('close')
}

// 导出数据
const exportData = () => {
  const data = {
    profile: props.profile,
    settings: localSettings.value,
    export_date: new Date().toISOString()
  }
  
  const dataStr = JSON.stringify(data, null, 2)
  const dataBlob = new Blob([dataStr], { type: 'application/json' })
  const url = URL.createObjectURL(dataBlob)
  
  const link = document.createElement('a')
  link.href = url
  link.download = `transhuman_data_${new Date().getTime()}.json`
  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
  URL.revokeObjectURL(url)
  
  alert('数据导出成功！')
}

// 确认数据重置
const confirmReset = () => {
  if (confirm('⚠️ 警告：这将永久删除所有个人数据，此操作不可撤销。确定要继续吗？')) {
    // 这里应该调用API来重置数据
    alert('数据重置请求已发送。')
  }
}

// 选择主题
const selectTheme = (themeId: string) => {
  activeTheme.value = themeId
  // 这里可以添加应用主题的逻辑
}

// 监听设置变化
watch(() => props.profile, (newProfile) => {
  if (newProfile) {
    localSettings.value = {
      privacy_level: newProfile.preferences.privacy_level,
      data_sharing: [...newProfile.preferences.data_sharing],
      notification_settings: { ...newProfile.preferences.notification_settings }
    }
  }
}, { immediate: true })
</script>

<style scoped>
.settings-panel {
  background: #1a1a2e;
  color: #e0e0e0;
  border-radius: 16px;
  overflow: hidden;
  max-height: 90vh;
  display: flex;
  flex-direction: column;
}

.settings-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem 2rem;
  background: rgba(0, 0, 0, 0.3);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.settings-header h2 {
  margin: 0;
  font-size: 1.5rem;
  background: linear-gradient(90deg, #00d4ff, #0088ff);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}

.btn-close {
  background: none;
  border: none;
  color: #a0a0a0;
  font-size: 1.5rem;
  cursor: pointer;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.btn-close:hover {
  background: rgba(255, 255, 255, 0.1);
  color: white;
}

.settings-content {
  flex: 1;
  overflow-y: auto;
  padding: 2rem;
}

.settings-section {
  margin-bottom: 2rem;
}

.settings-section h3 {
  font-size: 1.125rem;
  margin-bottom: 1rem;
  color: white;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.settings-group {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.setting-item {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.3s ease;
}

.setting-item:hover {
  background: rgba(255, 255, 255, 0.08);
  border-color: rgba(0, 212, 255, 0.3);
}

.setting-label {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.label-text {
  font-weight: 500;
  color: white;
}

.label-description {
  font-size: 0.875rem;
  color: #a0a0a0;
}

.setting-control {
  margin-left: 1rem;
  min-width: 200px;
}

.select-input {
  width: 100%;
  padding: 0.5rem 1rem;
  background: rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 8px;
  color: white;
  font-size: 0.875rem;
  outline: none;
  transition: all 0.3s ease;
}

.select-input:focus {
  border-color: #00d4ff;
  box-shadow: 0 0 0 2px rgba(0, 212, 255, 0.2);
}

.checkbox-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.checkbox-label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
  font-size: 0.875rem;
}

.checkbox-input {
  display: none;
}

.checkbox-custom {
  width: 18px;
  height: 18px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 4px;
  position: relative;
  transition: all 0.3s ease;
}

.checkbox-input:checked + .checkbox-custom {
  background: #00d4ff;
  border-color: #00d4ff;
}

.checkbox-input:checked + .checkbox-custom::after {
  content: '✓';
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: white;
  font-size: 0.75rem;
}

.checkbox-text {
  color: #e0e0e0;
}

.switch {
  position: relative;
  display: inline-block;
  width: 50px;
  height: 24px;
}

.switch-input {
  opacity: 0;
  width: 0;
  height: 0;
}

.switch-slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: 24px;
  transition: all 0.3s ease;
}

.switch-slider:before {
  position: absolute;
  content: '';
  height: 20px;
  width: 20px;
  left: 2px;
  bottom: 2px;
  background-color: white;
  border-radius: 50%;
  transition: all 0.3s ease;
}

.switch-input:checked + .switch-slider {
  background-color: #00d4ff;
}

.switch-input:checked + .switch-slider:before {
  transform: translateX(26px);
}

.btn-secondary, .btn-danger {
  padding: 0.5rem 1rem;
  border-radius: 8px;
  border: none;
  cursor: pointer;
  font-size: 0.875rem;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  transition: all 0.3s ease;
}

.btn-secondary {
  background: rgba(0, 212, 255, 0.1);
  color: #00d4ff;
  border: 1px solid rgba(0, 212, 255, 0.3);
}

.btn-secondary:hover {
  background: rgba(0, 212, 255, 0.2);
  transform: translateY(-2px);
}

.btn-danger {
  background: rgba(244, 67, 54, 0.1);
  color: #f44336;
  border: 1px solid rgba(244, 67, 54, 0.3);
}

.btn-danger:hover {
  background: rgba(244, 67, 54, 0.2);
  transform: translateY(-2px);
}

.theme-selector {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.theme-option {
  flex: 1;
  min-width: 60px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  background: none;
  border: none;
  color: inherit;
  cursor: pointer;
  padding: 0.5rem;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.theme-option:hover {
  background: rgba(255, 255, 255, 0.05);
}

.theme-option.active {
  background: rgba(0, 212, 255, 0.1);
  border: 1px solid rgba(0, 212, 255, 0.5);
}

.theme-preview {
  width: 40px;
  height: 40px;
  border-radius: 8px;
  border: 2px solid transparent;
  transition: all 0.3s ease;
}

.theme-option.active .theme-preview {
  border-color: #00d4ff;
  transform: scale(1.1);
}

.theme-name {
  font-size: 0.75rem;
  color: #a0a0a0;
}

.radio-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.radio-label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
  font-size: 0.875rem;
}

.radio-input {
  display: none;
}

.radio-custom {
  width: 18px;
  height: 18px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  position: relative;
  transition: all 0.3s ease;
}

.radio-input:checked + .radio-custom {
  border-color: #00d4ff;
}

.radio-input:checked + .radio-custom::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 10px;
  height: 10px;
  background: #00d4ff;
  border-radius: 50%;
}

.radio-text {
  color: #e0e0e0;
}

.settings-footer {
  display: flex;
  justify-content: flex-end;
  gap: 1rem;
  padding: 1.5rem 2rem;
  background: rgba(0, 0, 0, 0.3);
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.btn-cancel, .btn-save {
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  border: none;
  cursor: pointer;
  font-weight: 500;
  transition: all 0.3s ease;
}

.btn-cancel {
  background: rgba(255, 255, 255, 0.1);
  color: #e0e0e0;
}

.btn-cancel:hover {
  background: rgba(255, 255, 255, 0.2);
}

.btn-save {
  background: linear-gradient(90deg, #00d4ff, #0088ff);
  color: white;
}

.btn-save:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 212, 255, 0.3);
}

/* 滚动条样式 */
.settings-content::-webkit-scrollbar {
  width: 8px;
}

.settings-content::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 4px;
}

.settings-content::-webkit-scrollbar-thumb {
  background: rgba(0, 212, 255, 0.5);
  border-radius: 4px;
}

.settings-content::-webkit-scrollbar-thumb:hover {
  background: rgba(0, 212, 255, 0.7);
}

@media (max-width: 768px) {
  .settings-panel {
    width: 95vw;
    max-height: 95vh;
  }
  
  .setting-item {
    flex-direction: column;
    gap: 1rem;
  }
  
  .setting-control {
    margin-left: 0;
    width: 100%;
  }
  
  .theme-selector {
    justify-content: center;
  }
  
  .settings-footer {
    flex-direction: column;
  }
  
  .btn-cancel, .btn-save {
    width: 100%;
  }
}
</style>