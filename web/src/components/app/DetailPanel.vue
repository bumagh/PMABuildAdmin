<template>
  <div class="detail-panel">
    <div class="detail-header">
      <div class="header-left">
        <span class="detail-icon">{{ panelIcon }}</span>
        <h2>{{ panelTitle }}</h2>
      </div>
      <button class="btn-close" @click="$emit('close')">×</button>
    </div>

    <div class="detail-content">
      <!-- 健康详情 -->
      <div v-if="type === 'health'" class="health-detail">
        <div class="detail-section">
          <h3>基础生理指标</h3>
          <div class="metrics-grid">
            <MetricBox 
              v-for="metric in vitalMetrics" 
              :key="metric.name"
              :name="metric.name"
              :value="metric.value"
              :unit="metric.unit"
              :status="metric.status"
              :trend="metric.trend"
            />
          </div>
        </div>

        <div class="detail-section">
          <h3>生物标记物</h3>
          <div class="metrics-grid">
            <MetricBox 
              v-for="marker in biomarkers" 
              :key="marker.name"
              :name="marker.name"
              :value="marker.value"
              :unit="marker.unit"
              :status="marker.status"
              :description="marker.description"
            />
          </div>
        </div>

        <div class="detail-section">
          <h3>增强设备</h3>
          <div class="enhancements-list">
            <div v-for="implant in data?.implants || []" :key="implant" class="enhancement-item">
              <div class="enhancement-icon">⚡</div>
              <div class="enhancement-info">
                <div class="enhancement-name">{{ getImplantName(implant) }}</div>
                <div class="enhancement-status">
                  <span class="status-dot status-active"></span>
                  <span class="status-text">在线</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="detail-section">
          <h3>健康趋势</h3>
          <div class="chart-container">
            <div class="chart-placeholder">
              <div class="chart-line" v-for="i in 5" :key="i" :style="getChartLineStyle(i)"></div>
              <div class="chart-points">
                <div 
                  v-for="(point, index) in healthTrend" 
                  :key="index"
                  class="chart-point"
                  :style="{ left: (index * 20) + '%', bottom: (point / 100) * 100 + '%' }"
                ></div>
              </div>
              <div class="chart-axis">
                <span v-for="(label, index) in ['1月', '2月', '3月', '4月', '5月']" 
                      :key="label"
                      :style="{ left: (index * 20) + '%' }"
                      class="axis-label">
                  {{ label }}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 认知详情 -->
      <div v-else-if="type === 'cognitive'" class="cognitive-detail">
        <div class="detail-section">
          <h3>认知能力评估</h3>
          <div class="cognitive-metrics">
            <div class="radar-chart">
              <div class="radar-grid" v-for="i in 5" :key="i"></div>
              <div 
                v-for="(score, index) in cognitiveScores" 
                :key="index"
                class="radar-point"
                :style="getRadarPointStyle(index, score)"
              ></div>
              <div class="radar-labels">
                <div 
                  v-for="(label, index) in cognitiveLabels" 
                  :key="label"
                  class="radar-label"
                  :style="getRadarLabelStyle(index)"
                >
                  {{ label }}
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="detail-section">
          <h3>详细分数</h3>
          <div class="score-breakdown">
            <div v-for="score in cognitiveScoresDetailed" :key="score.name" class="score-item">
              <div class="score-name">{{ score.name }}</div>
              <div class="score-bar">
                <div 
                  class="score-fill" 
                  :style="{ width: score.value + '%' }"
                  :class="`score-${score.status}`"
                ></div>
              </div>
              <div class="score-value">{{ score.value }}</div>
            </div>
          </div>
        </div>

        <div class="detail-section">
          <h3>脑机接口状态</h3>
          <div class="bci-status">
            <div class="bci-metric">
              <div class="bci-label">连接强度</div>
              <div class="bci-value">{{ (data?.bci_integration * 100).toFixed(1) }}%</div>
              <div class="bci-progress">
                <div 
                  class="bci-progress-fill" 
                  :style="{ width: (data?.bci_integration * 100) + '%' }"
                ></div>
              </div>
            </div>
            <div class="bci-stats">
              <div class="stat-item">
                <div class="stat-label">数据速率</div>
                <div class="stat-value">245 Mbps</div>
              </div>
              <div class="stat-item">
                <div class="stat-label">延迟</div>
                <div class="stat-value">12 ms</div>
              </div>
              <div class="stat-item">
                <div class="stat-label">稳定性</div>
                <div class="stat-value">98.5%</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 进化轨迹 -->
      <div v-else-if="type === 'timeline'" class="timeline-detail">
        <div class="timeline-full">
          <div 
            v-for="(event, index) in evolutionTimeline" 
            :key="index"
            class="timeline-event-full"
            :class="{ 'milestone': event.type === 'milestone' }"
          >
            <div class="timeline-marker-full">
              <div class="marker-circle"></div>
              <div class="marker-line" v-if="index !== evolutionTimeline.length - 1"></div>
            </div>
            <div class="timeline-content-full">
              <div class="event-date">{{ formatFullDate(event.date) }}</div>
              <div class="event-title">{{ event.event }}</div>
              <div v-if="event.stage_change" class="event-stage-change">
                <span class="stage-badge stage-from">{{ event.stage_change.from }}</span>
                <span class="stage-arrow">→</span>
                <span class="stage-badge stage-to">{{ event.stage_change.to }}</span>
              </div>
              <div class="event-description">{{ getEventDescription(event) }}</div>
            </div>
          </div>
        </div>
      </div>

      <!-- 增强详情 -->
      <div v-else-if="type === 'enhancement'" class="enhancement-detail">
        <div class="detail-section">
          <h3>增强状态总览</h3>
          <div class="enhancement-overview">
            <div class="overview-item">
              <div class="overview-icon">🧠</div>
              <div class="overview-content">
                <div class="overview-label">神经增强</div>
                <div class="overview-value">已激活</div>
              </div>
            </div>
            <div class="overview-item">
              <div class="overview-icon">💪</div>
              <div class="overview-content">
                <div class="overview-label">生理增强</div>
                <div class="overview-value">3/5 活跃</div>
              </div>
            </div>
            <div class="overview-item">
              <div class="overview-icon">🔧</div>
              <div class="overview-content">
                <div class="overview-label">机械增强</div>
                <div class="overview-value">2 个设备</div>
              </div>
            </div>
          </div>
        </div>

        <div class="detail-section">
          <h3>具体增强列表</h3>
          <div class="enhancement-list-detailed">
            <div v-for="enhancement in enhancementsList" :key="enhancement.id" class="enhancement-card">
              <div class="enhancement-header">
                <span class="enhancement-icon">{{ enhancement.icon }}</span>
                <span class="enhancement-name">{{ enhancement.name }}</span>
                <span class="enhancement-status" :class="`status-${enhancement.status}`">
                  {{ enhancement.statusText }}
                </span>
              </div>
              <div class="enhancement-description">{{ enhancement.description }}</div>
              <div class="enhancement-stats">
                <div v-for="stat in enhancement.stats" :key="stat.label" class="enhancement-stat">
                  <div class="stat-label">{{ stat.label }}</div>
                  <div class="stat-value">{{ stat.value }}</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 默认详情 -->
      <div v-else class="default-detail">
        <div class="detail-placeholder">
          <div class="placeholder-icon">🔍</div>
          <h3>详细数据分析</h3>
          <p>正在加载 {{ panelTitle }} 的详细数据...</p>
          <div class="placeholder-stats">
            <div v-for="(value, key) in data" :key="key" class="placeholder-stat">
              <div class="stat-key">{{ formatKey(key) }}</div>
              <div class="stat-value">{{ formatValue(value) }}</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="detail-footer">
      <button class="btn-secondary" @click="exportDetail">
        <span class="icon">📊</span>
        导出数据
      </button>
      <button class="btn-primary" @click="analyzeData">
        <span class="icon">🤖</span>
        AI分析
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, defineProps, defineEmits } from 'vue'
import MetricBox from './MetricBox.vue'

interface Props {
  type: string
  data?: any
}

const props = defineProps<Props>()
const emit = defineEmits(['close'])

// 面板标题和图标
const panelTitle = computed(() => {
  const titles: Record<string, string> = {
    'health': '健康详情',
    'cognitive': '认知详情',
    'timeline': '进化轨迹',
    'enhancement': '增强详情',
    'resources': '资源详情',
    'contribution': '贡献详情'
  }
  return titles[props.type] || '详细信息'
})

const panelIcon = computed(() => {
  const icons: Record<string, string> = {
    'health': '💚',
    'cognitive': '🧠',
    'timeline': '📅',
    'enhancement': '⚡',
    'resources': '💰',
    'contribution': '🌍'
  }
  return icons[props.type] || '📊'
})

// 健康指标数据
const vitalMetrics = computed(() => [
  { name: '心率变异性', value: props.data?.hrv || 68, unit: 'ms', status: 'excellent', trend: 'up' },
  { name: '静息心率', value: props.data?.resting_hr || 58, unit: 'bpm', status: 'good', trend: 'stable' },
  { name: '血压', value: props.data?.blood_pressure || '118/75', unit: 'mmHg', status: 'good', trend: 'stable' },
  { name: '最大摄氧量', value: props.data?.vo2_max || 42, unit: 'ml/kg/min', status: 'excellent', trend: 'up' }
])

const biomarkers = computed(() => [
  { name: '端粒长度', value: props.data?.telomere_length || 7.2, unit: 'kb', status: 'excellent', description: '细胞衰老指标' },
  { name: 'CRP', value: 0.8, unit: 'mg/L', status: 'good', description: '炎症指标' },
  { name: '睾酮', value: 650, unit: 'ng/dL', status: 'optimal', description: '激素水平' },
  { name: '皮质醇', value: 12.5, unit: 'μg/dL', status: 'good', description: '压力激素' }
])

// 健康趋势数据
const healthTrend = ref([85, 87, 88, 90, 92])

// 认知能力数据
const cognitiveScores = ref([85, 92, 78, 88, 95])
const cognitiveLabels = ['记忆力', '注意力', '处理速度', '创造力', '元认知']
const cognitiveScoresDetailed = computed(() => [
  { name: '工作记忆', value: props.data?.working_memory || 8.5, status: 'excellent' },
  { name: '长期记忆', value: props.data?.long_term_recall || 92, status: 'excellent' },
  { name: '反应时间', value: props.data?.reaction_time || 180, status: 'good' },
  { name: '决策速度', value: props.data?.decision_speed || 4.2, status: 'good' }
])

// 进化轨迹数据
const evolutionTimeline = ref([
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
    date: '2023-09-15',
    event: '开始使用认知增强补充剂',
    type: 'event'
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
    date: '2024-02-28',
    event: '完成首次神经反馈训练',
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

// 增强设备列表
const enhancementsList = ref([
  {
    id: 1,
    name: '增强型人工耳蜗',
    icon: '👂',
    status: 'active',
    statusText: '在线',
    description: '提供超人类听觉感知，可检测超声波和次声波',
    stats: [
      { label: '频率范围', value: '20Hz - 80kHz' },
      { label: '语音识别', value: '99.8%' },
      { label: '功耗', value: '2.5W' }
    ]
  },
  {
    id: 2,
    name: '视网膜显示增强',
    icon: '👁️',
    status: 'active',
    statusText: '在线',
    description: '增强现实覆盖，热成像视觉，夜视能力',
    stats: [
      { label: '分辨率', value: '8K' },
      { label: '刷新率', value: '240Hz' },
      { label: '延迟', value: '3ms' }
    ]
  },
  {
    id: 3,
    name: '脑机接口',
    icon: '🧠',
    status: 'partial',
    statusText: '训练中',
    description: '直接神经接口，思维控制设备',
    stats: [
      { label: '连接强度', value: '75%' },
      { label: '数据速率', value: '245Mbps' },
      { label: '精度', value: '92.5%' }
    ]
  },
  {
    id: 4,
    name: '生物芯片监测',
    icon: '💉',
    status: 'active',
    statusText: '监控中',
    description: '实时监测500+种生物标记物',
    stats: [
      { label: '监测频率', value: '实时' },
      { label: '准确率', value: '99.9%' },
      { label: '预警系统', value: '启用' }
    ]
  }
])

// 工具方法
const getImplantName = (implant: string) => {
  const names: Record<string, string> = {
    'cochlear_enhanced': '增强型人工耳蜗',
    'retinal_display': '视网膜显示增强'
  }
  return names[implant] || implant
}

const getChartLineStyle = (index: number) => {
  const height = 20 * index
  return {
    height: `${height}%`,
    bottom: '0'
  }
}

const getRadarPointStyle = (index: number, score: number) => {
  const angle = (index * 2 * Math.PI) / cognitiveLabels.length
  const radius = (score / 100) * 40
  const x = 50 + radius * Math.cos(angle - Math.PI / 2)
  const y = 50 + radius * Math.sin(angle - Math.PI / 2)
  return {
    left: `${x}%`,
    top: `${y}%`
  }
}

const getRadarLabelStyle = (index: number) => {
  const angle = (index * 2 * Math.PI) / cognitiveLabels.length
  const x = 50 + 60 * Math.cos(angle - Math.PI / 2)
  const y = 50 + 60 * Math.sin(angle - Math.PI / 2)
  return {
    left: `${x}%`,
    top: `${y}%`,
    transform: 'translate(-50%, -50%)'
  }
}

const formatFullDate = (dateString: string) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('zh-CN', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    weekday: 'long'
  })
}

const getEventDescription = (event: any) => {
  const descriptions: Record<string, string> = {
    '加入超人类主义社区': '开始了你的超人类进化旅程，建立基础健康档案',
    '完成首次全面基因测序': '获取了完整的基因组数据，识别了潜在的优化位点',
    '植入增强型人工耳蜗': '获得了超越人类的听觉感知能力',
    '基因编辑治疗完成': '优化了特定基因表达，增强了细胞修复能力',
    '视网膜显示增强激活': '获得增强现实视觉能力，可直接查看数字信息覆盖'
  }
  return descriptions[event.event] || '这是一个重要的进化里程碑'
}

const formatKey = (key: string | number) => {
  const keyStr = String(key)
  return keyStr.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase())
}

const formatValue = (value: any) => {
  if (typeof value === 'object') {
    return JSON.stringify(value, null, 2)
  }
  return value
}

// 操作方法
const exportDetail = () => {
  const exportData = {
    type: props.type,
    data: props.data,
    export_date: new Date().toISOString()
  }
  
  const dataStr = JSON.stringify(exportData, null, 2)
  const dataBlob = new Blob([dataStr], { type: 'application/json' })
  const url = URL.createObjectURL(dataBlob)
  
  const link = document.createElement('a')
  link.href = url
  link.download = `${props.type}_detail_${new Date().getTime()}.json`
  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
  URL.revokeObjectURL(url)
  
  alert('详细数据导出成功！')
}

const analyzeData = () => {
  alert('正在使用AI分析数据...')
  // 这里可以添加实际的AI分析逻辑
}
</script>

<style scoped>
.detail-panel {
  background: #1a1a2e;
  color: #e0e0e0;
  border-radius: 16px;
  overflow: hidden;
  max-height: 90vh;
  display: flex;
  flex-direction: column;
  width: 800px;
}

.detail-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem 2rem;
  background: rgba(0, 0, 0, 0.3);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.header-left {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.detail-icon {
  font-size: 2rem;
}

.detail-header h2 {
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

.detail-content {
  flex: 1;
  overflow-y: auto;
  padding: 2rem;
}

.detail-section {
  margin-bottom: 2rem;
}

.detail-section h3 {
  font-size: 1.125rem;
  margin-bottom: 1rem;
  color: white;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

/* 健康详情样式 */
.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
}

.enhancements-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.enhancement-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.enhancement-icon {
  font-size: 1.5rem;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 212, 255, 0.1);
  border-radius: 8px;
}

.enhancement-info {
  flex: 1;
}

.enhancement-name {
  display: block;
  font-weight: 500;
  color: white;
  margin-bottom: 0.25rem;
}

.enhancement-status {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
}

.status-active {
  background: #4CAF50;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.status-text {
  font-size: 0.875rem;
  color: #a0a0a0;
}

.chart-container {
  height: 200px;
  background: rgba(0, 0, 0, 0.3);
  border-radius: 12px;
  padding: 1rem;
  position: relative;
}

.chart-placeholder {
  width: 100%;
  height: 100%;
  position: relative;
}

.chart-line {
  position: absolute;
  width: 100%;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.chart-points {
  position: absolute;
  width: 100%;
  height: 100%;
}

.chart-point {
  position: absolute;
  width: 8px;
  height: 8px;
  background: #00d4ff;
  border-radius: 50%;
  transform: translate(-50%, 50%);
  border: 2px solid white;
}

.chart-axis {
  position: absolute;
  width: 100%;
  bottom: -2rem;
}

.axis-label {
  position: absolute;
  font-size: 0.75rem;
  color: #a0a0a0;
  transform: translateX(-50%);
}

/* 认知详情样式 */
.cognitive-metrics {
  display: flex;
  justify-content: center;
}

.radar-chart {
  width: 300px;
  height: 300px;
  position: relative;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.3);
}

.radar-grid {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 50%;
}

.radar-grid:nth-child(1) { width: 80%; height: 80%; }
.radar-grid:nth-child(2) { width: 60%; height: 60%; }
.radar-grid:nth-child(3) { width: 40%; height: 40%; }
.radar-grid:nth-child(4) { width: 20%; height: 20%; }
.radar-grid:nth-child(5) { width: 10%; height: 10%; }

.radar-point {
  position: absolute;
  width: 8px;
  height: 8px;
  background: #00d4ff;
  border-radius: 50%;
  transform: translate(-50%, -50%);
  border: 2px solid white;
}

.radar-labels {
  position: absolute;
  width: 100%;
  height: 100%;
}

.radar-label {
  position: absolute;
  font-size: 0.875rem;
  color: #a0a0a0;
}

.score-breakdown {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.score-item {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.score-name {
  width: 120px;
  font-size: 0.875rem;
  color: #e0e0e0;
}

.score-bar {
  flex: 1;
  height: 8px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 4px;
  overflow: hidden;
}

.score-fill {
  height: 100%;
  border-radius: 4px;
  transition: width 1s ease;
}

.score-excellent { background: linear-gradient(90deg, #4CAF50, #8BC34A); }
.score-good { background: linear-gradient(90deg, #2196F3, #03A9F4); }
.score-average { background: linear-gradient(90deg, #FF9800, #FFC107); }

.score-value {
  width: 40px;
  text-align: right;
  font-weight: 500;
}

.bci-status {
  display: grid;
  grid-template-columns: 1fr 2fr;
  gap: 2rem;
}

.bci-metric {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.bci-label {
  font-size: 0.875rem;
  color: #a0a0a0;
}

.bci-value {
  font-size: 2rem;
  font-weight: bold;
  color: white;
}

.bci-progress {
  height: 8px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 4px;
  overflow: hidden;
}

.bci-progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #9C27B0, #673AB7);
  border-radius: 4px;
}

.bci-stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}

.stat-item {
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 8px;
  text-align: center;
}

.stat-label {
  font-size: 0.75rem;
  color: #a0a0a0;
  margin-bottom: 0.25rem;
}

.stat-value {
  font-size: 1.25rem;
  font-weight: bold;
  color: white;
}

/* 进化轨迹样式 */
.timeline-full {
  position: relative;
  padding-left: 2rem;
}

.timeline-full::before {
  content: '';
  position: absolute;
  left: 1rem;
  top: 0;
  bottom: 0;
  width: 2px;
  background: linear-gradient(to bottom, #00d4ff, #0088ff);
}

.timeline-event-full {
  position: relative;
  margin-bottom: 2rem;
}

.timeline-marker-full {
  position: absolute;
  left: -2rem;
  top: 0;
}

.marker-circle {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  background: #00d4ff;
  border: 4px solid #1a1a2e;
  box-shadow: 0 0 0 2px rgba(0, 212, 255, 0.5);
}

.timeline-event-full.milestone .marker-circle {
  background: #FF9800;
  box-shadow: 0 0 0 2px rgba(255, 152, 0, 0.5);
}

.marker-line {
  position: absolute;
  top: 20px;
  left: 10px;
  width: 2px;
  height: calc(100% + 2rem);
  background: rgba(0, 212, 255, 0.3);
}

.timeline-content-full {
  margin-left: 2rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.event-date {
  color: #00d4ff;
  font-size: 0.875rem;
  margin-bottom: 0.5rem;
}

.event-title {
  font-size: 1.125rem;
  font-weight: 500;
  color: white;
  margin-bottom: 0.5rem;
}

.event-stage-change {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.5rem;
}

.stage-badge {
  padding: 0.25rem 0.75rem;
  border-radius: 1rem;
  font-size: 0.75rem;
  font-weight: bold;
}

.stage-from {
  background: rgba(255, 152, 0, 0.2);
  color: #FF9800;
}

.stage-to {
  background: rgba(0, 212, 255, 0.2);
  color: #00d4ff;
}

.stage-arrow {
  color: #a0a0a0;
}

.event-description {
  font-size: 0.875rem;
  color: #a0a0a0;
  line-height: 1.5;
}

/* 增强详情样式 */
.enhancement-overview {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}

.overview-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
}

.overview-icon {
  font-size: 1.5rem;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 212, 255, 0.1);
  border-radius: 8px;
}

.overview-label {
  font-size: 0.875rem;
  color: #a0a0a0;
  margin-bottom: 0.25rem;
}

.overview-value {
  font-size: 1.125rem;
  font-weight: 500;
  color: white;
}

.enhancement-list-detailed {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1rem;
}

.enhancement-card {
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.enhancement-header {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 0.75rem;
}

.enhancement-name {
  flex: 1;
  font-weight: 500;
  color: white;
}

.enhancement-status {
  padding: 0.25rem 0.5rem;
  border-radius: 1rem;
  font-size: 0.75rem;
  font-weight: 500;
}

.status-active {
  background: rgba(76, 175, 80, 0.2);
  color: #4CAF50;
}

.status-partial {
  background: rgba(255, 152, 0, 0.2);
  color: #FF9800;
}

.enhancement-description {
  font-size: 0.875rem;
  color: #a0a0a0;
  margin-bottom: 1rem;
  line-height: 1.5;
}

.enhancement-stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0.5rem;
}

.enhancement-stat {
  text-align: center;
  padding: 0.5rem;
  background: rgba(0, 0, 0, 0.3);
  border-radius: 6px;
}

.stat-label {
  font-size: 0.75rem;
  color: #a0a0a0;
  margin-bottom: 0.25rem;
}

.stat-value {
  font-size: 0.875rem;
  font-weight: 500;
  color: white;
}

/* 默认详情样式 */
.detail-placeholder {
  text-align: center;
  padding: 3rem 2rem;
}

.placeholder-icon {
  font-size: 4rem;
  margin-bottom: 1rem;
  opacity: 0.5;
}

.detail-placeholder h3 {
  font-size: 1.5rem;
  color: white;
  margin-bottom: 0.5rem;
}

.detail-placeholder p {
  color: #a0a0a0;
  margin-bottom: 2rem;
}

.placeholder-stats {
  max-width: 400px;
  margin: 0 auto;
}

.placeholder-stat {
  display: flex;
  justify-content: space-between;
  padding: 0.5rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.placeholder-stat:last-child {
  border-bottom: none;
}

.stat-key {
  color: #a0a0a0;
}

.stat-value {
  color: white;
  font-family: monospace;
}

/* 页脚样式 */
.detail-footer {
  display: flex;
  justify-content: flex-end;
  gap: 1rem;
  padding: 1.5rem 2rem;
  background: rgba(0, 0, 0, 0.3);
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.btn-secondary, .btn-primary {
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  border: none;
  cursor: pointer;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  transition: all 0.3s ease;
}

.btn-secondary {
  background: rgba(255, 255, 255, 0.1);
  color: #e0e0e0;
}

.btn-secondary:hover {
  background: rgba(255, 255, 255, 0.2);
}

.btn-primary {
  background: linear-gradient(90deg, #00d4ff, #0088ff);
  color: white;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 212, 255, 0.3);
}

/* 滚动条样式 */
.detail-content::-webkit-scrollbar {
  width: 8px;
}

.detail-content::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 4px;
}

.detail-content::-webkit-scrollbar-thumb {
  background: rgba(0, 212, 255, 0.5);
  border-radius: 4px;
}

.detail-content::-webkit-scrollbar-thumb:hover {
  background: rgba(0, 212, 255, 0.7);
}

@media (max-width: 768px) {
  .detail-panel {
    width: 95vw;
    max-height: 95vh;
  }
  
  .metrics-grid,
  .enhancement-overview,
  .bci-status {
    grid-template-columns: 1fr;
  }
  
  .bci-stats {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .enhancement-list-detailed {
    grid-template-columns: 1fr;
  }
  
  .detail-footer {
    flex-direction: column;
  }
  
  .btn-secondary, .btn-primary {
    width: 100%;
    justify-content: center;
  }
}
</style>