<!-- DecisionHelper.vue -->
<template>
  <div class="decision-helper">
    <!-- 首页：模板选择 -->
    <div v-if="currentView === 'home'" class="home-page">
      <div class="header">
        <h1>决策助手</h1>
        <div class="search-bar">
          <input 
            v-model="searchKeyword" 
            placeholder="搜索决策模板..."
            @input="filterTemplates"
          />
          <span class="search-icon">🔍</span>
        </div>
      </div>

      <div class="category-tabs">
        <button 
          v-for="category in categories" 
          :key="category.id"
          :class="{ active: currentCategory === category.id }"
          @click="switchCategory(category.id)"
        >
          {{ category.name }}
        </button>
      </div>

      <div class="templates-grid">
        <div 
          v-for="template in filteredTemplates" 
          :key="template.id"
          class="template-card"
          @click="selectTemplate(template)"
        >
          <div class="template-icon">{{ template.icon }}</div>
          <div class="template-info">
            <h3>{{ template.name }}</h3>
            <p>{{ template.description }}</p>
            <div class="template-stats">
              <span class="rating">⭐⭐⭐⭐⭐</span>
              <span class="usage">({{ template.usage }}次使用)</span>
            </div>
          </div>
        </div>
      </div>

      <div class="bottom-nav">
        <button @click="viewHistory">📜 历史决策</button>
        <button @click="viewLearn">📚 学习中心</button>
      </div>
    </div>

    <!-- 模板详情页 -->
    <div v-if="currentView === 'templateDetail'" class="template-detail-page">
      <div class="page-header">
        <button class="back-btn" @click="backToHome">←</button>
        <h2>{{ currentTemplate?.name }}</h2>
      </div>

      <div class="progress-steps">
        <div 
          v-for="(step, index) in decisionSteps" 
          :key="index"
          :class="['step', { active: currentStep >= index + 1 }]"
        >
          <span class="step-number">{{ step.number }}</span>
          <span class="step-title">{{ step.title }}</span>
        </div>
      </div>

      <!-- 步骤1：选项设置 -->
      <div v-if="currentStep === 1" class="step-content">
        <h3>🏘️ 选项设置</h3>
        <div class="options-list">
          <div 
            v-for="(option, index) in decisionOptions" 
            :key="index"
            class="option-card"
          >
            <div class="option-header">
              <input 
                v-model="option.name" 
                placeholder="选项名称"
                class="option-name"
              />
              <button 
                class="delete-btn"
                @click="removeOption(index)"
                v-if="decisionOptions.length > 2"
              >
                🗑️
              </button>
            </div>
            
            <div class="option-params">
              <div 
                v-for="param in currentTemplate?.parameters || []" 
                :key="param"
                class="param-input"
              >
                <label>{{ param }}:</label>
                <input 
                  v-model="option.params[param]"
                  :placeholder="getPlaceholder(param)"
                />
              </div>
            </div>
          </div>
        </div>
        
        <button class="add-btn" @click="addOption">
          + 添加新选项
        </button>
      </div>

      <!-- 步骤2：评价标准 -->
      <div v-if="currentStep === 2" class="step-content">
        <h3>⚖️ 评价标准</h3>
        <div class="criteria-list">
          <div 
            v-for="(criterion, index) in decisionCriteria" 
            :key="index"
            class="criterion-card"
          >
            <div class="criterion-header">
              <input 
                v-model="criterion.name" 
                placeholder="评价标准"
                class="criterion-name"
              />
              <span class="weight-value">{{ criterion.weight }}%</span>
            </div>
            
            <div class="weight-slider">
              <input 
                type="range" 
                min="0" 
                max="100" 
                v-model.number="criterion.weight"
                @input="recalculateWeights(index)"
                class="slider"
              />
              <div class="slider-track">
                <div 
                  class="slider-fill" 
                  :style="{ width: criterion.weight + '%' }"
                ></div>
              </div>
            </div>
            
            <div class="criterion-actions">
              <button 
                v-if="decisionCriteria.length > 2"
                @click="removeCriterion(index)"
                class="small-btn"
              >
                删除
              </button>
            </div>
          </div>
        </div>
        
        <div class="weight-summary">
          权重总和: {{ totalWeight }}%
          <span v-if="totalWeight !== 100" class="warning">
            (需要调整为100%)
          </span>
        </div>
        
        <button class="add-btn" @click="addCriterion">
          + 添加新标准
        </button>
      </div>

      <!-- 步骤3：评分 -->
      <div v-if="currentStep === 3" class="step-content">
        <h3>📊 为每个选项评分 (1-10分)</h3>
        
        <div class="scoring-mode">
          <button 
            :class="{ active: scoringMode === 'manual' }"
            @click="scoringMode = 'manual'"
          >
            手动评分
          </button>
          <button 
            :class="{ active: scoringMode === 'auto' }"
            @click="scoringMode = 'auto'"
          >
            自动评分
          </button>
        </div>

        <div class="scoring-table">
          <table>
            <thead>
              <tr>
                <th>选项</th>
                <th v-for="criterion in decisionCriteria" :key="criterion.name">
                  {{ criterion.name }}<br>
                  <small>({{ criterion.weight }}%)</small>
                </th>
                <th>总分</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(option, optionIndex) in decisionOptions" :key="optionIndex">
                <td class="option-cell">
                  <strong>{{ option.name }}</strong>
                  <div v-for="param in currentTemplate?.parameters || []" :key="param">
                    <small>{{ param }}: {{ option.params[param] }}</small>
                  </div>
                </td>
                
                <td 
                  v-for="(criterion, criterionIndex) in decisionCriteria" 
                  :key="criterionIndex"
                  class="score-cell"
                >
                  <div v-if="scoringMode === 'manual'">
                    <input 
                      type="number" 
                      min="1" 
                      max="10" 
                      v-model.number="scores[optionIndex][criterionIndex]"
                      @input="calculateScores"
                      class="score-input"
                    />
                  </div>
                  <div v-else class="auto-score">
                    {{ autoScore(option, criterionIndex) }}
                  </div>
                </td>
                
                <td class="total-score">
                  <strong>{{ optionScores[optionIndex]?.toFixed(1) || 0 }}</strong>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- 步骤4：结果分析 -->
      <div v-if="currentStep === 4" class="step-content">
        <h3>🏆 分析结果</h3>
        
        <div class="result-card">
          <div class="recommendation">
            <div class="recommendation-icon">🏆</div>
            <div class="recommendation-info">
              <h3>推荐选择: {{ topOption?.name }}</h3>
              <div class="score-display">
                综合得分: <span class="score">{{ topOptionScore?.toFixed(1) }}</span>/10
                <div class="stars">⭐⭐⭐⭐⭐</div>
              </div>
            </div>
          </div>
          
          <div class="result-details">
            <h4>优势分析:</h4>
            <ul>
              <li v-for="strength in topOptionStrengths" :key="strength">
                {{ strength }}
              </li>
            </ul>
          </div>
        </div>

        <!-- 图表展示 -->
        <div class="chart-container">
          <div class="chart-header">
            <h4>详细对比</h4>
            <div class="chart-switcher">
              <button 
                v-for="chartType in chartTypes" 
                :key="chartType"
                :class="{ active: currentChart === chartType }"
                @click="currentChart = chartType"
              >
                {{ chartType }}
              </button>
            </div>
          </div>
          
          <!-- 雷达图模拟 -->
          <div v-if="currentChart === '雷达图'" class="radar-chart">
            <div class="radar-grid">
              <div 
                v-for="(criterion, index) in decisionCriteria" 
                :key="criterion.name"
                class="radar-axis"
                :style="{ transform: `rotate(${360 / decisionCriteria.length * index}deg)` }"
              >
                <span class="axis-label">{{ criterion.name }}</span>
              </div>
              
              <!-- 绘制选项的多边形 -->
              <div 
                v-for="(option, optionIndex) in decisionOptions" 
                :key="optionIndex"
                class="radar-polygon"
                :style="getRadarPolygonStyle(optionIndex)"
              >
                <div class="option-label">{{ option.name }}</div>
              </div>
            </div>
          </div>
          
          <!-- 柱状图模拟 -->
          <div v-else-if="currentChart === '柱状图'" class="bar-chart">
            <div 
              v-for="(option, index) in decisionOptions" 
              :key="index"
              class="bar-container"
            >
              <div class="bar-label">{{ option.name }}</div>
              <div class="bar-wrapper">
                <div 
                  class="bar" 
                  :style="{ height: (optionScores[index] || 0) * 10 + '%' }"
                ></div>
                <span class="bar-value">{{ optionScores[index]?.toFixed(1) }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- 敏感性分析 -->
        <div class="sensitivity-section">
          <h4>🔍 敏感性分析</h4>
          <div class="sensitivity-controls">
            <label>调整权重查看结果变化:</label>
            <select v-model="selectedCriterion" @change="runSensitivityAnalysis">
              <option 
                v-for="criterion in decisionCriteria" 
                :key="criterion.name"
                :value="criterion.name"
              >
                {{ criterion.name }}
              </option>
            </select>
            
            <div class="sensitivity-slider">
              <span>权重: {{ sensitivityWeight }}%</span>
              <input 
                type="range" 
                min="0" 
                max="100" 
                v-model.number="sensitivityWeight"
                @input="runSensitivityAnalysis"
              />
            </div>
          </div>
          
          <div v-if="sensitivityResult" class="sensitivity-result">
            <p>如果<strong>{{ selectedCriterion }}</strong>的权重调整为<strong>{{ sensitivityWeight }}%</strong>:</p>
            <p>推荐选择变为: <strong>{{ sensitivityResult.recommended }}</strong></p>
          </div>
        </div>
      </div>

      <!-- 导航按钮 -->
      <div class="step-navigation">
        <button 
          v-if="currentStep > 1" 
          @click="prevStep"
          class="nav-btn secondary"
        >
          上一步
        </button>
        
        <button 
          v-if="currentStep < 4" 
          @click="nextStep"
          class="nav-btn primary"
          :disabled="!canProceed"
        >
          {{ currentStep === 3 ? '查看结果' : '下一步' }}
        </button>
        
        <div v-if="currentStep === 4" class="result-actions">
          <button @click="saveDecision" class="action-btn">
            💾 保存决策
          </button>
          <button @click="shareDecision" class="action-btn">
            📤 分享结果
          </button>
          <button @click="exportReport" class="action-btn">
            📄 导出报告
          </button>
        </div>
      </div>
    </div>

    <!-- 历史记录页 -->
    <div v-if="currentView === 'history'" class="history-page">
      <div class="page-header">
        <button class="back-btn" @click="backToHome">←</button>
        <h2>历史决策</h2>
      </div>
      
      <div class="history-list">
        <div 
          v-for="(record, index) in decisionHistory" 
          :key="index"
          class="history-card"
        >
          <div class="history-header">
            <span class="history-date">{{ record.date }}</span>
            <span class="history-template">{{ record.template }}</span>
          </div>
          <div class="history-result">
            选择了: <strong>{{ record.result }}</strong>
          </div>
          <div class="history-actions">
            <button @click="viewHistoryDetail(record)">查看</button>
            <button @click="deleteHistory(index)">删除</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 学习中心 -->
    <div v-if="currentView === 'learn'" class="learn-page">
      <div class="page-header">
        <button class="back-btn" @click="backToHome">←</button>
        <h2>决策科学</h2>
      </div>
      
      <div class="course-list">
        <div 
          v-for="course in courses" 
          :key="course.id"
          class="course-card"
        >
          <div class="course-icon">{{ course.icon }}</div>
          <div class="course-info">
            <h3>{{ course.name }}</h3>
            <p>{{ course.description }}</p>
            <div class="course-meta">
              <span>难度: {{ '★'.repeat(course.difficulty) }}{{ '☆'.repeat(5-course.difficulty) }}</span>
              <span>学习: {{ course.learners }}人</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, reactive, watch, onMounted } from 'vue'

// ==================== 类型定义 ====================
interface Template {
  id: string
  name: string
  description: string
  category: string
  icon: string
  usage: number
  parameters: string[]
  criteria: string[]
  strengths?: string[]
}

interface Option {
  name: string
  params: Record<string, string>
}

interface Criterion {
  name: string
  weight: number
}

interface DecisionHistory {
  id: string
  date: string
  template: string
  result: string
  options: Option[]
  criteria: Criterion[]
  scores: number[][]
}

interface Course {
  id: string
  name: string
  description: string
  icon: string
  difficulty: number
  learners: number
}

// ==================== 响应式数据 ====================
const currentView = ref<'home' | 'templateDetail' | 'history' | 'learn'>('home')
const currentCategory = ref('all')
const searchKeyword = ref('')
const currentTemplate = ref<Template | null>(null)
const currentStep = ref(1)
const scoringMode = ref<'manual' | 'auto'>('manual')
const currentChart = ref('雷达图')
const selectedCriterion = ref('')
const sensitivityWeight = ref(50)

// 决策数据
const decisionOptions = ref<Option[]>([])
const decisionCriteria = ref<Criterion[]>([])
const scores = ref<number[][]>([])
const optionScores = ref<number[]>([])
const decisionHistory = ref<DecisionHistory[]>([])
const sensitivityResult = ref<{recommended: string} | null>(null)

// ==================== 计算属性 ====================
const totalWeight = computed(() => {
  return decisionCriteria.value.reduce((sum, criterion) => sum + criterion.weight, 0)
})

const canProceed = computed(() => {
  switch (currentStep.value) {
    case 1:
      return decisionOptions.value.length >= 2 && 
             decisionOptions.value.every(opt => opt.name.trim())
    case 2:
      return decisionCriteria.value.length >= 2 && 
             totalWeight.value === 100
    case 3:
      return scores.value.flat().every(score => score >= 1 && score <= 10)
    default:
      return true
  }
})

const topOption = computed(() => {
  const maxScore = Math.max(...optionScores.value)
  const maxIndex = optionScores.value.indexOf(maxScore)
  return decisionOptions.value[maxIndex]
})

const topOptionScore = computed(() => {
  return Math.max(...optionScores.value)
})

const topOptionStrengths = computed(() => {
  if (!topOption.value || !currentTemplate.value?.strengths) return []
  return currentTemplate.value.strengths
})

// ==================== 测试数据 ====================
const categories = [
  { id: 'all', name: '全部' },
  { id: 'personal', name: '个人生活' },
  { id: 'career', name: '职业发展' },
  { id: 'professional', name: '专业模型' },
  { id: 'fun', name: '趣味决策' }
]

const templates: Template[] = [
  // 个人生活决策
  {
    id: 'rental',
    name: '租房选择分析',
    description: '成本、通勤、环境多维度对比',
    category: 'personal',
    icon: '🏠',
    usage: 256,
    parameters: ['月租', '通勤时间', '面积', '楼层'],
    criteria: ['租金成本', '通勤便利', '居住环境', '安全性'],
    strengths: ['性价比最高', '通勤时间适中', '周边设施完善']
  },
  {
    id: 'car',
    name: '买车决策助手',
    description: '价格、油耗、维护成本分析',
    category: 'personal',
    icon: '🚗',
    usage: 189,
    parameters: ['价格', '油耗', '品牌', '配置'],
    criteria: ['购买成本', '使用成本', '品牌价值', '配置需求']
  },
  {
    id: 'travel',
    name: '旅游目的地选择',
    description: '预算、时间、兴趣匹配',
    category: 'personal',
    icon: '✈️',
    usage: 312,
    parameters: ['预算', '时间', '季节', '兴趣'],
    criteria: ['预算符合度', '时间安排', '季节适宜', '兴趣匹配']
  },
  {
    id: 'shopping',
    name: '购物比价决策',
    description: '多平台比价，最优选择',
    category: 'personal',
    icon: '🛒',
    usage: 421,
    parameters: ['价格', '品牌', '评价', '物流'],
    criteria: ['价格优势', '品牌信誉', '用户评价', '物流速度']
  },
  {
    id: 'time',
    name: '时间管理优先级',
    description: '四象限法则应用',
    category: 'personal',
    icon: '⏰',
    usage: 178,
    parameters: ['紧急性', '重要性'],
    criteria: ['紧急性', '重要性', '完成时间', '资源需求']
  },

  // 职业发展决策
  {
    id: 'job',
    name: '工作选择对比',
    description: '薪资、发展、文化综合评估',
    category: 'career',
    icon: '💼',
    usage: 345,
    parameters: ['薪资', '职位', '地点', '公司规模'],
    criteria: ['薪资待遇', '发展空间', '公司文化', '工作强度']
  },
  {
    id: 'startup',
    name: '创业风险评估',
    description: '市场、团队、资金风险评估',
    category: 'career',
    icon: '🚀',
    usage: 89,
    parameters: ['市场大小', '团队经验', '启动资金', '竞争程度'],
    criteria: ['市场潜力', '团队能力', '资金需求', '竞争风险']
  },
  {
    id: 'investment',
    name: '投资理财决策',
    description: '收益、风险、流动性平衡',
    category: 'career',
    icon: '📈',
    usage: 267,
    parameters: ['预期收益', '风险等级', '投资期限', '流动性'],
    criteria: ['预期收益', '风险控制', '期限匹配', '流动性需求']
  },
  {
    id: 'study',
    name: '学习计划优化',
    description: '效率、成本、实用性评估',
    category: 'career',
    icon: '📚',
    usage: 198,
    parameters: ['时间投入', '经济成本', '实用价值', '兴趣程度'],
    criteria: ['时间效率', '成本效益', '实用价值', '个人兴趣']
  },

  // 专业决策模型
  {
    id: 'swot',
    name: 'SWOT分析工具',
    description: '优势、劣势、机会、威胁分析',
    category: 'professional',
    icon: '📊',
    usage: 432,
    parameters: ['优势', '劣势', '机会', '威胁'],
    criteria: ['内部优势', '内部劣势', '外部机会', '外部威胁']
  },
  {
    id: 'decisionTree',
    name: '决策树分析',
    description: '概率与期望值计算',
    category: 'professional',
    icon: '🌳',
    usage: 156,
    parameters: ['方案', '概率', '收益'],
    criteria: ['期望收益', '风险程度', '实施难度', '时间成本']
  },
  {
    id: 'costBenefit',
    name: '成本效益分析',
    description: '成本与收益量化对比',
    category: 'professional',
    icon: '💰',
    usage: 189,
    parameters: ['成本', '收益', '时间'],
    criteria: ['成本效益比', '投资回收期', '净现值', '风险调整']
  },
  {
    id: 'mcda',
    name: '多标准决策分析',
    description: '多维度加权评分',
    category: 'professional',
    icon: '⚖️',
    usage: 123,
    parameters: ['标准', '权重', '评分'],
    criteria: ['标准重要性', '数据可得性', '分析准确性', '结果可靠性']
  },
  {
    id: 'monteCarlo',
    name: '蒙特卡洛模拟',
    description: '随机模拟与概率分析',
    category: 'professional',
    icon: '🎲',
    usage: 76,
    parameters: ['变量', '分布', '模拟次数'],
    criteria: ['模型准确性', '计算复杂度', '结果稳定性', '应用范围']
  },

  // 趣味决策
  {
    id: 'food',
    name: '今天吃什么',
    description: '随机选择不重复',
    category: 'fun',
    icon: '🍽️',
    usage: 567,
    parameters: ['预算', '口味', '距离', '等待时间'],
    criteria: ['价格预算', '口味偏好', '距离远近', '等待时间']
  },
  {
    id: 'weekend',
    name: '周末做什么',
    description: '活动推荐与选择',
    category: 'fun',
    icon: '🎯',
    usage: 234,
    parameters: ['天气', '心情', '预算', '时间'],
    criteria: ['天气适宜', '心情匹配', '预算符合', '时间安排']
  },
  {
    id: 'gift',
    name: '礼物选择助手',
    description: '个性化礼物推荐',
    category: 'fun',
    icon: '🎁',
    usage: 189,
    parameters: ['对象', '场合', '预算', '喜好'],
    criteria: ['对象匹配', '场合适合', '预算合理', '喜好符合']
  },
  {
    id: 'random',
    name: '随机但不随机',
    description: '加权随机选择',
    category: 'fun',
    icon: '🎰',
    usage: 156,
    parameters: ['选项', '权重', '偏好'],
    criteria: ['权重分配', '随机公平', '结果多样性', '偏好考虑']
  }
]

const courses: Course[] = [
  {
    id: 'weighted',
    name: '加权评分法',
    description: '适合多标准决策场景',
    icon: '📚',
    difficulty: 1,
    learners: 2456
  },
  {
    id: 'swot',
    name: 'SWOT分析法',
    description: '战略规划核心工具',
    icon: '📊',
    difficulty: 2,
    learners: 1893
  },
  {
    id: 'ahp',
    name: '层次分析法',
    description: '复杂决策的数学工具',
    icon: '📐',
    difficulty: 3,
    learners: 1024
  },
  {
    id: 'decisionTree',
    name: '决策树分析',
    description: '风险决策的概率工具',
    icon: '🌳',
    difficulty: 3,
    learners: 876
  }
]

// ==================== 计算和过滤 ====================
const filteredTemplates = computed(() => {
  let result = templates
  
  // 按分类过滤
  if (currentCategory.value !== 'all') {
    result = result.filter(t => t.category === currentCategory.value)
  }
  
  // 按搜索关键词过滤
  if (searchKeyword.value) {
    const keyword = searchKeyword.value.toLowerCase()
    result = result.filter(t => 
      t.name.toLowerCase().includes(keyword) || 
      t.description.toLowerCase().includes(keyword)
    )
  }
  
  return result
})

const decisionSteps = computed(() => [
  { number: 1, title: '设定选项' },
  { number: 2, title: '确定标准' },
  { number: 3, title: '评分' },
  { number: 4, title: '查看结果' }
])

const chartTypes = ['雷达图', '柱状图', '折线图', '饼图']

// ==================== 方法 ====================
const switchCategory = (categoryId: string) => {
  currentCategory.value = categoryId
}

const filterTemplates = () => {
  // 搜索功能已通过计算属性实现
}

const selectTemplate = (template: Template) => {
  currentTemplate.value = template
  currentView.value = 'templateDetail'
  currentStep.value = 1
  
  // 初始化选项
  decisionOptions.value = [
    { name: '选项A', params: {} },
    { name: '选项B', params: {} }
  ]
  
  // 初始化评价标准
  decisionCriteria.value = template.criteria.map((criterion, index) => ({
    name: criterion,
    weight: Math.floor(100 / template.criteria.length)
  }))
  
  // 调整最后一个标准的权重确保总和为100
  const remainder = 100 - decisionCriteria.value.reduce((sum, c) => sum + c.weight, 0)
  if (decisionCriteria.value.length > 0) {
    decisionCriteria.value[decisionCriteria.value.length - 1].weight += remainder
  }
  
  // 初始化评分矩阵
  initializeScores()
  
  // 初始化参数
  template.parameters.forEach(param => {
    decisionOptions.value.forEach(option => {
      option.params[param] = ''
    })
  })
}

const addOption = () => {
  const newOption: Option = { 
    name: `选项${String.fromCharCode(65 + decisionOptions.value.length)}`,
    params: {}
  }
  
  // 初始化参数
  currentTemplate.value?.parameters.forEach(param => {
    newOption.params[param] = ''
  })
  
  decisionOptions.value.push(newOption)
  initializeScores()
}

const removeOption = (index: number) => {
  decisionOptions.value.splice(index, 1)
  initializeScores()
}

const addCriterion = () => {
  decisionCriteria.value.push({
    name: `标准${decisionCriteria.value.length + 1}`,
    weight: 0
  })
  recalculateWeights(decisionCriteria.value.length - 1)
  initializeScores()
}

const removeCriterion = (index: number) => {
  decisionCriteria.value.splice(index, 1)
  // 重新分配权重
  const total = decisionCriteria.value.reduce((sum, c) => sum + c.weight, 0)
  if (total === 100) return
  
  const remaining = 100 - total
  if (decisionCriteria.value.length > 0) {
    decisionCriteria.value.forEach(c => {
      c.weight += remaining / decisionCriteria.value.length
    })
  }
  initializeScores()
}

const recalculateWeights = (changedIndex: number) => {
  const changedWeight = decisionCriteria.value[changedIndex].weight
  const otherCriteria = decisionCriteria.value.filter((_, i) => i !== changedIndex)
  const otherTotal = otherCriteria.reduce((sum, c) => sum + c.weight, 0)
  
  if (otherTotal === 0) {
    // 如果其他权重都是0，平均分配
    const weightPerOther = (100 - changedWeight) / otherCriteria.length
    otherCriteria.forEach(c => {
      c.weight = weightPerOther
    })
  } else {
    // 按比例调整其他权重
    const scale = (100 - changedWeight) / otherTotal
    otherCriteria.forEach(c => {
      c.weight *= scale
    })
  }
  
  // 更新数组
  decisionCriteria.value = decisionCriteria.value.map((c, i) => {
    if (i === changedIndex) return c
    return otherCriteria.find(oc => oc.name === c.name) || c
  })
}

const getPlaceholder = (param: string) => {
  const placeholders: Record<string, string> = {
    '月租': '如：3500元',
    '通勤时间': '如：30分钟',
    '面积': '如：80㎡',
    '楼层': '如：15层',
    '价格': '如：200000元',
    '油耗': '如：8L/100km',
    '预算': '如：5000元',
    '时间': '如：5天',
    '薪资': '如：15000元/月',
    '预期收益': '如：8%',
    '风险等级': '高/中/低'
  }
  return placeholders[param] || '请输入'
}

const initializeScores = () => {
  scores.value = Array(decisionOptions.value.length)
    .fill(null)
    .map(() => Array(decisionCriteria.value.length).fill(5))
  calculateScores()
}

const calculateScores = () => {
  optionScores.value = decisionOptions.value.map((_, optionIndex) => {
    let total = 0
    decisionCriteria.value.forEach((criterion, criterionIndex) => {
      const score = scores.value[optionIndex][criterionIndex] || 5
      total += (score / 10) * criterion.weight
    })
    return total
  })
}

const autoScore = (option: Option, criterionIndex: number): string => {
  // 模拟自动评分逻辑（实际中会基于参数计算）
  const criterion = decisionCriteria.value[criterionIndex]
  if (!criterion) return '5'
  
  // 简单的模拟：基于参数值生成分数
  const paramKeys = Object.keys(option.params)
  if (paramKeys.length === 0) return '5'
  
  const paramValue = option.params[paramKeys[criterionIndex % paramKeys.length]]
  if (!paramValue) return '5'
  
  // 提取数字部分
  const numMatch = paramValue.match(/\d+/)
  if (!numMatch) return '5'
  
  const num = parseInt(numMatch[0])
  // 模拟一个简单的评分逻辑
  const score = Math.min(10, Math.max(1, Math.floor(num / 100) % 10))
  return score.toString()
}

const getRadarPolygonStyle = (optionIndex: number) => {
  const scores = optionScores.value[optionIndex] || 0
  const maxScore = Math.max(...optionScores.value)
  const percentage = (scores / maxScore) * 100
  
  return {
    '--score': `${percentage}%`
  }
}

const runSensitivityAnalysis = () => {
  if (!selectedCriterion.value) return
  
  const criterionIndex = decisionCriteria.value.findIndex(c => c.name === selectedCriterion.value)
  if (criterionIndex === -1) return
  
  // 模拟敏感性分析结果
  const options = ['选项A', '选项B', '选项C']
  const randomIndex = Math.floor(Math.random() * options.length)
  
  sensitivityResult.value = {
    recommended: options[randomIndex]
  }
}

const nextStep = () => {
  if (currentStep.value < 4) {
    currentStep.value++
    
    // 如果进入评分步骤，确保有分数
    if (currentStep.value === 3) {
      calculateScores()
    }
    
    // 如果进入结果步骤，运行分析
    if (currentStep.value === 4) {
      if (selectedCriterion.value) {
        runSensitivityAnalysis()
      }
    }
  }
}

const prevStep = () => {
  if (currentStep.value > 1) {
    currentStep.value--
  }
}

const saveDecision = () => {
  const history: DecisionHistory = {
    id: Date.now().toString(),
    date: new Date().toLocaleDateString(),
    template: currentTemplate.value?.name || '',
    result: topOption.value?.name || '',
    options: [...decisionOptions.value],
    criteria: [...decisionCriteria.value],
    scores: scores.value.map(row => [...row])
  }
  
  decisionHistory.value.unshift(history)
  alert('决策已保存到历史记录！')
}

const shareDecision = () => {
  const text = `我使用决策助手分析后，推荐选择：${topOption.value?.name}`
  // 实际中这里会调用微信分享API
  alert(`分享内容：${text}`)
}

const exportReport = () => {
  // 模拟生成报告
  const report = `
决策报告
========
模板：${currentTemplate.value?.name}
时间：${new Date().toLocaleString()}

选项分析：
${decisionOptions.value.map((opt, i) => 
  `${opt.name}: ${optionScores.value[i]?.toFixed(1)}分`
).join('\n')}

推荐选择：${topOption.value?.name}
综合得分：${topOptionScore.value?.toFixed(1)}/10
`
  
  alert('报告已生成（实际中会导出为文件）\n\n' + report)
}

const viewHistory = () => {
  currentView.value = 'history'
}

const viewLearn = () => {
  currentView.value = 'learn'
}

const backToHome = () => {
  currentView.value = 'home'
  currentTemplate.value = null
  currentStep.value = 1
}

const viewHistoryDetail = (record: DecisionHistory) => {
  alert(`查看历史决策详情：${record.template} - ${record.result}`)
}

const deleteHistory = (index: number) => {
  if (confirm('确定删除这条历史记录吗？')) {
    decisionHistory.value.splice(index, 1)
  }
}

// ==================== 生命周期 ====================
onMounted(() => {
  // 初始化测试历史数据
  decisionHistory.value = [
    {
      id: '1',
      date: '2024-01-15',
      template: '租房选择分析',
      result: '房源B',
      options: [],
      criteria: [],
      scores: []
    },
    {
      id: '2',
      date: '2024-01-10',
      template: '买车决策助手',
      result: '车型A',
      options: [],
      criteria: [],
      scores: []
    }
  ]
})
</script>

<style scoped>
.decision-helper {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, sans-serif;
  background: #f8f9fa;
  min-height: 100vh;
}

/* 通用样式 */
.header {
  margin-bottom: 30px;
}

h1 {
  color: #2c3e50;
  margin-bottom: 20px;
}

.search-bar {
  position: relative;
  margin-bottom: 20px;
}

.search-bar input {
  width: 100%;
  padding: 12px 40px 12px 20px;
  border: 1px solid #e9ecef;
  border-radius: 8px;
  font-size: 16px;
  outline: none;
  transition: border-color 0.2s;
}

.search-bar input:focus {
  border-color: #4a6fff;
}

.search-icon {
  position: absolute;
  right: 15px;
  top: 50%;
  transform: translateY(-50%);
  color: #7f8c8d;
}

.category-tabs {
  display: flex;
  gap: 10px;
  margin-bottom: 30px;
  overflow-x: auto;
  padding-bottom: 10px;
}

.category-tabs button {
  padding: 8px 16px;
  border: 1px solid #e9ecef;
  background: white;
  border-radius: 20px;
  white-space: nowrap;
  cursor: pointer;
  transition: all 0.2s;
}

.category-tabs button.active {
  background: #4a6fff;
  color: white;
  border-color: #4a6fff;
}

/* 模板卡片 */
.templates-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.template-card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  cursor: pointer;
  transition: transform 0.2s;
  display: flex;
  gap: 15px;
}

.template-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(0,0,0,0.15);
}

.template-icon {
  font-size: 32px;
}

.template-info h3 {
  margin: 0 0 8px 0;
  color: #2c3e50;
}

.template-info p {
  margin: 0 0 10px 0;
  color: #7f8c8d;
  font-size: 14px;
}

.template-stats {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 12px;
  color: #95a5a6;
}

/* 底部导航 */
.bottom-nav {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 30px;
}

.bottom-nav button {
  padding: 12px 24px;
  border: 1px solid #4a6fff;
  background: white;
  color: #4a6fff;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
}

.bottom-nav button:hover {
  background: #4a6fff;
  color: white;
}

/* 模板详情页 */
.page-header {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 30px;
}

.back-btn {
  background: none;
  border: none;
  font-size: 20px;
  cursor: pointer;
  color: #4a6fff;
}

.progress-steps {
  display: flex;
  justify-content: space-between;
  margin-bottom: 30px;
  position: relative;
}

.progress-steps::before {
  content: '';
  position: absolute;
  top: 15px;
  left: 0;
  right: 0;
  height: 2px;
  background: #e9ecef;
  z-index: 1;
}

.step {
  display: flex;
  flex-direction: column;
  align-items: center;
  position: relative;
  z-index: 2;
  flex: 1;
}

.step-number {
  width: 30px;
  height: 30px;
  background: #e9ecef;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 8px;
  font-weight: bold;
  color: #95a5a6;
}

.step.active .step-number {
  background: #4a6fff;
  color: white;
}

.step-title {
  font-size: 12px;
  color: #95a5a6;
}

.step.active .step-title {
  color: #4a6fff;
  font-weight: bold;
}

/* 步骤内容 */
.step-content {
  background: white;
  border-radius: 12px;
  padding: 24px;
  margin-bottom: 30px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.step-content h3 {
  margin: 0 0 20px 0;
  color: #2c3e50;
}

/* 选项列表 */
.options-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
  margin-bottom: 20px;
}

.option-card {
  border: 1px solid #e9ecef;
  border-radius: 8px;
  padding: 16px;
}

.option-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.option-name {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #e9ecef;
  border-radius: 4px;
  font-size: 16px;
  outline: none;
}

.option-name:focus {
  border-color: #4a6fff;
}

.delete-btn {
  background: none;
  border: none;
  font-size: 18px;
  cursor: pointer;
  color: #e74c3c;
  margin-left: 10px;
}

.option-params {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 10px;
}

.param-input {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.param-input label {
  font-size: 12px;
  color: #7f8c8d;
}

.param-input input {
  padding: 8px 12px;
  border: 1px solid #e9ecef;
  border-radius: 4px;
  font-size: 14px;
  outline: none;
}

.param-input input:focus {
  border-color: #4a6fff;
}

/* 评价标准 */
.criteria-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
  margin-bottom: 20px;
}

.criterion-card {
  border: 1px solid #e9ecef;
  border-radius: 8px;
  padding: 16px;
}

.criterion-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.criterion-name {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #e9ecef;
  border-radius: 4px;
  font-size: 16px;
  outline: none;
}

.weight-value {
  min-width: 50px;
  text-align: right;
  font-weight: bold;
  color: #4a6fff;
}

.weight-slider {
  margin-bottom: 15px;
}

.slider {
  width: 100%;
  margin-bottom: 10px;
}

.slider-track {
  height: 4px;
  background: #e9ecef;
  border-radius: 2px;
  position: relative;
}

.slider-fill {
  position: absolute;
  height: 100%;
  background: #4a6fff;
  border-radius: 2px;
}

.criterion-actions {
  display: flex;
  justify-content: flex-end;
}

.small-btn {
  padding: 4px 12px;
  border: 1px solid #e74c3c;
  background: white;
  color: #e74c3c;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
}

.small-btn:hover {
  background: #e74c3c;
  color: white;
}

.weight-summary {
  text-align: center;
  padding: 12px;
  background: #f8f9fa;
  border-radius: 8px;
  margin-bottom: 20px;
  font-weight: bold;
  color: #2c3e50;
}

.warning {
  color: #e74c3c;
  font-weight: normal;
  margin-left: 10px;
}

/* 评分表格 */
.scoring-mode {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

.scoring-mode button {
  padding: 8px 16px;
  border: 1px solid #e9ecef;
  background: white;
  border-radius: 4px;
  cursor: pointer;
}

.scoring-mode button.active {
  background: #4a6fff;
  color: white;
  border-color: #4a6fff;
}

.scoring-table {
  overflow-x: auto;
}

.scoring-table table {
  width: 100%;
  border-collapse: collapse;
}

.scoring-table th {
  background: #f8f9fa;
  padding: 12px;
  text-align: center;
  border-bottom: 2px solid #e9ecef;
  color: #2c3e50;
  font-size: 14px;
}

.scoring-table td {
  padding: 12px;
  border-bottom: 1px solid #e9ecef;
  text-align: center;
}

.option-cell {
  min-width: 150px;
  text-align: left;
}

.score-cell {
  min-width: 80px;
}

.score-input {
  width: 60px;
  padding: 8px;
  border: 1px solid #e9ecef;
  border-radius: 4px;
  text-align: center;
  font-size: 14px;
}

.score-input:focus {
  border-color: #4a6fff;
  outline: none;
}

.auto-score {
  font-weight: bold;
  color: #4a6fff;
}

.total-score {
  font-size: 16px;
  color: #2c3e50;
}

/* 结果卡片 */
.result-card {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 12px;
  padding: 24px;
  color: white;
  margin-bottom: 30px;
}

.recommendation {
  display: flex;
  align-items: center;
  gap: 20px;
  margin-bottom: 20px;
}

.recommendation-icon {
  font-size: 48px;
}

.recommendation-info h3 {
  margin: 0 0 10px 0;
  color: white;
}

.score-display {
  display: flex;
  align-items: center;
  gap: 10px;
}

.score {
  font-size: 28px;
  font-weight: bold;
}

.stars {
  font-size: 20px;
}

.result-details ul {
  margin: 0;
  padding-left: 20px;
}

.result-details li {
  margin-bottom: 8px;
}

/* 图表容器 */
.chart-container {
  background: white;
  border-radius: 12px;
  padding: 24px;
  margin-bottom: 30px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.chart-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.chart-switcher {
  display: flex;
  gap: 10px;
}

.chart-switcher button {
  padding: 6px 12px;
  border: 1px solid #e9ecef;
  background: white;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
}

.chart-switcher button.active {
  background: #4a6fff;
  color: white;
  border-color: #4a6fff;
}

/* 雷达图 */
.radar-chart {
  height: 300px;
  position: relative;
  margin: 0 auto;
}

.radar-grid {
  width: 200px;
  height: 200px;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  border: 1px solid #e9ecef;
  border-radius: 50%;
}

.radar-axis {
  position: absolute;
  top: 0;
  left: 50%;
  width: 1px;
  height: 100%;
  background: #e9ecef;
  transform-origin: center;
}

.axis-label {
  position: absolute;
  top: -25px;
  left: 50%;
  transform: translateX(-50%);
  font-size: 12px;
  color: #7f8c8d;
  white-space: nowrap;
}

.radar-polygon {
  position: absolute;
  top: 50%;
  left: 50%;
  width: calc(var(--score) * 2px);
  height: calc(var(--score) * 2px);
  border: 2px solid #4a6fff;
  border-radius: 50%;
  transform: translate(-50%, -50%);
  opacity: 0.5;
}

/* 柱状图 */
.bar-chart {
  display: flex;
  align-items: flex-end;
  gap: 20px;
  height: 200px;
  padding: 20px 0;
}

.bar-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
}

.bar-label {
  font-size: 12px;
  color: #7f8c8d;
}

.bar-wrapper {
  width: 100%;
  height: 150px;
  position: relative;
  display: flex;
  align-items: flex-end;
}

.bar {
  width: 100%;
  background: linear-gradient(to top, #4a6fff, #7b8fff);
  border-radius: 4px 4px 0 0;
  transition: height 0.5s ease;
}

.bar-value {
  position: absolute;
  top: -25px;
  left: 50%;
  transform: translateX(-50%);
  font-size: 12px;
  font-weight: bold;
  color: #2c3e50;
}

/* 敏感性分析 */
.sensitivity-section {
  background: white;
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.sensitivity-controls {
  display: flex;
  flex-direction: column;
  gap: 15px;
  margin-bottom: 20px;
}

.sensitivity-controls label {
  font-weight: bold;
  color: #2c3e50;
}

.sensitivity-controls select {
  padding: 8px 12px;
  border: 1px solid #e9ecef;
  border-radius: 4px;
  font-size: 14px;
  outline: none;
}

.sensitivity-controls select:focus {
  border-color: #4a6fff;
}

.sensitivity-slider {
  display: flex;
  align-items: center;
  gap: 10px;
}

.sensitivity-slider span {
  min-width: 80px;
}

.sensitivity-slider input {
  flex: 1;
}

.sensitivity-result {
  padding: 16px;
  background: #f8f9fa;
  border-radius: 8px;
  border-left: 4px solid #4a6fff;
}

/* 导航按钮 */
.step-navigation {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 0;
}

.nav-btn {
  padding: 12px 24px;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.2s;
}

.nav-btn.secondary {
  background: white;
  color: #4a6fff;
  border: 1px solid #4a6fff;
}

.nav-btn.primary {
  background: #4a6fff;
  color: white;
}

.nav-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.result-actions {
  display: flex;
  gap: 15px;
}

.action-btn {
  padding: 12px 24px;
  border: 1px solid #4a6fff;
  background: white;
  color: #4a6fff;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
}

.action-btn:hover {
  background: #4a6fff;
  color: white;
}

/* 历史记录页 */
.history-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.history-card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.history-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
  font-size: 14px;
  color: #7f8c8d;
}

.history-result {
  margin-bottom: 15px;
  font-size: 16px;
}

.history-actions {
  display: flex;
  gap: 10px;
}

.history-actions button {
  padding: 6px 12px;
  border: 1px solid #e9ecef;
  background: white;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}

.history-actions button:first-child {
  border-color: #4a6fff;
  color: #4a6fff;
}

.history-actions button:last-child {
  border-color: #e74c3c;
  color: #e74c3c;
}

/* 学习中心 */
.course-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

.course-card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  display: flex;
  gap: 15px;
}

.course-icon {
  font-size: 32px;
}

.course-info h3 {
  margin: 0 0 8px 0;
  color: #2c3e50;
}

.course-info p {
  margin: 0 0 10px 0;
  color: #7f8c8d;
  font-size: 14px;
}

.course-meta {
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color: #95a5a6;
}

/* 添加按钮 */
.add-btn {
  width: 100%;
  padding: 12px;
  border: 2px dashed #4a6fff;
  background: #f8f9fa;
  color: #4a6fff;
  border-radius: 8px;
  cursor: pointer;
  font-size: 16px;
  transition: all 0.2s;
}

.add-btn:hover {
  background: #4a6fff;
  color: white;
  border-style: solid;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .templates-grid {
    grid-template-columns: 1fr;
  }
  
  .course-list {
    grid-template-columns: 1fr;
  }
  
  .option-params {
    grid-template-columns: 1fr;
  }
  
  .result-actions {
    flex-direction: column;
  }
  
  .step-navigation {
    flex-direction: column;
    gap: 15px;
  }
  
  .nav-btn {
    width: 100%;
  }
}
</style>