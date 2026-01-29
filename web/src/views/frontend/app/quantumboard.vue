<template>
  <div class="transhuman-dashboard">
    <!-- 顶部导航 -->
    <nav class="dashboard-nav">
      <div class="nav-left">
        <div class="brand">
          <div class="logo">⚡</div>
          <h1>TransHuman++</h1>
        </div>
        <div class="nav-status">
          <span class="status-indicator" :class="userStageClass"></span>
          <span class="stage-label">阶段 {{ userProfile.current_stage }}</span>
        </div>
      </div>
      <div class="nav-right">
        <button class="btn-icon" @click="refreshData">
          <span class="icon">🔄</span>
        </button>
        <button class="btn-icon" @click="showSettings">
          <span class="icon">⚙️</span>
        </button>
        <div class="user-avatar">
          <div class="avatar">{{ userProfile.avatar }}</div>
        </div>
      </div>
    </nav>

    <!-- 主内容区 -->
    <main class="dashboard-main" :class="{ 'mobile-tab-active': isMobile && activeTab !== 'overview' }" :data-active-tab="activeTab">
      <!-- 顶部概览 -->
      <div class="overview-section">
        <div class="welcome-card">
          <h2>欢迎回来，{{ userProfile.name }}</h2>
          <p class="subtitle">你的超人类进化旅程已持续 {{ evolutionDays }} 天</p>
          <div class="milestone-tags">
            <span class="tag" v-for="(milestone, index) in userProfile.milestones" :key="index">
              {{ milestone }}
            </span>
          </div>
        </div>

        <div class="stage-progress">
          <h3>进化阶段</h3>
          <div class="stage-bar">
            <div 
              v-for="stage in 7" 
              :key="stage" 
              class="stage-segment"
              :class="{
                'completed': stage <= userProfile.current_stage,
                'current': stage === userProfile.current_stage
              }"
              @click="viewStageInfo(stage)"
            >
              <span class="stage-number">{{ stage }}</span>
              <span class="stage-name">{{ stageNames[stage-1] }}</span>
            </div>
          </div>
          <div class="stage-description">
            {{ stageDescriptions[userProfile.current_stage-1] }}
          </div>
        </div>
      </div>

      <!-- 核心指标 -->
      <div class="metrics-section">
        <h2 class="section-title">核心指标</h2>
        <div class="metrics-grid">
          <MetricCard 
            v-for="metric in coreMetrics" 
            :key="metric.id"
            :title="metric.title"
            :value="metric.value"
            :unit="metric.unit"
            :trend="metric.trend"
            :color="metric.color"
            :icon="metric.icon"
            @click="viewDetail(metric.id)"
          />
        </div>
      </div>

      <!-- 排名面板 -->
      <div class="ranking-section">
        <div class="ranking-card">
          <div class="ranking-header">
            <h3>全球排名</h3>
            <div class="ranking-trend" :class="`trend-${rankings.trend}`">
              <span class="trend-icon">{{ trendIcon }}</span>
              <span class="trend-value">{{ rankings.trend_change }}</span>
            </div>
          </div>
          <div class="ranking-content">
            <div class="ranking-number">
              <span class="global-rank">#{{ rankings.global.toLocaleString() }}</span>
              <span class="percentile">前 {{ rankings.percentile }}%</span>
            </div>
            <div class="ranking-breakdown">
              <div class="breakdown-item">
                <span class="label">区域排名</span>
                <span class="value">#{{ rankings.regional }}</span>
              </div>
              <div class="breakdown-item">
                <span class="label">阶段排名</span>
                <span class="value">#{{ rankings.by_stage }}</span>
              </div>
              <div class="breakdown-item">
                <span class="label">健康排名</span>
                <span class="value">#{{ rankings.category_rankings.health }}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="ranking-details">
          <h4>详细排名</h4>
          <div class="ranking-table">
            <div 
              v-for="category in Object.keys(rankings.category_rankings)" 
              :key="category"
              class="ranking-row"
            >
              <span class="category">{{ categoryLabels[category] }}</span>
              <span class="rank">#{{ rankings.category_rankings[category] }}</span>
              <div class="progress-bar">
                <div 
                  class="progress-fill"
                  :style="{ width: getRankPercentage(category) + '%' }"
                ></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 进化轨迹 -->
      <div class="evolution-section">
        <div class="section-header">
          <h2>进化轨迹</h2>
          <button class="btn-text" @click="viewFullTimeline">
            查看完整历史 <span class="icon">→</span>
          </button>
        </div>
        <div class="timeline">
          <div 
            v-for="(event, index) in evolutionTimeline.slice(-5)" 
            :key="index"
            class="timeline-item"
            :class="{ 'milestone': event.type === 'milestone' }"
          >
            <div class="timeline-marker"></div>
            <div class="timeline-content">
              <div class="timeline-date">{{ formatDate(event.date) }}</div>
              <div class="timeline-event">{{ event.event }}</div>
              <div v-if="event.stage_change" class="stage-change">
                阶段 {{ event.stage_change.from }} → {{ event.stage_change.to }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 影响力地图 -->
      <div class="influence-section">
        <h2>世界影响详情</h2>
        <div class="influence-grid">
          <InfluenceCard 
            v-for="area in influenceAreas" 
            :key="area.id"
            :title="area.title"
            :score="area.score"
            :metrics="area.metrics"
            :color="area.color"
            :icon="area.icon"
          />
        </div>
      </div>

      <!-- 快速操作 -->
      <div class="quick-actions">
        <h3>快速操作</h3>
        <div class="action-buttons">
          <button 
            v-for="action in quickActions" 
            :key="action.id"
            class="action-btn"
            :class="`action-${action.id}`"
            @click="performAction(action.id)"
          >
            <span class="action-icon">{{ action.icon }}</span>
            <span class="action-label">{{ action.label }}</span>
          </button>
        </div>
      </div>

      <!-- 通知中心 -->
      <div class="notifications-section" v-if="notifications.length > 0">
        <div class="notifications-header">
          <h3>通知中心</h3>
          <span class="notification-count">{{ notifications.length }}</span>
        </div>
        <div class="notifications-list">
          <div 
            v-for="(notification, index) in notifications.slice(0, 3)" 
            :key="index"
            class="notification"
            :class="`notification-${notification.type}`"
          >
            <div class="notification-icon">{{ notification.icon }}</div>
            <div class="notification-content">
              <div class="notification-title">{{ notification.title }}</div>
              <div class="notification-message">{{ notification.message }}</div>
              <div class="notification-time">{{ notification.time }}</div>
            </div>
            <button class="notification-dismiss" @click="dismissNotification(index)">×</button>
          </div>
        </div>
      </div>
    </main>

    <!-- 详细面板模态框 -->
    <div v-if="activeDetail" class="modal-overlay" @click="closeDetail">
      <div class="modal-content" @click.stop>
        <DetailPanel 
          :type="activeDetail"
          :data="getDetailData(activeDetail)"
          @close="closeDetail"
        />
      </div>
    </div>

    <!-- 设置面板 -->
    <div v-if="showSettingsPanel" class="modal-overlay" @click="hideSettings">
      <div class="modal-content settings-panel" @click.stop>
        <SettingsPanel 
          :profile="userProfile"
          @save="updateSettings"
          @close="hideSettings"
        />
      </div>
    </div>

    <!-- 移动端底部导航栏 -->
    <nav class="mobile-tab-bar" v-if="isMobile">
      <div 
        v-for="tab in mobileTabs" 
        :key="tab.id"
        class="tab-item"
        :class="{ 'active': activeTab === tab.id }"
        @click="switchTab(tab.id)"
      >
        <span class="tab-icon">{{ tab.icon }}</span>
        <span class="tab-label">{{ tab.label }}</span>
      </div>
    </nav>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import MetricCard from '/@/components/app/MetricCard.vue'
import InfluenceCard from '/@/components/app/InfluenceCard.vue'
import DetailPanel from '/@/components/app/DetailPanel.vue'
import SettingsPanel from '/@/components/app/SettingsPanel.vue'

// 类型定义
interface UserProfile {
  id: string
  name: string
  avatar: string
  current_stage: number
  join_date: string
  milestones: string[]
  preferences: {
    privacy_level: string
    data_sharing: string[]
    notification_settings: Record<string, any>
  }
}

interface HealthMetrics {
  vital_signs: {
    hrv: number
    resting_hr: number
    blood_pressure: string
    vo2_max: number
  }
  biomarkers: {
    telomere_length: number
    inflammatory_markers: Record<string, number>
    hormone_levels: Record<string, number>
  }
  enhancements: {
    implants: string[]
    therapies: string[]
    supplements: string[]
  }
}

interface CognitiveMetrics {
  memory: {
    working_memory: number
    long_term_recall: number
  }
  processing: {
    reaction_time: number
    decision_speed: number
  }
  enhancements: {
    bci_integration: number
    nootropic_usage: string
  }
}

interface Rankings {
  global: number
  regional: number
  by_stage: number
  trend: string
  trend_change: string
  percentile: number
  category_rankings: Record<string, number>
}

interface TimelineEvent {
  date: string
  event: string
  type: 'event' | 'milestone'
  stage_change?: {
    from: number
    to: number
  }
}

interface Notification {
  id: string
  type: 'info' | 'warning' | 'achievement' | 'community'
  title: string
  message: string
  time: string
  icon: string
  read: boolean
}

// 模拟数据
const userProfile = ref<UserProfile>({
  id: 'transhuman_001',
  name: 'Alex Chen',
  avatar: 'AC',
  current_stage: 3,
  join_date: '2023-06-15',
  milestones: [
    'first_implant',
    'bci_integration',
    'gene_optimization'
  ],
  preferences: {
    privacy_level: 'community',
    data_sharing: ['health', 'cognitive', 'progress'],
    notification_settings: {
      daily_summary: true,
      milestone_alerts: true,
      community_updates: true
    }
  }
})

const healthMetrics = ref<HealthMetrics>({
  vital_signs: {
    hrv: 68,
    resting_hr: 58,
    blood_pressure: '118/75',
    vo2_max: 42
  },
  biomarkers: {
    telomere_length: 7.2,
    inflammatory_markers: {
      crp: 0.8,
      il6: 2.1
    },
    hormone_levels: {
      testosterone: 650,
      cortisol: 12.5,
      dhea: 320
    }
  },
  enhancements: {
    implants: ['cochlear_enhanced', 'retinal_display'],
    therapies: ['gene_editing', 'stem_cell'],
    supplements: ['nootropic_stack', 'nad_boosters']
  }
})

const cognitiveMetrics = ref<CognitiveMetrics>({
  memory: {
    working_memory: 8.5,
    long_term_recall: 92
  },
  processing: {
    reaction_time: 180,
    decision_speed: 4.2
  },
  enhancements: {
    bci_integration: 0.75,
    nootropic_usage: 'advanced'
  }
})

const rankings = ref<Rankings>({
  global: 15423,
  regional: 842,
  by_stage: 156,
  trend: 'up',
  trend_change: '+245',
  percentile: 92.5,
  category_rankings: {
    health: 1234,
    cognitive: 876,
    enhancement: 542,
    contribution: 1987,
    resources: 2103
  }
})

const evolutionTimeline = ref<TimelineEvent[]>([
  {
    date: '2023-06-15',
    event: '加入超人类主义社区',
    type: 'milestone',
    stage_change: { from: 0, to: 1 }
  },
  {
    date: '2023-08-20',
    event: '完成首次全面基因测序',
    type: 'milestone'
  },
  {
    date: '2023-11-05',
    event: '植入增强型人工耳蜗',
    type: 'milestone',
    stage_change: { from: 1, to: 2 }
  },
  {
    date: '2024-01-15',
    event: '开始使用脑机接口训练',
    type: 'event'
  },
  {
    date: '2024-03-10',
    event: '基因编辑治疗完成',
    type: 'milestone',
    stage_change: { from: 2, to: 3 }
  },
  {
    date: '2024-04-22',
    event: '贡献开源神经接口代码',
    type: 'event'
  },
  {
    date: '2024-05-30',
    event: '视网膜显示增强激活',
    type: 'milestone'
  }
])

const notifications = ref<Notification[]>([
  {
    id: '1',
    type: 'achievement',
    title: '新成就解锁！',
    message: '达到认知增强等级 5',
    time: '2小时前',
    icon: '🏆',
    read: false
  },
  {
    id: '2',
    type: 'community',
    title: '社区活动',
    message: '脑机接口研讨会即将开始',
    time: '5小时前',
    icon: '👥',
    read: false
  },
  {
    id: '3',
    type: 'warning',
    title: '健康提醒',
    message: '建议进行季度生物标记物检测',
    time: '1天前',
    icon: '⚠️',
    read: false
  }
])

// 计算属性
const evolutionDays = computed(() => {
  const joinDate = new Date(userProfile.value.join_date)
  const today = new Date()
  const diffTime = Math.abs(today.getTime() - joinDate.getTime())
  return Math.ceil(diffTime / (1000 * 60 * 60 * 24))
})

const userStageClass = computed(() => `stage-${userProfile.value.current_stage}`)

const coreMetrics = computed(() => [
  {
    id: 'health',
    title: '健康指数',
    value: 92,
    unit: '/100',
    trend: 'up',
    change: '+1.2',
    color: 'green',
    icon: '💚'
  },
  {
    id: 'cognitive',
    title: '认知分数',
    value: 88,
    unit: '/100',
    trend: 'up',
    change: '+0.8',
    color: 'blue',
    icon: '🧠'
  },
  {
    id: 'enhancement',
    title: '智能融合度',
    value: 75,
    unit: '%',
    trend: 'up',
    change: '+2.5',
    color: 'purple',
    icon: '⚡'
  },
  {
    id: 'resources',
    title: '资源评分',
    value: 8100,
    unit: '点',
    trend: 'stable',
    change: '+150',
    color: 'orange',
    icon: '💰'
  },
  {
    id: 'contribution',
    title: '贡献状态',
    value: 95,
    unit: '/100',
    trend: 'up',
    change: '+3.2',
    color: 'teal',
    icon: '🌍'
  }
])

const trendIcon = computed(() => {
  switch (rankings.value.trend) {
    case 'up': return '📈'
    case 'down': return '📉'
    case 'stable': return '➡️'
    default: return '📊'
  }
})

const stageNames = [
  '传统人类', '基础增强', '认知增强', '身体增强', 
  '智能融合', '分布式意识', '后人类'
]

const stageDescriptions = [
  '无技术增强的基础人类状态',
  '使用可穿戴设备和健康监测',
  '认知增强和记忆辅助',
  '仿生器官和生理增强',
  '脑机接口和神经增强',
  '意识备份和分布式存在',
  '完全数字化和超越生物限制'
]

const influenceAreas = computed(() => [
  {
    id: 'technical',
    title: '技术影响',
    score: 85,
    icon: '🔧',
    color: 'blue',
    metrics: [
      { label: '开源贡献', value: 24 },
      { label: '专利数量', value: 3 },
      { label: '技术传播', value: 1200 }
    ]
  },
  {
    id: 'knowledge',
    title: '知识影响',
    score: 72,
    icon: '📚',
    color: 'green',
    metrics: [
      { label: '论文引用', value: 48 },
      { label: '教程访问', value: 8500 },
      { label: '演讲影响', value: 12 }
    ]
  },
  {
    id: 'community',
    title: '社区影响',
    score: 91,
    icon: '👥',
    color: 'orange',
    metrics: [
      { label: '社区建设', value: 5 },
      { label: '成员指导', value: 18 },
      { label: '活动组织', value: 9 }
    ]
  },
  {
    id: 'cultural',
    title: '文化影响',
    score: 65,
    icon: '🎨',
    color: 'purple',
    metrics: [
      { label: '思想传播', value: 320 },
      { label: '媒体报道', value: 7 },
      { label: '公众认知', value: 12500 }
    ]
  }
])

const quickActions = [
  { id: 'data', label: '记录数据', icon: '📊' },
  { id: 'challenge', label: '接受挑战', icon: '🎯' },
  { id: 'share', label: '分享进展', icon: '📤' },
  { id: 'community', label: '社区互动', icon: '💬' },
  { id: 'analysis', label: '详细分析', icon: '🔍' }
]

const categoryLabels: Record<string, string> = {
  health: '身体健康',
  cognitive: '意识认知',
  enhancement: '智能化进度',
  contribution: '参与贡献',
  resources: '资源状态'
}

// 响应式状态
const activeDetail = ref<string | null>(null)
const showSettingsPanel = ref(false)

// 移动端状态
const activeTab = ref('overview')
const isMobile = ref(false)

// 移动端标签配置
const mobileTabs = [
  { id: 'overview', label: '概览', icon: '🏠' },
  { id: 'metrics', label: '指标', icon: '📊' },
  { id: 'ranking', label: '排名', icon: '🏆' },
  { id: 'evolution', label: '进化', icon: '🧬' },
  { id: 'influence', label: '影响', icon: '🌍' }
]

// 方法
const formatDate = (dateString: string): string => {
  const date = new Date(dateString)
  return date.toLocaleDateString('zh-CN', { 
    year: 'numeric', 
    month: 'short', 
    day: 'numeric' 
  })
}

const viewStageInfo = (stage: number) => {
  alert(`阶段 ${stage}: ${stageNames[stage-1]}\n\n${stageDescriptions[stage-1]}`)
}

const viewDetail = (metricId: string) => {
  activeDetail.value = metricId
}

const closeDetail = () => {
  activeDetail.value = null
}

const getDetailData = (type: string) => {
  switch (type) {
    case 'health':
      return healthMetrics.value
    case 'cognitive':
      return cognitiveMetrics.value
    case 'enhancement':
      return { ...healthMetrics.value.enhancements, ...cognitiveMetrics.value.enhancements }
    case 'resources':
      return { score: 8100, trend: 'up' }
    case 'contribution':
      return influenceAreas.value
    default:
      return {}
  }
}

const getRankPercentage = (category: string): number => {
  const rank = rankings.value.category_rankings[category]
  // 假设总用户数为100000，计算百分位
  return Math.min(100, Math.max(0, (1 - rank / 100000) * 100))
}

const refreshData = () => {
  // 模拟数据刷新
  rankings.value.global += Math.floor(Math.random() * 100) - 50
  rankings.value.trend_change = `+${Math.floor(Math.random() * 100)}`
  
  // 显示刷新提示
  const notification: Notification = {
    id: Date.now().toString(),
    type: 'info',
    title: '数据已刷新',
    message: '所有指标已更新到最新状态',
    time: '刚刚',
    icon: '🔄',
    read: false
  }
  notifications.value.unshift(notification)
}

const showSettings = () => {
  showSettingsPanel.value = true
}

const hideSettings = () => {
  showSettingsPanel.value = false
}

const updateSettings = (newSettings: any) => {
  userProfile.value.preferences = newSettings
  hideSettings()
}

const performAction = (actionId: string) => {
  const actions: Record<string, () => void> = {
    data: () => alert('打开数据记录界面'),
    challenge: () => alert('查看可用挑战'),
    share: () => alert('分享你的进化进展'),
    community: () => alert('进入社区论坛'),
    analysis: () => alert('运行深度分析')
  }
  actions[actionId]?.()
}

const viewFullTimeline = () => {
  activeDetail.value = 'timeline'
}

const dismissNotification = (index: number) => {
  notifications.value.splice(index, 1)
}

// 移动端方法
const switchTab = (tabId: string) => {
  activeTab.value = tabId
}

const checkMobile = () => {
  isMobile.value = window.innerWidth <= 768
}

// 生命周期
onMounted(() => {
  console.log('超人类主义面板已加载')
  checkMobile()
  window.addEventListener('resize', checkMobile)
  window.addEventListener('beforeunload', () => {
    console.log('超人类主义面板即将卸载')
  })
})
</script>

<style scoped>
.transhuman-dashboard {
  min-height: 100vh;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a2e 100%);
  color: #e0e0e0;
  font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
}

/* 导航栏样式 */
.dashboard-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 2rem;
  background: rgba(26, 26, 46, 0.9);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.nav-left, .nav-right {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.brand {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.logo {
  font-size: 2rem;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.7; }
}

h1 {
  font-size: 1.5rem;
  background: linear-gradient(90deg, #00d4ff, #0088ff);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  font-weight: 700;
}

.nav-status {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.25rem 0.75rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 1rem;
}

.status-indicator {
  width: 8px;
  height: 8px;
  border-radius: 50%;
}

.status-indicator.stage-1 { background: #4CAF50; }
.status-indicator.stage-2 { background: #2196F3; }
.status-indicator.stage-3 { background: #9C27B0; }
.status-indicator.stage-4 { background: #FF9800; }
.status-indicator.stage-5 { background: #00BCD4; }
.status-indicator.stage-6 { background: #E91E63; }
.status-indicator.stage-7 { background: #FFEB3B; }

.btn-icon {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  padding: 0.5rem;
  cursor: pointer;
  color: inherit;
  transition: all 0.3s ease;
}

.btn-icon:hover {
  background: rgba(255, 255, 255, 0.1);
  transform: translateY(-2px);
}

.avatar {
  width: 36px;
  height: 36px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  color: white;
}

/* 主内容区 */
.dashboard-main {
  padding: 2rem;
  max-width: 1400px;
  margin: 0 auto;
}

.overview-section {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
  margin-bottom: 2rem;
}

.welcome-card {
  background: rgba(26, 26, 46, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 1.5rem;
}

.welcome-card h2 {
  font-size: 1.75rem;
  margin-bottom: 0.5rem;
  background: linear-gradient(90deg, #fff, #a0a0ff);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}

.subtitle {
  color: #a0a0a0;
  margin-bottom: 1rem;
}

.milestone-tags {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.tag {
  background: rgba(0, 212, 255, 0.1);
  color: #00d4ff;
  padding: 0.25rem 0.75rem;
  border-radius: 1rem;
  font-size: 0.875rem;
  border: 1px solid rgba(0, 212, 255, 0.3);
}

.stage-progress {
  background: rgba(26, 26, 46, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 1.5rem;
}

.stage-bar {
  display: flex;
  margin: 1rem 0;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  overflow: hidden;
}

.stage-segment {
  flex: 1;
  text-align: center;
  padding: 0.75rem 0.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
}

.stage-segment:hover {
  background: rgba(255, 255, 255, 0.1);
}

.stage-segment.completed {
  background: linear-gradient(135deg, rgba(0, 212, 255, 0.3), rgba(0, 136, 255, 0.3));
}

.stage-segment.current {
  background: linear-gradient(135deg, rgba(0, 212, 255, 0.5), rgba(0, 136, 255, 0.5));
}

.stage-number {
  display: block;
  font-size: 1.25rem;
  font-weight: bold;
  margin-bottom: 0.25rem;
}

.stage-name {
  font-size: 0.75rem;
  opacity: 0.8;
}

/* 指标网格 */
.metrics-section {
  margin-bottom: 2rem;
}

.section-title {
  font-size: 1.5rem;
  margin-bottom: 1rem;
  color: white;
}

.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
}

/* 排名面板 */
.ranking-section {
  display: grid;
  grid-template-columns: 1fr 2fr;
  gap: 2rem;
  margin-bottom: 2rem;
}

.ranking-card {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  padding: 1.5rem;
  color: white;
}

.ranking-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.ranking-trend {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.25rem 0.75rem;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 1rem;
}

.ranking-trend.trend-up {
  background: rgba(76, 175, 80, 0.3);
  color: #4CAF50;
}

.ranking-number {
  text-align: center;
  margin-bottom: 1rem;
}

.global-rank {
  font-size: 3rem;
  font-weight: bold;
  display: block;
}

.percentile {
  font-size: 1rem;
  opacity: 0.9;
}

.ranking-breakdown {
  display: flex;
  justify-content: space-around;
  gap: 1rem;
}

.breakdown-item {
  text-align: center;
}

.breakdown-item .label {
  display: block;
  font-size: 0.875rem;
  opacity: 0.8;
  margin-bottom: 0.25rem;
}

.breakdown-item .value {
  font-size: 1.25rem;
  font-weight: bold;
}

.ranking-details {
  background: rgba(26, 26, 46, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 1.5rem;
}

.ranking-table {
  margin-top: 1rem;
}

.ranking-row {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.75rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.ranking-row:last-child {
  border-bottom: none;
}

.category {
  flex: 1;
  color: #a0a0a0;
}

.rank {
  width: 60px;
  text-align: right;
}

.progress-bar {
  flex: 2;
  height: 8px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 4px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #00d4ff, #0088ff);
  border-radius: 4px;
}

/* 进化轨迹 */
.evolution-section {
  background: rgba(26, 26, 46, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 1.5rem;
  margin-bottom: 2rem;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.btn-text {
  background: none;
  border: none;
  color: #00d4ff;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.875rem;
}

.timeline {
  position: relative;
  padding-left: 2rem;
}

.timeline::before {
  content: '';
  position: absolute;
  left: 1rem;
  top: 0;
  bottom: 0;
  width: 2px;
  background: rgba(255, 255, 255, 0.2);
}

.timeline-item {
  position: relative;
  margin-bottom: 1.5rem;
}

.timeline-marker {
  position: absolute;
  left: -2rem;
  top: 0.25rem;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.5);
  border: 2px solid rgba(26, 26, 46, 0.6);
}

.timeline-item.milestone .timeline-marker {
  background: #00d4ff;
  box-shadow: 0 0 0 4px rgba(0, 212, 255, 0.2);
}

.timeline-content {
  background: rgba(255, 255, 255, 0.05);
  padding: 1rem;
  border-radius: 8px;
  border-left: 3px solid rgba(0, 212, 255, 0.5);
}

.timeline-date {
  color: #00d4ff;
  font-size: 0.875rem;
  margin-bottom: 0.25rem;
}

.timeline-event {
  font-weight: 500;
}

.stage-change {
  display: inline-block;
  margin-top: 0.5rem;
  padding: 0.25rem 0.75rem;
  background: rgba(0, 212, 255, 0.1);
  color: #00d4ff;
  border-radius: 1rem;
  font-size: 0.75rem;
}

/* 影响力网格 */
.influence-section {
  margin-bottom: 2rem;
}

.influence-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1rem;
}

/* 快速操作 */
.quick-actions {
  background: rgba(26, 26, 46, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 1.5rem;
  margin-bottom: 2rem;
}

.action-buttons {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  gap: 1rem;
}

.action-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  color: inherit;
  cursor: pointer;
  transition: all 0.3s ease;
}

.action-btn:hover {
  background: rgba(255, 255, 255, 0.1);
  transform: translateY(-2px);
  border-color: rgba(0, 212, 255, 0.5);
}

.action-icon {
  font-size: 1.5rem;
}

.action-label {
  font-size: 0.875rem;
}

/* 通知中心 */
.notifications-section {
  background: rgba(26, 26, 46, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 1.5rem;
}

.notifications-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.notification-count {
  background: #00d4ff;
  color: #0a0a0a;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.75rem;
  font-weight: bold;
}

.notifications-list {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.notification {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  border-left: 4px solid;
}

.notification-achievement {
  border-left-color: #FFD700;
}

.notification-community {
  border-left-color: #00BCD4;
}

.notification-warning {
  border-left-color: #FF9800;
}

.notification-info {
  border-left-color: #4CAF50;
}

.notification-icon {
  font-size: 1.25rem;
}

.notification-content {
  flex: 1;
}

.notification-title {
  font-weight: 500;
  margin-bottom: 0.25rem;
}

.notification-message {
  font-size: 0.875rem;
  color: #a0a0a0;
  margin-bottom: 0.25rem;
}

.notification-time {
  font-size: 0.75rem;
  color: #666;
}

.notification-dismiss {
  background: none;
  border: none;
  color: #666;
  cursor: pointer;
  font-size: 1.25rem;
  padding: 0;
  width: 24px;
  height: 24px;
}

.notification-dismiss:hover {
  color: #ff4444;
}

/* 模态框 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(4px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: #1a1a2e;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  max-width: 800px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
}

.settings-panel {
  padding: 2rem;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .overview-section,
  .ranking-section {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .dashboard-main {
    padding: 1rem;
    padding-bottom: 5rem; /* 为底部导航栏留空间 */
  }
  
  .metrics-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .influence-grid {
    grid-template-columns: 1fr;
  }

  /* 移动端底部导航栏样式 */
  .mobile-tab-bar {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    background: rgba(26, 26, 46, 0.95);
    backdrop-filter: blur(10px);
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    display: flex;
    justify-content: space-around;
    padding: 0.5rem 0;
    z-index: 1000;
  }

  .tab-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.25rem;
    padding: 0.5rem 1rem;
    cursor: pointer;
    transition: all 0.3s ease;
    border-radius: 8px;
    min-width: 60px;
  }

  .tab-item:hover {
    background: rgba(255, 255, 255, 0.05);
  }

  .tab-item.active {
    background: rgba(0, 212, 255, 0.1);
  }

  .tab-item.active .tab-icon {
    transform: scale(1.1);
  }

  .tab-item.active .tab-label {
    color: #00d4ff;
  }

  .tab-icon {
    font-size: 1.25rem;
    transition: transform 0.3s ease;
  }

  .tab-label {
    font-size: 0.75rem;
    color: #a0a0a0;
    transition: color 0.3s ease;
  }

  /* 移动端内容区域切换 */
  .dashboard-main.mobile-tab-active .overview-section,
  .dashboard-main.mobile-tab-active .metrics-section,
  .dashboard-main.mobile-tab-active .ranking-section,
  .dashboard-main.mobile-tab-active .evolution-section,
  .dashboard-main.mobile-tab-active .influence-section {
    display: none;
  }

  /* 根据活动标签显示对应内容 */
  .dashboard-main.mobile-tab-active .overview-section {
    display: block;
  }

  .dashboard-main.mobile-tab-active[data-active-tab="metrics"] .metrics-section {
    display: block;
  }

  .dashboard-main.mobile-tab-active[data-active-tab="ranking"] .ranking-section {
    display: block;
  }

  .dashboard-main.mobile-tab-active[data-active-tab="evolution"] .evolution-section {
    display: block;
  }

  .dashboard-main.mobile-tab-active[data-active-tab="influence"] .influence-section {
    display: block;
  }
}

@media (max-width: 480px) {
  .metrics-grid {
    grid-template-columns: 1fr;
  }
  
  .action-buttons {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .dashboard-nav {
    padding: 1rem;
  }
  
  h1 {
    font-size: 1.25rem;
  }
}
</style>