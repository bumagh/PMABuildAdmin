<template>
  <div class="dashboard">
    <!-- 侧边栏导航 -->
    <aside class="sidebar">
      <div class="sidebar-header">
        <div class="logo">
          <span class="logo-icon">✨</span>
          <span class="logo-text">创梦AI</span>
        </div>
      </div>
      <nav class="sidebar-nav">
        <button 
          v-for="tab in tabs" 
          :key="tab.id"
          :class="['nav-item', { active: activeTab === tab.id }]"
          @click="activeTab = tab.id"
        >
          <span class="nav-icon">{{ tab.icon }}</span>
          <span class="nav-text">{{ tab.name }}</span>
          <span v-if="tab.badge" class="nav-badge">{{ tab.badge }}</span>
        </button>
      </nav>
      <div class="sidebar-footer">
        <div class="user-info">
          <div class="user-avatar">
            {{ userInfo.avatar }}
          </div>
          <div class="user-details">
            <div class="user-name">{{ userInfo.name }}</div>
            <div class="user-integral">
              <span class="integral-icon">🪙</span>
              {{ userInfo.integral }} 积分
            </div>
          </div>
        </div>
      </div>
    </aside>

    <!-- 主内容区 -->
    <main class="main-content">
      <!-- 需求提交系统 -->
      <section v-show="activeTab === 'demand'" class="tab-content">
        <div class="content-header">
          <h2 class="content-title">
            <span class="title-icon">💬</span>
            需求提交系统
          </h2>
          <div class="content-subtitle">AI对话引导，帮您清晰表达需求</div>
        </div>
        
        <div class="demand-container">
          <!-- AI对话引导 -->
          <div class="ai-dialog">
            <div class="dialog-header">
              <div class="dialog-title">
                <span class="ai-avatar">🤖</span>
                AI需求助手
              </div>
              <div class="dialog-status">
                <span class="status-dot"></span>
                在线
              </div>
            </div>
            
            <div class="dialog-body">
              <div ref="messageContainer" class="messages">
                <!-- AI欢迎消息 -->
                <div class="message ai">
                  <div class="message-avatar">🤖</div>
                  <div class="message-content">
                    <div class="message-text">
                      您好！我是创梦AI助手，很高兴为您服务。
                      <br>
                      请告诉我您想要创建什么类型的项目？
                    </div>
                    <div class="message-time">{{ formatTime(currentTime) }}</div>
                  </div>
                </div>

                <!-- 用户消息 -->
                <div 
                  v-for="(msg, index) in chatMessages" 
                  :key="'msg-' + index"
                  :class="['message', msg.type]"
                >
                  <div class="message-avatar">{{ msg.type === 'user' ? '👤' : '🤖' }}</div>
                  <div class="message-content">
                    <div class="message-text">{{ msg.content }}</div>
                    <div class="message-time">{{ formatTime(msg.time) }}</div>
                    
                    <!-- AI回复的选项 -->
                    <div v-if="msg.type === 'ai' && msg.options" class="message-options">
                      <button 
                        v-for="(option, optIndex) in msg.options" 
                        :key="'opt-' + optIndex"
                        class="option-btn"
                        @click="selectOption(option)"
                      >
                        {{ option }}
                      </button>
                    </div>
                  </div>
                </div>

                <!-- AI正在输入 -->
                <div v-if="isAIThinking" class="message ai">
                  <div class="message-avatar">🤖</div>
                  <div class="message-content">
                    <div class="typing-indicator">
                      <span></span>
                      <span></span>
                      <span></span>
                    </div>
                  </div>
                </div>
              </div>
              
              <!-- 输入区域 -->
              <div class="dialog-input">
                <div class="quick-questions">
                  <div class="quick-title">快速提问：</div>
                  <div class="quick-buttons">
                    <button 
                      v-for="(question, index) in quickQuestions" 
                      :key="'q-' + index"
                      class="quick-btn"
                      @click="sendQuickQuestion(question)"
                    >
                      {{ question }}
                    </button>
                  </div>
                </div>
                
                <div class="input-area">
                  <textarea 
                    v-model="userInput"
                    placeholder="请描述您的项目需求..."
                    rows="3"
                    class="message-input"
                    @keydown.enter.exact.prevent="sendMessage"
                  ></textarea>
                  <div class="input-actions">
                    <div class="input-tools">
                      <button class="tool-btn" title="上传文件" @click="uploadFile">
                        📎
                      </button>
                      <button class="tool-btn" title="上传图片" @click="uploadImage">
                        🖼️
                      </button>
                      <button class="tool-btn" title="语音输入">
                        🎤
                      </button>
                    </div>
                    <button 
                      class="send-btn"
                      :disabled="!userInput.trim()"
                      @click="sendMessage"
                    >
                      发送
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 需求摘要 -->
          <div class="demand-summary">
            <div class="summary-header">
              <h3>需求摘要</h3>
              <button 
                class="btn btn-primary"
                :disabled="!canSubmit"
                @click="submitDemand"
              >
                提交需求（消耗 100 积分）
              </button>
            </div>
            
            <div class="summary-content">
              <div class="summary-item">
                <label>项目类型：</label>
                <span>{{ demandSummary.type || '未选择' }}</span>
              </div>
              <div class="summary-item">
                <label>平台要求：</label>
                <span v-if="demandSummary.platforms.length">
                  {{ demandSummary.platforms.join(', ') }}
                </span>
                <span v-else>未选择</span>
              </div>
              <div class="summary-item">
                <label>核心功能：</label>
                <div class="tags">
                  <span 
                    v-for="(func, index) in demandSummary.functions" 
                    :key="'func-' + index"
                    class="tag"
                  >
                    {{ func }}
                  </span>
                  <span v-if="!demandSummary.functions.length">未选择</span>
                </div>
              </div>
              <div class="summary-item">
                <label>预算范围：</label>
                <span>{{ demandSummary.budget || '未选择' }}</span>
              </div>
              <div class="summary-item">
                <label>时间要求：</label>
                <span>{{ demandSummary.deadline || '未选择' }}</span>
              </div>
            </div>

            <!-- 上传的文件列表 -->
            <div v-if="uploadedFiles.length" class="uploaded-files">
              <h4>已上传文件</h4>
              <div class="files-list">
                <div 
                  v-for="(file, index) in uploadedFiles" 
                  :key="'file-' + index"
                  class="file-item"
                >
                  <span class="file-icon">
                    {{ getFileIcon(file.type) }}
                  </span>
                  <div class="file-info">
                    <div class="file-name">{{ file.name }}</div>
                    <div class="file-size">{{ formatFileSize(file.size) }}</div>
                  </div>
                  <button class="file-delete" @click="removeFile(index)">
                    ×
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- 积分与加速系统 -->
      <section v-show="activeTab === 'integral'" class="tab-content">
        <div class="content-header">
          <h2 class="content-title">
            <span class="title-icon">🪙</span>
            积分与加速系统
          </h2>
          <div class="content-subtitle">积分消耗与加速服务</div>
        </div>

        <div class="integral-container">
          <!-- 积分概览 -->
          <div class="integral-overview">
            <div class="overview-card">
              <div class="overview-icon">🪙</div>
              <div class="overview-content">
                <div class="overview-value">{{ userInfo.integral }}</div>
                <div class="overview-label">当前积分</div>
              </div>
            </div>
            <div class="overview-card">
              <div class="overview-icon">📊</div>
              <div class="overview-content">
                <div class="overview-value">{{ userInfo.monthUsed }}/{{ userInfo.monthTotal }}</div>
                <div class="overview-label">本月已用/总额</div>
              </div>
            </div>
            <div class="overview-card">
              <div class="overview-icon">⏱️</div>
              <div class="overview-content">
                <div class="overview-value">{{ userInfo.validDays }}</div>
                <div class="overview-label">剩余有效天数</div>
              </div>
            </div>
          </div>

          <!-- 积分充值 -->
          <div class="integral-recharge">
            <h3>积分充值</h3>
            <div class="recharge-options">
              <div 
                v-for="(option, index) in rechargeOptions" 
                :key="'recharge-' + index"
                :class="['recharge-option', { selected: selectedRecharge === option.id }]"
                @click="selectedRecharge = option.id"
              >
                <div class="recharge-amount">{{ option.integral }} 积分</div>
                <div class="recharge-price">¥{{ option.price }}</div>
                <div v-if="option.bonus" class="recharge-bonus">
                  赠 {{ option.bonus }} 积分
                </div>
              </div>
            </div>
            <button class="btn btn-primary recharge-btn" @click="handleRecharge">
              立即充值 ¥{{ selectedRechargePrice }}
            </button>
          </div>

          <!-- 加速服务 -->
          <div class="acceleration-services">
            <h3>加速服务</h3>
            <div class="services-list">
              <div 
                v-for="(service, index) in accelerationServices" 
                :key="'service-' + index"
                class="service-card"
              >
                <div class="service-icon">{{ service.icon }}</div>
                <div class="service-content">
                  <h4>{{ service.name }}</h4>
                  <p>{{ service.description }}</p>
                  <div class="service-cost">
                    消耗：{{ service.cost }} 积分
                  </div>
                </div>
                <button 
                  class="btn btn-outline service-btn"
                  :disabled="userInfo.integral < service.cost"
                  @click="useAccelerationService(service)"
                >
                  立即加速
                </button>
              </div>
            </div>
          </div>

          <!-- 积分记录 -->
          <div class="integral-records">
            <h3>积分记录</h3>
            <div class="records-list">
              <div 
                v-for="(record, index) in integralRecords" 
                :key="'record-' + index"
                class="record-item"
              >
                <div class="record-type">
                  <span :class="['record-icon', record.type]">
                    {{ record.type === 'recharge' ? '➕' : '➖' }}
                  </span>
                  {{ record.description }}
                </div>
                <div class="record-amount" :class="record.type">
                  {{ record.type === 'recharge' ? '+' : '-' }}{{ record.amount }}
                </div>
                <div class="record-time">{{ formatTime(record.time) }}</div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- 项目管理面板 -->
      <section v-show="activeTab === 'projects'" class="tab-content">
        <div class="content-header">
          <h2 class="content-title">
            <span class="title-icon">📁</span>
            项目管理面板
          </h2>
          <div class="content-subtitle">项目进度跟踪与管理</div>
        </div>

        <div class="projects-container">
          <!-- 项目筛选 -->
          <div class="projects-filter">
            <div class="filter-tabs">
              <button 
                v-for="status in projectStatuses" 
                :key="status.value"
                :class="['filter-tab', { active: filterStatus === status.value }]"
                @click="filterStatus = status.value"
              >
                {{ status.label }}
                <span class="tab-count">{{ getProjectCount(status.value) }}</span>
              </button>
            </div>
            <div class="filter-search">
              <input 
                v-model="searchKeyword"
                type="text" 
                placeholder="搜索项目名称..."
                class="search-input"
              >
              <button class="search-btn">🔍</button>
            </div>
          </div>

          <!-- 项目列表 -->
          <div class="projects-list">
            <div 
              v-for="project in filteredProjects" 
              :key="project.id"
              class="project-card"
            >
              <div class="project-header">
                <div class="project-title">
                  <span class="project-icon">{{ getProjectIcon(project.type) }}</span>
                  {{ project.name }}
                </div>
                <div :class="['project-status', project.status]">
                  {{ getStatusText(project.status) }}
                </div>
              </div>
              
              <div class="project-info">
                <div class="info-item">
                  <span class="info-label">项目类型：</span>
                  {{ project.type }}
                </div>
                <div class="info-item">
                  <span class="info-label">创建时间：</span>
                  {{ formatTime(project.createTime) }}
                </div>
                <div class="info-item">
                  <span class="info-label">预计完成：</span>
                  {{ formatTime(project.estimatedTime) }}
                </div>
                <div v-if="project.assignedTo" class="info-item">
                  <span class="info-label">策划师：</span>
                  {{ project.assignedTo }}
                </div>
              </div>

              <!-- 进度条 -->
              <div class="project-progress">
                <div class="progress-header">
                  <span>项目进度</span>
                  <span>{{ project.progress }}%</span>
                </div>
                <div class="progress-bar">
                  <div 
                    class="progress-fill" 
                    :style="{ width: project.progress + '%' }"
                  ></div>
                </div>
                <div class="progress-steps">
                  <div 
                    v-for="step in projectSteps" 
                    :key="step.value"
                    :class="['progress-step', { 
                      active: step.value === project.currentStep,
                      completed: isStepCompleted(project, step.value)
                    }]"
                  >
                    <div class="step-dot"></div>
                    <div class="step-label">{{ step.label }}</div>
                  </div>
                </div>
              </div>

              <div class="project-actions">
                <button 
                  v-if="project.status === 'pending'"
                  class="btn btn-outline"
                  @click="accelerateProject(project)"
                >
                  加速处理 ({{ project.accelerationCost }}积分)
                </button>
                <button 
                  v-if="project.status === 'in_progress'"
                  class="btn btn-outline"
                  @click="viewProjectDetails(project)"
                >
                  查看详情
                </button>
                <button 
                  v-if="project.status === 'completed'"
                  class="btn btn-primary"
                  @click="downloadProject(project)"
                >
                  下载项目
                </button>
                <button 
                  v-if="project.status === 'reviewing'"
                  class="btn btn-outline"
                  @click="reviewProject(project)"
                >
                  审核反馈
                </button>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- 成果交付体系 -->
      <section v-show="activeTab === 'delivery'" class="tab-content">
        <div class="content-header">
          <h2 class="content-title">
            <span class="title-icon">📦</span>
            成果交付体系
          </h2>
          <div class="content-subtitle">项目成果管理与交付</div>
        </div>

        <div class="delivery-container">
          <!-- 已完成项目 -->
          <div class="delivered-projects">
            <h3>已完成项目</h3>
            <div class="projects-grid">
              <div 
                v-for="project in deliveredProjects" 
                :key="project.id"
                class="delivery-card"
              >
                <div class="delivery-header">
                  <div class="delivery-icon">{{ getProjectIcon(project.type) }}</div>
                  <div class="delivery-info">
                    <h4>{{ project.name }}</h4>
                    <div class="delivery-time">
                      交付时间：{{ project.deliveryTime ? formatTime(project.deliveryTime) : '未设置' }}
                    </div>
                  </div>
                </div>
                
                <div class="delivery-content">
                  <div class="delivery-files">
                    <div class="files-title">交付文件：</div>
                    <div class="files-list">
                      <div 
                        v-for="(file, index) in project.files" 
                        :key="'delivery-file-' + index"
                        class="file-item"
                        @click="previewFile(file)"
                      >
                        <span class="file-icon">
                          {{ getFileIcon(file.type) }}
                        </span>
                        <div class="file-details">
                          <div class="file-name">{{ file.name }}</div>
                          <div class="file-size">{{ formatFileSize(file.size) }}</div>
                        </div>
                        <button class="file-download" @click.stop="downloadFile(file)">
                          ⬇️
                        </button>
                      </div>
                    </div>
                  </div>

                  <div v-if="project.deploymentGuide" class="deployment-guide">
                    <h5>部署指南</h5>
                    <div class="guide-content">
                      {{ project.deploymentGuide }}
                    </div>
                  </div>

                  <div v-if="project.supportInfo" class="support-info">
                    <h5>支持信息</h5>
                    <div class="support-content">
                      <div>支持期限：{{ project.supportInfo.period }}</div>
                      <div>支持方式：{{ project.supportInfo.contact }}</div>
                    </div>
                  </div>
                </div>

                <div class="delivery-actions">
                  <button class="btn btn-outline" @click="rateProject(project)">
                    评价服务
                  </button>
                  <button class="btn btn-primary" @click="downloadAll(project)">
                    一键下载
                  </button>
                </div>
              </div>
            </div>
          </div>

          <!-- 交付统计 -->
          <div class="delivery-stats">
            <h3>交付统计</h3>
            <div class="stats-cards">
              <div class="stats-card">
                <div class="stats-icon">📊</div>
                <div class="stats-content">
                  <div class="stats-value">{{ deliveryStats.totalProjects }}</div>
                  <div class="stats-label">总项目数</div>
                </div>
              </div>
              <div class="stats-card">
                <div class="stats-icon">⭐</div>
                <div class="stats-content">
                  <div class="stats-value">{{ deliveryStats.averageRating }}</div>
                  <div class="stats-label">平均评分</div>
                </div>
              </div>
              <div class="stats-card">
                <div class="stats-icon">⏱️</div>
                <div class="stats-content">
                  <div class="stats-value">{{ deliveryStats.averageDays }}天</div>
                  <div class="stats-label">平均周期</div>
                </div>
              </div>
              <div class="stats-card">
                <div class="stats-icon">🎯</div>
                <div class="stats-content">
                  <div class="stats-value">{{ deliveryStats.successRate }}%</div>
                  <div class="stats-label">成功率</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch, nextTick, onMounted } from 'vue'

// 数据类型定义
interface UserInfo {
  name: string
  avatar: string
  integral: number
  monthUsed: number
  monthTotal: number
  validDays: number
}

interface ChatMessage {
  type: 'user' | 'ai'
  content: string
  time: Date
  options?: string[]
}

interface DemandSummary {
  type: string
  platforms: string[]
  functions: string[]
  budget: string
  deadline: string
}

interface UploadedFile {
  name: string
  type: string
  size: number
}

interface RechargeOption {
  id: string
  integral: number
  price: number
  bonus?: number
}

interface AccelerationService {
  id: string
  icon: string
  name: string
  description: string
  cost: number
}

interface IntegralRecord {
  id: string
  type: 'recharge' | 'consume'
  description: string
  amount: number
  time: Date
}

interface Project {
  id: string
  name: string
  type: string
  status: 'pending' | 'in_progress' | 'reviewing' | 'completed' | 'cancelled'
  createTime: Date
  estimatedTime: Date
  assignedTo?: string
  progress: number
  currentStep: string
  accelerationCost: number
  deliveryTime?: Date
  files?: DeliveryFile[]
  deploymentGuide?: string
  supportInfo?: {
    period: string
    contact: string
  }
}

interface DeliveryFile {
  name: string
  type: string
  size: number
  url: string
}

interface DeliveryStats {
  totalProjects: number
  averageRating: number
  averageDays: number
  successRate: number
}

// 响应式数据
const activeTab = ref<string>('demand')
const currentTime = ref<Date>(new Date())

// 用户信息
const userInfo = ref<UserInfo>({
  name: '张三',
  avatar: '👤',
  integral: 1250,
  monthUsed: 300,
  monthTotal: 1000,
  validDays: 15
})

// 导航标签
const tabs = ref([
  { id: 'demand', name: '需求提交', icon: '💬', badge: null },
  { id: 'integral', name: '积分加速', icon: '🪙', badge: null },
  { id: 'projects', name: '项目管理', icon: '📁', badge: 3 },
  { id: 'delivery', name: '成果交付', icon: '📦', badge: 2 }
])

// 需求提交系统数据
const userInput = ref<string>('')
const isAIThinking = ref<boolean>(false)
const chatMessages = ref<ChatMessage[]>([])
const quickQuestions = ref<string[]>([
  '我想做一个电商小程序',
  '需要开发一个H5小游戏',
  '制作一个工具类网页应用',
  '需要创业方案策划'
])

// 需求摘要
const demandSummary = ref<DemandSummary>({
  type: '',
  platforms: [],
  functions: [],
  budget: '',
  deadline: ''
})

const uploadedFiles = ref<UploadedFile[]>([
  { name: '需求文档.docx', type: 'doc', size: 1024 * 50 },
  { name: '设计草图.png', type: 'image', size: 1024 * 200 }
])

// 积分系统数据
const selectedRecharge = ref<string>('option2')
const rechargeOptions = ref<RechargeOption[]>([
  { id: 'option1', integral: 100, price: 10 },
  { id: 'option2', integral: 1000, price: 99 },
  { id: 'option3', integral: 3000, price: 280, bonus: 300 },
  { id: 'option4', integral: 10000, price: 900, bonus: 1500 }
])

const accelerationServices = ref<AccelerationService[]>([
  { id: 'urgent', icon: '⚡', name: '紧急加急', description: '24小时内优先处理', cost: 500 },
  { id: 'expert', icon: '👨‍💼', name: '专家对接', description: '专属高级策划师服务', cost: 300 },
  { id: 'revision', icon: '✏️', name: '快速修改', description: '修改请求优先处理', cost: 200 },
  { id: 'priority', icon: '🎯', name: '优先队列', description: '项目处理队列优先', cost: 150 }
])

const integralRecords = ref<IntegralRecord[]>([
  { id: '1', type: 'recharge', description: '月度套餐充值', amount: 1000, time: new Date(Date.now() - 86400000 * 5) },
  { id: '2', type: 'consume', description: '小程序项目生成', amount: 300, time: new Date(Date.now() - 86400000 * 4) },
  { id: '3', type: 'consume', description: '紧急加急服务', amount: 500, time: new Date(Date.now() - 86400000 * 3) },
  { id: '4', type: 'recharge', description: '积分充值', amount: 500, time: new Date(Date.now() - 86400000 * 2) },
  { id: '5', type: 'consume', description: 'H5游戏生成', amount: 400, time: new Date(Date.now() - 86400000 * 1) }
])

// 项目管理数据
const filterStatus = ref<string>('all')
const searchKeyword = ref<string>('')
const projectStatuses = ref([
  { label: '全部', value: 'all' },
  { label: '待处理', value: 'pending' },
  { label: '进行中', value: 'in_progress' },
  { label: '审核中', value: 'reviewing' },
  { label: '已完成', value: 'completed' }
])

const projectSteps = ref([
  { label: '需求确认', value: 'confirm' },
  { label: '方案策划', value: 'plan' },
  { label: '设计制作', value: 'design' },
  { label: '开发实现', value: 'develop' },
  { label: '测试交付', value: 'deliver' }
])

const projects = ref<Project[]>([
  {
    id: '1',
    name: '宠物电商小程序',
    type: '小程序',
    status: 'in_progress',
    createTime: new Date(Date.now() - 86400000 * 3),
    estimatedTime: new Date(Date.now() + 86400000 * 2),
    assignedTo: '李策划师',
    progress: 65,
    currentStep: 'develop',
    accelerationCost: 300
  },
  {
    id: '2',
    name: '节日营销H5游戏',
    type: 'H5游戏',
    status: 'reviewing',
    createTime: new Date(Date.now() - 86400000 * 5),
    estimatedTime: new Date(Date.now() + 86400000),
    assignedTo: '王策划师',
    progress: 95,
    currentStep: 'deliver',
    accelerationCost: 400
  },
  {
    id: '3',
    name: '在线教育平台',
    type: '网页应用',
    status: 'pending',
    createTime: new Date(Date.now() - 86400000 * 1),
    estimatedTime: new Date(Date.now() + 86400000 * 4),
    progress: 10,
    currentStep: 'confirm',
    accelerationCost: 800
  },
  {
    id: '4',
    name: '企业官网',
    type: '网页应用',
    status: 'completed',
    createTime: new Date(Date.now() - 86400000 * 10),
    estimatedTime: new Date(Date.now() - 86400000 * 2),
    assignedTo: '张策划师',
    progress: 100,
    currentStep: 'deliver',
    accelerationCost: 500,
    deliveryTime: new Date(Date.now() - 86400000 * 2)
  }
])

// 成果交付数据
const deliveredProjects = ref<Project[]>([
  {
    id: '4',
    name: '企业官网',
    type: '网页应用',
    status: 'completed',
    createTime: new Date(Date.now() - 86400000 * 10),
    estimatedTime: new Date(Date.now() - 86400000 * 2),
    progress: 100,
    currentStep: 'deliver',
    accelerationCost: 500,
    deliveryTime: new Date(Date.now() - 86400000 * 2),
    files: [
      { name: '项目源代码.zip', type: 'zip', size: 1024 * 2048, url: '#' },
      { name: '部署文档.pdf', type: 'pdf', size: 1024 * 512, url: '#' },
      { name: '数据库文件.sql', type: 'sql', size: 1024 * 1024, url: '#' }
    ],
    deploymentGuide: '解压项目文件，配置数据库连接，运行安装脚本即可部署。',
    supportInfo: {
      period: '7天',
      contact: '微信客服：creativedream_ai'
    }
  },
  {
    id: '5',
    name: '员工管理系统',
    type: 'PC应用',
    status: 'completed',
    createTime: new Date(Date.now() - 86400000 * 20),
    estimatedTime: new Date(Date.now() - 86400000 * 12),
    progress: 100,
    currentStep: 'deliver',
    accelerationCost: 600,
    deliveryTime: new Date(Date.now() - 86400000 * 12),
    files: [
      { name: '安装包.exe', type: 'exe', size: 1024 * 4096, url: '#' },
      { name: '使用手册.docx', type: 'doc', size: 1024 * 256, url: '#' },
      { name: '配置说明.pdf', type: 'pdf', size: 1024 * 300, url: '#' }
    ],
    deploymentGuide: '运行安装包，按照向导完成安装，首次运行需初始化数据库。',
    supportInfo: {
      period: '30天',
      contact: '邮箱：support@creativedream.ai'
    }
  }
])

const deliveryStats = ref<DeliveryStats>({
  totalProjects: 8,
  averageRating: 4.8,
  averageDays: 3.5,
  successRate: 96
})

// 计算属性
const canSubmit = computed(() => {
  return demandSummary.value.type && demandSummary.value.platforms.length > 0
})

const selectedRechargePrice = computed(() => {
  const option = rechargeOptions.value.find(opt => opt.id === selectedRecharge.value)
  return option?.price || 0
})

const filteredProjects = computed(() => {
  return projects.value.filter(project => {
    const matchesStatus = filterStatus.value === 'all' || project.status === filterStatus.value
    const matchesKeyword = !searchKeyword.value || 
      project.name.toLowerCase().includes(searchKeyword.value.toLowerCase())
    return matchesStatus && matchesKeyword
  })
})

// 方法
const formatTime = (date: Date) => {
  return date.toLocaleDateString('zh-CN') + ' ' + date.toLocaleTimeString('zh-CN', { 
    hour: '2-digit', 
    minute: '2-digit' 
  })
}

const formatFileSize = (bytes: number) => {
  if (bytes < 1024) return bytes + ' B'
  if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB'
  return (bytes / (1024 * 1024)).toFixed(1) + ' MB'
}

const getFileIcon = (type: string) => {
  const icons: Record<string, string> = {
    'doc': '📄',
    'pdf': '📕',
    'image': '🖼️',
    'zip': '📦',
    'exe': '⚙️',
    'sql': '🗃️'
  }
  return icons[type] || '📎'
}

const getProjectIcon = (type: string) => {
  const icons: Record<string, string> = {
    '小程序': '🟢',
    'H5游戏': '🎮',
    '网页应用': '🌐',
    'PC应用': '💻',
    '安卓应用': '📱'
  }
  return icons[type] || '📁'
}

const getStatusText = (status: string) => {
  const statusMap: Record<string, string> = {
    'pending': '待处理',
    'in_progress': '进行中',
    'reviewing': '审核中',
    'completed': '已完成',
    'cancelled': '已取消'
  }
  return statusMap[status] || status
}

const isStepCompleted = (project: Project, stepValue: string) => {
  const stepOrder = projectSteps.value.map(step => step.value)
  const currentIndex = stepOrder.indexOf(project.currentStep)
  const stepIndex = stepOrder.indexOf(stepValue)
  return stepIndex < currentIndex
}

const getProjectCount = (status: string) => {
  if (status === 'all') return projects.value.length
  return projects.value.filter(p => p.status === status).length
}

// 需求提交系统方法
const sendMessage = async () => {
  if (!userInput.value.trim()) return

  const userMessage: ChatMessage = {
    type: 'user',
    content: userInput.value,
    time: new Date()
  }

  chatMessages.value.push(userMessage)
  
  const userText = userInput.value.toLowerCase()
  userInput.value = ''
  
  // AI思考中
  isAIThinking.value = true
  
  // 模拟AI响应
  setTimeout(() => {
    isAIThinking.value = false
    
    let aiResponse = ''
    let options: string[] = []
    
    // 简单的关键词匹配
    if (userText.includes('电商') || userText.includes('商城')) {
      demandSummary.value.type = '电商类'
      aiResponse = '了解了，您需要创建一个电商类项目。请选择目标平台：'
      options = ['微信小程序', 'H5网页', '安卓应用', '全部平台']
      demandSummary.value.platforms = []
    } else if (userText.includes('游戏') || userText.includes('娱乐')) {
      demandSummary.value.type = '游戏娱乐类'
      aiResponse = '好的，游戏类项目。请告诉我游戏类型：'
      options = ['休闲小游戏', '策略游戏', '角色扮演', '益智游戏']
    } else if (userText.includes('工具') || userText.includes('实用')) {
      demandSummary.value.type = '工具类'
      aiResponse = '明白了，工具类应用。请描述主要功能：'
    } else if (userText.includes('创业') || userText.includes('方案')) {
      demandSummary.value.type = '创业方案'
      aiResponse = '创业方案策划，需要详细的商业计划和产品设计。请说明行业方向：'
    } else {
      aiResponse = '感谢您的描述！为了更好地理解您的需求，请告诉我项目的主要类型是什么？'
      options = ['电商类', '游戏娱乐类', '工具类', '社交类', '教育类', '创业方案']
    }
    
    const aiMessage: ChatMessage = {
      type: 'ai',
      content: aiResponse,
      time: new Date(),
      options: options
    }
    
    chatMessages.value.push(aiMessage)
    scrollToBottom()
  }, 1000)
  
  scrollToBottom()
}

const sendQuickQuestion = (question: string) => {
  userInput.value = question
  sendMessage()
}

const selectOption = (option: string) => {
  const userText = option
  
  // 根据选项更新需求摘要
  if (['微信小程序', 'H5网页', '安卓应用', '全部平台'].includes(option)) {
    if (option === '全部平台') {
      demandSummary.value.platforms = ['微信小程序', 'H5网页', '安卓应用']
    } else {
      if (!demandSummary.value.platforms.includes(option)) {
        demandSummary.value.platforms.push(option)
      }
    }
    
    const aiMessage: ChatMessage = {
      type: 'ai',
      content: `已记录平台需求：${demandSummary.value.platforms.join(', ')}。请描述项目的主要功能：`,
      time: new Date(),
      options: ['商品展示与购买', '用户登录注册', '在线支付', '社交分享', '数据统计']
    }
    
    chatMessages.value.push(aiMessage)
    scrollToBottom()
    
  } else if (['商品展示与购买', '用户登录注册', '在线支付'].includes(option)) {
    demandSummary.value.functions.push(option)
    
    const aiMessage: ChatMessage = {
      type: 'ai',
      content: `功能需求已记录。请选择预算范围：`,
      time: new Date(),
      options: ['基础版（300-500积分）', '标准版（500-800积分）', '高级版（800-1200积分）']
    }
    
    chatMessages.value.push(aiMessage)
    scrollToBottom()
    
  } else if (option.includes('基础版') || option.includes('标准版') || option.includes('高级版')) {
    demandSummary.value.budget = option
    
    const aiMessage: ChatMessage = {
      type: 'ai',
      content: `预算已记录。请选择时间要求：`,
      time: new Date(),
      options: ['加急（1-2天）', '快速（3-5天）', '标准（5-7天）', '无特殊要求']
    }
    
    chatMessages.value.push(aiMessage)
    scrollToBottom()
    
  } else if (option.includes('加急') || option.includes('快速') || option.includes('标准')) {
    demandSummary.value.deadline = option
    
    const aiMessage: ChatMessage = {
      type: 'ai',
      content: '需求收集完成！您可以查看右侧的需求摘要，确认无误后提交。',
      time: new Date()
    }
    
    chatMessages.value.push(aiMessage)
    scrollToBottom()
  }
}

const uploadFile = () => {
  // 模拟文件上传
  const newFile: UploadedFile = {
    name: `需求文件_${new Date().getTime()}.txt`,
    type: 'doc',
    size: 1024 * 100
  }
  uploadedFiles.value.push(newFile)
}

const uploadImage = () => {
  const newFile: UploadedFile = {
    name: `设计参考_${new Date().getTime()}.png`,
    type: 'image',
    size: 1024 * 500
  }
  uploadedFiles.value.push(newFile)
}

const removeFile = (index: number) => {
  uploadedFiles.value.splice(index, 1)
}

const submitDemand = () => {
  if (userInfo.value.integral < 100) {
    alert('积分不足！请先充值积分。')
    return
  }
  
  // 创建新项目
  const newProject: Project = {
    id: Date.now().toString(),
    name: demandSummary.value.type + '项目',
    type: '小程序',
    status: 'pending',
    createTime: new Date(),
    estimatedTime: new Date(Date.now() + 86400000 * 5),
    progress: 10,
    currentStep: 'confirm',
    accelerationCost: 300
  }
  
  projects.value.unshift(newProject)
  userInfo.value.integral -= 100
  
  // 添加积分记录
  integralRecords.value.unshift({
    id: Date.now().toString(),
    type: 'consume',
    description: '项目需求提交',
    amount: 100,
    time: new Date()
  })
  
  // 重置需求表单
  demandSummary.value = {
    type: '',
    platforms: [],
    functions: [],
    budget: '',
    deadline: ''
  }
  chatMessages.value = []
  uploadedFiles.value = []
  
  alert('需求提交成功！项目已进入待处理队列。')
  activeTab.value = 'projects'
}

// 积分系统方法
const handleRecharge = () => {
  const option = rechargeOptions.value.find(opt => opt.id === selectedRecharge.value)
  if (!option) return
  
  userInfo.value.integral += option.integral + (option.bonus || 0)
  
  integralRecords.value.unshift({
    id: Date.now().toString(),
    type: 'recharge',
    description: '积分充值',
    amount: option.integral + (option.bonus || 0),
    time: new Date()
  })
  
  alert(`充值成功！获得${option.integral}积分${option.bonus ? `，额外赠送${option.bonus}积分` : ''}`)
}

const useAccelerationService = (service: AccelerationService) => {
  if (userInfo.value.integral < service.cost) {
    alert('积分不足！')
    return
  }
  
  userInfo.value.integral -= service.cost
  
  integralRecords.value.unshift({
    id: Date.now().toString(),
    type: 'consume',
    description: service.name,
    amount: service.cost,
    time: new Date()
  })
  
  alert(`${service.name}已启用！`)
}

// 项目管理方法
const accelerateProject = (project: Project) => {
  if (userInfo.value.integral < project.accelerationCost) {
    alert('积分不足！')
    return
  }
  
  userInfo.value.integral -= project.accelerationCost
  project.status = 'in_progress'
  project.assignedTo = '加速专员'
  
  integralRecords.value.unshift({
    id: Date.now().toString(),
    type: 'consume',
    description: '项目加速处理',
    amount: project.accelerationCost,
    time: new Date()
  })
  
  alert('项目已加速！已分配专属策划师处理。')
}

const viewProjectDetails = (project: Project) => {
  alert(`查看项目详情：${project.name}\n当前进度：${project.progress}%\n策划师：${project.assignedTo}`)
}

const downloadProject = (project: Project) => {
  alert(`开始下载项目：${project.name}`)
}

const reviewProject = (project: Project) => {
  alert(`项目审核反馈：${project.name}\n请查看策划师提交的内容并提出修改意见。`)
}

// 成果交付方法
const previewFile = (file: DeliveryFile) => {
  alert(`预览文件：${file.name}`)
}

const downloadFile = (file: DeliveryFile) => {
  alert(`下载文件：${file.name}`)
}

const downloadAll = (project: Project) => {
  alert(`下载项目 ${project.name} 的所有文件`)
}

const rateProject = (project: Project) => {
  const rating = prompt(`请为项目 ${project.name} 评分（1-5分）：`, '5')
  if (rating) {
    alert(`感谢您的评价！评分：${rating}分`)
  }
}

// 工具方法
const scrollToBottom = () => {
  nextTick(() => {
    const container = document.querySelector('.messages')
    if (container) {
      container.scrollTop = container.scrollHeight
    }
  })
}

// 生命周期
onMounted(() => {
  // 初始AI消息
  const initialMessage: ChatMessage = {
    type: 'ai',
    content: '请描述您的项目需求，或者选择快速提问开始。',
    time: new Date(),
    options: ['我想做一个电商小程序', '需要开发一个H5小游戏', '制作一个工具类网页应用']
  }
  
  chatMessages.value.push(initialMessage)
  
  // 更新时间
  setInterval(() => {
    currentTime.value = new Date()
  }, 60000)
})
</script>

<style scoped>
.dashboard {
  display: flex;
  min-height: 100vh;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  background: #f5f7fa;
}

/* 侧边栏样式 */
.sidebar {
  width: 260px;
  background: white;
  border-right: 1px solid #e5e7eb;
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
}

.sidebar-header {
  padding: 24px 20px;
  border-bottom: 1px solid #e5e7eb;
}

.logo {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 20px;
  font-weight: bold;
  color: #333;
}

.logo-icon {
  font-size: 24px;
}

.sidebar-nav {
  flex: 1;
  padding: 20px 0;
}

.nav-item {
  width: 100%;
  padding: 12px 20px;
  display: flex;
  align-items: center;
  gap: 12px;
  background: none;
  border: none;
  color: #666;
  font-size: 14px;
  text-align: left;
  cursor: pointer;
  position: relative;
  transition: all 0.2s;
}

.nav-item:hover {
  background: #f3f4f6;
  color: #667eea;
}

.nav-item.active {
  background: linear-gradient(to right, rgba(102, 126, 234, 0.1), transparent);
  color: #667eea;
  border-right: 3px solid #667eea;
}

.nav-icon {
  font-size: 18px;
}

.nav-badge {
  position: absolute;
  right: 20px;
  background: #ef4444;
  color: white;
  font-size: 12px;
  padding: 2px 6px;
  border-radius: 10px;
  min-width: 20px;
  text-align: center;
}

.sidebar-footer {
  padding: 20px;
  border-top: 1px solid #e5e7eb;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.user-avatar {
  width: 40px;
  height: 40px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 20px;
}

.user-details {
  flex: 1;
}

.user-name {
  font-weight: 600;
  color: #333;
  margin-bottom: 4px;
}

.user-integral {
  font-size: 12px;
  color: #666;
  display: flex;
  align-items: center;
  gap: 4px;
}

.integral-icon {
  font-size: 14px;
}

/* 主内容区样式 */
.main-content {
  flex: 1;
  padding: 24px;
  overflow-y: auto;
}

.tab-content {
  animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

.content-header {
  margin-bottom: 32px;
}

.content-title {
  font-size: 28px;
  font-weight: 700;
  color: #333;
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 8px;
}

.title-icon {
  font-size: 32px;
}

.content-subtitle {
  color: #666;
  font-size: 16px;
}

/* 需求提交系统样式 */
.demand-container {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 24px;
}

.ai-dialog {
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  overflow: hidden;
}

.dialog-header {
  padding: 20px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.dialog-title {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 18px;
  font-weight: 600;
}

.ai-avatar {
  font-size: 24px;
}

.dialog-status {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 14px;
  opacity: 0.9;
}

.status-dot {
  width: 8px;
  height: 8px;
  background: #4ade80;
  border-radius: 50%;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.dialog-body {
  display: flex;
  flex-direction: column;
  height: 600px;
}

.messages {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.message {
  display: flex;
  gap: 12px;
  max-width: 80%;
}

.message.user {
  align-self: flex-end;
  flex-direction: row-reverse;
}

.message-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: #f3f4f6;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  flex-shrink: 0;
}

.message.user .message-avatar {
  background: #667eea;
  color: white;
}

.message-content {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.message-text {
  padding: 12px 16px;
  background: #f3f4f6;
  border-radius: 12px;
  line-height: 1.5;
  color: #333;
}

.message.user .message-text {
  background: #667eea;
  color: white;
  border-radius: 12px 12px 0 12px;
}

.message-time {
  font-size: 12px;
  color: #999;
  padding: 0 4px;
}

.message.user .message-time {
  text-align: right;
}

.message-options {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-top: 8px;
}

.option-btn {
  background: rgba(102, 126, 234, 0.1);
  color: #667eea;
  border: 1px solid rgba(102, 126, 234, 0.3);
  padding: 8px 12px;
  border-radius: 8px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s;
}

.option-btn:hover {
  background: rgba(102, 126, 234, 0.2);
}

.typing-indicator {
  display: flex;
  gap: 4px;
  padding: 20px;
}

.typing-indicator span {
  width: 8px;
  height: 8px;
  background: #667eea;
  border-radius: 50%;
  animation: bounce 1.4s infinite;
}

.typing-indicator span:nth-child(2) { animation-delay: 0.2s; }
.typing-indicator span:nth-child(3) { animation-delay: 0.4s; }

@keyframes bounce {
  0%, 60%, 100% { transform: translateY(0); }
  30% { transform: translateY(-10px); }
}

.dialog-input {
  border-top: 1px solid #e5e7eb;
  padding: 20px;
}

.quick-questions {
  margin-bottom: 16px;
}

.quick-title {
  font-size: 14px;
  color: #666;
  margin-bottom: 8px;
}

.quick-buttons {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.quick-btn {
  background: #f3f4f6;
  border: none;
  padding: 6px 12px;
  border-radius: 16px;
  font-size: 13px;
  color: #666;
  cursor: pointer;
  transition: all 0.2s;
}

.quick-btn:hover {
  background: #e5e7eb;
}

.input-area {
  position: relative;
}

.message-input {
  width: 100%;
  padding: 12px 16px;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  resize: none;
  font-size: 14px;
  line-height: 1.5;
  transition: border-color 0.2s;
}

.message-input:focus {
  outline: none;
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.input-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 12px;
}

.input-tools {
  display: flex;
  gap: 8px;
}

.tool-btn {
  background: none;
  border: none;
  font-size: 18px;
  color: #666;
  cursor: pointer;
  padding: 4px;
  border-radius: 4px;
  transition: all 0.2s;
}

.tool-btn:hover {
  background: #f3f4f6;
  color: #667eea;
}

.send-btn {
  background: #667eea;
  color: white;
  border: none;
  padding: 8px 24px;
  border-radius: 8px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
}

.send-btn:hover:not(:disabled) {
  background: #5a6fd8;
  transform: translateY(-1px);
}

.send-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* 需求摘要样式 */
.demand-summary {
  background: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.summary-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 1px solid #e5e7eb;
}

.summary-header h3 {
  font-size: 18px;
  color: #333;
}

.summary-content {
  display: flex;
  flex-direction: column;
  gap: 16px;
  margin-bottom: 24px;
}

.summary-item {
  display: flex;
  gap: 8px;
}

.summary-item label {
  color: #666;
  min-width: 80px;
}

.summary-item span {
  color: #333;
  font-weight: 500;
}

.tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.tag {
  background: rgba(102, 126, 234, 0.1);
  color: #667eea;
  padding: 4px 8px;
  border-radius: 6px;
  font-size: 13px;
}

.uploaded-files {
  border-top: 1px solid #e5e7eb;
  padding-top: 20px;
}

.uploaded-files h4 {
  font-size: 16px;
  color: #333;
  margin-bottom: 12px;
}

.files-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.file-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  background: #f9fafb;
  border-radius: 8px;
  transition: all 0.2s;
}

.file-item:hover {
  background: #f3f4f6;
}

.file-icon {
  font-size: 20px;
}

.file-info {
  flex: 1;
}

.file-name {
  font-size: 14px;
  color: #333;
  margin-bottom: 2px;
}

.file-size {
  font-size: 12px;
  color: #999;
}

.file-delete {
  background: none;
  border: none;
  font-size: 20px;
  color: #999;
  cursor: pointer;
  padding: 0 4px;
  border-radius: 4px;
  transition: all 0.2s;
}

.file-delete:hover {
  color: #ef4444;
  background: rgba(239, 68, 68, 0.1);
}

/* 积分系统样式 */
.integral-container {
  display: flex;
  flex-direction: column;
  gap: 32px;
}

.integral-overview {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
}

.overview-card {
  background: white;
  border-radius: 12px;
  padding: 24px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  transition: transform 0.2s;
}

.overview-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.overview-icon {
  font-size: 32px;
}

.overview-content {
  flex: 1;
}

.overview-value {
  font-size: 28px;
  font-weight: 700;
  color: #333;
  margin-bottom: 4px;
}

.overview-label {
  font-size: 14px;
  color: #666;
}

.integral-recharge, .acceleration-services, .integral-records {
  background: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.integral-recharge h3, .acceleration-services h3, .integral-records h3 {
  font-size: 18px;
  color: #333;
  margin-bottom: 20px;
}

.recharge-options {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 16px;
  margin-bottom: 24px;
}

.recharge-option {
  border: 2px solid #e5e7eb;
  border-radius: 12px;
  padding: 20px;
  text-align: center;
  cursor: pointer;
  transition: all 0.2s;
}

.recharge-option:hover {
  border-color: rgba(102, 126, 234, 0.5);
}

.recharge-option.selected {
  border-color: #667eea;
  background: rgba(102, 126, 234, 0.05);
}

.recharge-amount {
  font-size: 20px;
  font-weight: 600;
  color: #333;
  margin-bottom: 4px;
}

.recharge-price {
  font-size: 18px;
  color: #667eea;
  font-weight: 600;
  margin-bottom: 8px;
}

.recharge-bonus {
  font-size: 12px;
  color: #4ade80;
  background: rgba(74, 222, 128, 0.1);
  padding: 4px 8px;
  border-radius: 20px;
}

.recharge-btn {
  width: 100%;
  padding: 14px;
  font-size: 16px;
  font-weight: 600;
}

.services-list {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  margin-bottom: 24px;
}

.service-card {
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 16px;
  transition: all 0.2s;
}

.service-card:hover {
  border-color: #667eea;
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.1);
}

.service-icon {
  font-size: 32px;
}

.service-content {
  flex: 1;
}

.service-content h4 {
  font-size: 16px;
  color: #333;
  margin-bottom: 8px;
}

.service-content p {
  font-size: 14px;
  color: #666;
  margin-bottom: 12px;
  line-height: 1.5;
}

.service-cost {
  font-size: 14px;
  color: #667eea;
  font-weight: 600;
}

.service-btn {
  width: 100%;
  padding: 10px;
  font-size: 14px;
}

.records-list {
  max-height: 300px;
  overflow-y: auto;
}

.record-item {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
  gap: 16px;
  padding: 16px;
  border-bottom: 1px solid #f3f4f6;
  align-items: center;
}

.record-item:last-child {
  border-bottom: none;
}

.record-type {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #333;
}

.record-icon {
  font-size: 14px;
}

.record-icon.recharge {
  color: #4ade80;
}

.record-icon.consume {
  color: #f87171;
}

.record-amount {
  font-weight: 600;
  text-align: right;
}

.record-amount.recharge {
  color: #4ade80;
}

.record-amount.consume {
  color: #f87171;
}

.record-time {
  font-size: 12px;
  color: #999;
  text-align: right;
}

/* 项目管理样式 */
.projects-container {
  background: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.projects-filter {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 1px solid #e5e7eb;
}

.filter-tabs {
  display: flex;
  gap: 8px;
}

.filter-tab {
  background: none;
  border: 1px solid #e5e7eb;
  padding: 8px 16px;
  border-radius: 8px;
  color: #666;
  font-size: 14px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 6px;
  transition: all 0.2s;
}

.filter-tab:hover {
  border-color: #667eea;
  color: #667eea;
}

.filter-tab.active {
  background: #667eea;
  border-color: #667eea;
  color: white;
}

.tab-count {
  background: rgba(255, 255, 255, 0.2);
  padding: 2px 6px;
  border-radius: 10px;
  font-size: 12px;
}

.filter-search {
  display: flex;
  gap: 8px;
}

.search-input {
  padding: 8px 12px;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  font-size: 14px;
  min-width: 200px;
}

.search-input:focus {
  outline: none;
  border-color: #667eea;
}

.search-btn {
  background: #667eea;
  color: white;
  border: none;
  width: 40px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
}

.search-btn:hover {
  background: #5a6fd8;
}

.projects-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.project-card {
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  padding: 24px;
  transition: all 0.2s;
}

.project-card:hover {
  border-color: #667eea;
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.1);
}

.project-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.project-title {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.project-icon {
  font-size: 24px;
}

.project-status {
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 500;
}

.project-status.pending {
  background: rgba(251, 191, 36, 0.1);
  color: #f59e0b;
}

.project-status.in_progress {
  background: rgba(59, 130, 246, 0.1);
  color: #3b82f6;
}

.project-status.reviewing {
  background: rgba(168, 85, 247, 0.1);
  color: #a855f7;
}

.project-status.completed {
  background: rgba(34, 197, 94, 0.1);
  color: #22c55e;
}

.project-status.cancelled {
  background: rgba(239, 68, 68, 0.1);
  color: #ef4444;
}

.project-info {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 12px;
  margin-bottom: 20px;
}

.info-item {
  font-size: 14px;
  color: #666;
}

.info-label {
  color: #999;
}

.project-progress {
  margin-bottom: 24px;
}

.progress-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.progress-header span {
  font-size: 14px;
  color: #333;
  font-weight: 500;
}

.progress-bar {
  height: 8px;
  background: #f3f4f6;
  border-radius: 4px;
  overflow: hidden;
  margin-bottom: 16px;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #667eea, #764ba2);
  border-radius: 4px;
  transition: width 0.3s ease;
}

.progress-steps {
  display: flex;
  justify-content: space-between;
  position: relative;
}

.progress-steps::before {
  content: '';
  position: absolute;
  top: 6px;
  left: 0;
  right: 0;
  height: 2px;
  background: #f3f4f6;
  z-index: 1;
}

.progress-step {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  position: relative;
  z-index: 2;
}

.step-dot {
  width: 14px;
  height: 14px;
  background: #d1d5db;
  border-radius: 50%;
  border: 2px solid white;
}

.progress-step.active .step-dot {
  background: #667eea;
}

.progress-step.completed .step-dot {
  background: #22c55e;
}

.step-label {
  font-size: 12px;
  color: #999;
  white-space: nowrap;
}

.progress-step.active .step-label {
  color: #667eea;
  font-weight: 500;
}

.progress-step.completed .step-label {
  color: #22c55e;
}

.project-actions {
  display: flex;
  gap: 12px;
}

/* 成果交付样式 */
.delivery-container {
  display: flex;
  flex-direction: column;
  gap: 32px;
}

.delivered-projects, .delivery-stats {
  background: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.delivered-projects h3, .delivery-stats h3 {
  font-size: 18px;
  color: #333;
  margin-bottom: 20px;
}

.projects-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 20px;
}

.delivery-card {
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 20px;
  transition: all 0.2s;
}

.delivery-card:hover {
  border-color: #667eea;
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.1);
}

.delivery-header {
  display: flex;
  align-items: center;
  gap: 16px;
}

.delivery-icon {
  font-size: 32px;
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
}

.delivery-info h4 {
  font-size: 18px;
  color: #333;
  margin-bottom: 4px;
}

.delivery-time {
  font-size: 12px;
  color: #999;
}

.delivery-content {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.delivery-files .files-title {
  font-size: 14px;
  color: #666;
  margin-bottom: 12px;
}

.files-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.file-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  background: #f9fafb;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
}

.file-item:hover {
  background: #f3f4f6;
}

.file-details {
  flex: 1;
}

.file-name {
  font-size: 14px;
  color: #333;
  margin-bottom: 2px;
}

.file-download {
  background: none;
  border: none;
  font-size: 16px;
  color: #999;
  cursor: pointer;
  padding: 4px;
  border-radius: 4px;
  transition: all 0.2s;
}

.file-download:hover {
  color: #667eea;
  background: rgba(102, 126, 234, 0.1);
}

.deployment-guide, .support-info {
  padding-top: 16px;
  border-top: 1px solid #f3f4f6;
}

.deployment-guide h5, .support-info h5 {
  font-size: 14px;
  color: #333;
  margin-bottom: 8px;
}

.guide-content, .support-content {
  font-size: 13px;
  color: #666;
  line-height: 1.5;
}

.delivery-actions {
  display: flex;
  gap: 12px;
  padding-top: 16px;
  border-top: 1px solid #f3f4f6;
}

.stats-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 20px;
}

.stats-card {
  background: #f9fafb;
  border-radius: 12px;
  padding: 20px;
  display: flex;
  align-items: center;
  gap: 16px;
}

.stats-icon {
  font-size: 32px;
}

.stats-content {
  flex: 1;
}

.stats-value {
  font-size: 24px;
  font-weight: 700;
  color: #333;
  margin-bottom: 4px;
}

.stats-label {
  font-size: 14px;
  color: #666;
}

/* 按钮样式 */
.btn {
  padding: 10px 20px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
  border: none;
}

.btn-primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.btn-primary:hover:not(:disabled) {
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}

.btn-primary:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-outline {
  background: transparent;
  border: 1px solid #667eea;
  color: #667eea;
}

.btn-outline:hover {
  background: rgba(102, 126, 234, 0.1);
}

.btn-block {
  width: 100%;
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .demand-container {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 992px) {
  .dashboard {
    flex-direction: column;
  }
  
  .sidebar {
    width: 100%;
    flex-direction: column;
    padding: 0;
    border-right: none;
    border-bottom: 1px solid #e5e7eb;
  }
  
  .sidebar-header {
    padding: 16px 20px;
    border-bottom: 1px solid #e5e7eb;
  }
  
  .sidebar-nav {
    display: flex;
    flex-direction: row;
    padding: 16px 20px;
    overflow-x: auto;
    gap: 8px;
    border-bottom: 1px solid #e5e7eb;
  }
  
  .nav-item {
    padding: 12px 16px;
    justify-content: flex-start;
    white-space: nowrap;
    flex-shrink: 0;
    min-width: fit-content;
  }
  
  .nav-text {
    display: inline;
  }
  
  .sidebar-footer {
    padding: 16px 20px;
  }
  
  .main-content {
    padding: 16px;
  }
}

@media (max-width: 768px) {
  .sidebar-nav {
    overflow-x: auto;
  }
  
  .projects-filter {
    flex-direction: column;
    gap: 16px;
    align-items: stretch;
  }
  
  .filter-tabs {
    overflow-x: auto;
    padding-bottom: 8px;
  }
  
  .project-info {
    grid-template-columns: 1fr;
  }
  
  .progress-steps {
    flex-direction: column;
    gap: 12px;
  }
  
  .progress-steps::before {
    display: none;
  }
  
  .progress-step {
    flex-direction: row;
    gap: 12px;
  }
  
  .step-dot {
    width: 20px;
    height: 20px;
  }
}
</style>