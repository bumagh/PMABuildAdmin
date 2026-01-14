<template>
  <div class="landing-page">
    <!-- 导航栏 -->
    <nav class="navbar">
      <div class="nav-container">
        <div class="logo">
          <div class="logo-icon">W</div>
          <span class="logo-text">瓦路Value</span>
        </div>
        <div class="nav-links">
          <a href="#features" class="nav-link">核心功能</a>
          <a href="#how-it-works" class="nav-link">如何运作</a>
          <a href="#ecosystem" class="nav-link">价值生态</a>
          <a href="#community" class="nav-link">社区治理</a>
        </div>
        <div class="nav-actions">
          <button class="btn btn-outline" @click="openWaitlist">加入等候名单</button>
          <button class="btn btn-primary" @click="scrollToCTA">立即体验</button>
        </div>
        <button class="mobile-menu-btn" @click="toggleMobileMenu">
          <span class="bar"></span>
          <span class="bar"></span>
          <span class="bar"></span>
        </button>
      </div>
      
      <!-- 移动端菜单 -->
      <div v-if="showMobileMenu" class="mobile-menu">
        <a href="#features" class="mobile-nav-link" @click="closeMobileMenu">核心功能</a>
        <a href="#how-it-works" class="mobile-nav-link" @click="closeMobileMenu">如何运作</a>
        <a href="#ecosystem" class="mobile-nav-link" @click="closeMobileMenu">价值生态</a>
        <a href="#community" class="mobile-nav-link" @click="closeMobileMenu">社区治理</a>
        <div class="mobile-actions">
          <button class="btn btn-outline" @click="openWaitlist">加入等候名单</button>
          <button class="btn btn-primary" @click="scrollToCTA">立即体验</button>
        </div>
      </div>
    </nav>

    <!-- 英雄区域 -->
    <section class="hero-section">
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">
            激活你的<span class="highlight">闲置价值</span>
            <br />构建去中心化价值交换网络
          </h1>
          <p class="hero-subtitle">
            告别中间商，AI公平定价，100%价值归创造者
            <br />从空座位到专业技能，让一切闲置资源流动起来
          </p>
          <div class="hero-actions">
            <button class="btn btn-primary btn-large" @click="scrollToCTA">
              开始赚取瓦路值
              <span class="icon">→</span>
            </button>
            <button class="btn btn-secondary btn-large" @click="playDemoVideo">
              <span class="icon">▶</span>
              观看演示
            </button>
          </div>
          <div class="hero-stats">
            <div class="stat">
              <div class="stat-value">0%</div>
              <div class="stat-label">平台抽成</div>
            </div>
            <div class="stat">
              <div class="stat-value">AI</div>
              <div class="stat-label">动态定价</div>
            </div>
            <div class="stat">
              <div class="stat-value">DAO</div>
              <div class="stat-label">社区治理</div>
            </div>
          </div>
        </div>
        <div class="hero-visual">
          <div class="phone-mockup">
            <div class="phone-screen">
              <div class="app-header">
                <div class="walue-badge">WLV</div>
                <div class="balance">余额: <span class="value">1,245.67</span></div>
              </div>
              <div class="app-content">
                <div class="transaction-card" v-for="tx in demoTransactions" :key="tx.id">
                  <div class="tx-icon" :class="tx.type">{{ tx.icon }}</div>
                  <div class="tx-details">
                    <div class="tx-title">{{ tx.title }}</div>
                    <div class="tx-time">{{ tx.time }}</div>
                  </div>
                  <div class="tx-amount" :class="{ 'income': tx.amount > 0 }">
                    {{ tx.amount > 0 ? '+' : '' }}{{ tx.amount }} WLV
                  </div>
                </div>
              </div>
              <div class="app-nav">
                <div class="nav-item active">首页</div>
                <div class="nav-item">发布</div>
                <div class="nav-item">市场</div>
                <div class="nav-item">我的</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 波浪背景 -->
      <div class="wave-background">
        <svg viewBox="0 0 1200 120" preserveAspectRatio="none">
          <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" fill="currentColor"></path>
          <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" fill="currentColor"></path>
          <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" fill="currentColor"></path>
        </svg>
      </div>
    </section>

    <!-- 核心功能 -->
    <section id="features" class="features-section">
      <div class="section-header">
        <h2 class="section-title">为什么选择瓦路Value？</h2>
        <p class="section-subtitle">去中心化价值交换的下一代平台</p>
      </div>
      
      <div class="features-grid">
        <div class="feature-card" v-for="feature in features" :key="feature.id">
          <div class="feature-icon">{{ feature.icon }}</div>
          <h3 class="feature-title">{{ feature.title }}</h3>
          <p class="feature-description">{{ feature.description }}</p>
          <div class="feature-details">
            <div class="detail" v-for="detail in feature.details" :key="detail">
              <span class="check">✓</span> {{ detail }}
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 如何运作 -->
    <section id="how-it-works" class="how-it-works-section">
      <div class="section-header">
        <h2 class="section-title">AI自主定价，公平透明</h2>
        <p class="section-subtitle">体验前所未有的价值交换方式</p>
      </div>
      
      <div class="pricing-demo">
        <div class="pricing-inputs">
          <div class="input-group">
            <label>服务类型</label>
            <select v-model="pricingDemo.serviceType" @change="calculatePrice">
              <option value="ride">顺风车行程</option>
              <option value="skill">技能服务</option>
              <option value="item">物品共享</option>
              <option value="space">空间共享</option>
            </select>
          </div>
          
          <div class="input-group" v-if="pricingDemo.serviceType === 'ride'">
            <label>行程距离 (公里)</label>
            <input 
              type="range" 
              v-model.number="pricingDemo.distance" 
              min="1" 
              max="50" 
              @input="calculatePrice"
            />
            <div class="range-value">{{ pricingDemo.distance }} km</div>
          </div>
          
          <div class="input-group" v-if="pricingDemo.serviceType === 'skill'">
            <label>服务时长 (小时)</label>
            <input 
              type="range" 
              v-model.number="pricingDemo.duration" 
              min="0.5" 
              max="10" 
              step="0.5"
              @input="calculatePrice"
            />
            <div class="range-value">{{ pricingDemo.duration }} 小时</div>
          </div>
          
          <div class="input-group">
            <label>需求强度</label>
            <div class="demand-indicator">
              <button 
                v-for="level in demandLevels" 
                :key="level.value"
                :class="{ active: pricingDemo.demand === level.value }"
                @click="pricingDemo.demand = level.value; calculatePrice()"
              >
                {{ level.label }}
              </button>
            </div>
          </div>
          
          <div class="input-group">
            <label>信用评分</label>
            <div class="credit-slider">
              <div class="credit-labels">
                <span>新用户</span>
                <span>优秀</span>
              </div>
              <input 
                type="range" 
                v-model.number="pricingDemo.creditScore" 
                min="300" 
                max="950" 
                @input="calculatePrice"
              />
              <div class="credit-score">{{ pricingDemo.creditScore }}</div>
            </div>
          </div>
        </div>
        
        <div class="pricing-result">
          <div class="ai-thinking" v-if="calculating">
            <div class="ai-dots">
              <div class="dot"></div>
              <div class="dot"></div>
              <div class="dot"></div>
            </div>
            AI正在计算公平价格...
          </div>
          
          <div v-else class="price-breakdown">
            <h3>AI定价结果</h3>
            <div class="final-price">
              {{ pricingDemo.finalPrice.toFixed(2) }} <span class="currency">WLV</span>
            </div>
            
            <div class="breakdown">
              <div class="breakdown-item">
                <span class="label">基础价值</span>
                <span class="value">{{ pricingDemo.baseValue.toFixed(2) }} WLV</span>
              </div>
              <div class="breakdown-item">
                <span class="label">需求调节</span>
                <span class="value">× {{ pricingDemo.demandMultiplier.toFixed(2) }}</span>
              </div>
              <div class="breakdown-item">
                <span class="label">信用奖励</span>
                <span class="value">+{{ pricingDemo.creditBonus.toFixed(2) }} WLV</span>
              </div>
              <div class="breakdown-item highlight">
                <span class="label">您将获得</span>
                <span class="value">{{ pricingDemo.finalPrice.toFixed(2) }} WLV</span>
              </div>
            </div>
            
            <div class="comparison">
              <div class="comparison-item walue">
                <div class="comparison-label">瓦路Value</div>
                <div class="comparison-value">100%归您</div>
              </div>
              <div class="comparison-item competitor">
                <div class="comparison-label">传统平台</div>
                <div class="comparison-value">{{ pricingDemo.competitorCut }}%抽成</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 价值生态 -->
    <section id="ecosystem" class="ecosystem-section">
      <div class="section-header">
        <h2 class="section-title">跨领域价值交换生态</h2>
        <p class="section-subtitle">用统一的价值度量衡连接一切</p>
      </div>
      
      <div class="ecosystem-visual">
        <div class="ecosystem-center">
          <div class="center-logo">W</div>
          <div class="center-text">瓦路值 (WLV)</div>
        </div>
        
        <div 
          class="ecosystem-node" 
          v-for="node in ecosystemNodes" 
          :key="node.id"
          :style="node.style"
        >
          <div class="node-icon">{{ node.icon }}</div>
          <div class="node-title">{{ node.title }}</div>
          <div class="node-value">{{ node.value }} WLV</div>
        </div>
      </div>
    </section>

    <!-- CTA区域 -->
    <section id="cta" class="cta-section">
      <div class="cta-content">
        <h2 class="cta-title">加入价值互联网革命</h2>
        <p class="cta-subtitle">
          现在加入前10万名用户，可获得
          <span class="highlight">100 WLV创始奖励</span>
        </p>
        
        <div class="waitlist-form">
          <div class="form-group">
            <input 
              type="email" 
              v-model="waitlistEmail" 
              placeholder="输入您的邮箱地址"
              @keyup.enter="joinWaitlist"
            />
            <button class="btn btn-primary" @click="joinWaitlist" :disabled="!isValidEmail">
              加入等候名单
            </button>
          </div>
          <div class="form-note">
            我们将在平台上线时第一时间通知您。您的邮箱仅用于通知，不会用于其他用途。
          </div>
          
          <div class="progress-container">
            <div class="progress-label">
              等候名单进度: {{ waitlistCount.toLocaleString() }} / 100,000
            </div>
            <div class="progress-bar">
              <div 
                class="progress-fill" 
                :style="{ width: `${(waitlistCount / 100000) * 100}%` }"
              ></div>
            </div>
          </div>
        </div>
        
        <div class="platform-coming">
          <div class="platform-item">
            <div class="platform-icon">📱</div>
            <div class="platform-info">
              <div class="platform-title">移动应用</div>
              <div class="platform-date">2024年第三季度</div>
            </div>
          </div>
          <div class="platform-item">
            <div class="platform-icon">🌐</div>
            <div class="platform-info">
              <div class="platform-title">网页平台</div>
              <div class="platform-date">现已开放测试</div>
            </div>
          </div>
          <div class="platform-item">
            <div class="platform-icon">🤖</div>
            <div class="platform-info">
              <div class="platform-title">AI定价引擎</div>
              <div class="platform-date">已上线测试</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 底部 -->
    <footer class="footer">
      <div class="footer-content">
        <div class="footer-section">
          <div class="footer-logo">
            <div class="logo-icon">W</div>
            <span class="logo-text">瓦路Value</span>
          </div>
          <p class="footer-description">
            去中心化价值交换平台<br />
            让闲置价值流动起来
          </p>
          <div class="social-links">
            <a href="#" class="social-link">Twitter</a>
            <a href="#" class="social-link">Discord</a>
            <a href="#" class="social-link">GitHub</a>
            <a href="#" class="social-link">白皮书</a>
          </div>
        </div>
        
        <div class="footer-section">
          <h4 class="footer-heading">平台</h4>
          <a href="#" class="footer-link">工作原理</a>
          <a href="#" class="footer-link">价值体系</a>
          <a href="#" class="footer-link">安全保障</a>
          <a href="#" class="footer-link">开发者API</a>
        </div>
        
        <div class="footer-section">
          <h4 class="footer-heading">社区</h4>
          <a href="#" class="footer-link">治理DAO</a>
          <a href="#" class="footer-link">社区论坛</a>
          <a href="#" class="footer-link">提案投票</a>
          <a href="#" class="footer-link">贡献指南</a>
        </div>
        
        <div class="footer-section">
          <h4 class="footer-heading">资源</h4>
          <a href="#" class="footer-link">帮助中心</a>
          <a href="#" class="footer-link">常见问题</a>
          <a href="#" class="footer-link">博客</a>
          <a href="#" class="footer-link">联系我们</a>
        </div>
      </div>
      
      <div class="footer-bottom">
        <div class="copyright">© 2024 瓦路Value协议. 基于MIT开源协议.</div>
        <div class="footer-links">
          <a href="#" class="footer-link">隐私政策</a>
          <a href="#" class="footer-link">使用条款</a>
          <a href="#" class="footer-link">免责声明</a>
        </div>
      </div>
    </footer>

    <!-- 演示视频模态框 -->
    <div v-if="showVideoModal" class="modal-overlay" @click="closeVideoModal">
      <div class="modal-content" @click.stop>
        <button class="modal-close" @click="closeVideoModal">×</button>
        <div class="video-container">
          <!-- 视频占位 -->
          <div class="video-placeholder">
            <div class="play-icon">▶</div>
            <p>瓦路Value平台演示视频</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'

// 响应式状态
const showMobileMenu = ref(false)
const showVideoModal = ref(false)
const waitlistEmail = ref('')
const waitlistCount = ref(45782)
const calculating = ref(false)

// 定价演示数据
const pricingDemo = ref({
  serviceType: 'ride',
  distance: 15,
  duration: 1,
  demand: 'medium',
  creditScore: 750,
  baseValue: 35,
  demandMultiplier: 1.2,
  creditBonus: 5,
  finalPrice: 47,
  competitorCut: 25
})

const demandLevels = [
  { value: 'low', label: '低需求' },
  { value: 'medium', label: '中等' },
  { value: 'high', label: '高需求' }
]

// 功能列表
const features = ref([
  {
    id: 1,
    icon: '🤖',
    title: 'AI自主定价',
    description: '基于实时供需、信用评分和资源价值的智能定价系统',
    details: [
      '消除人为偏见和歧视',
      '实时市场调节',
      '跨服务价值换算'
    ]
  },
  {
    id: 2,
    icon: '🔗',
    title: '去中心化交易',
    description: '基于区块链的智能合约，无中间商，100%价值归创造者',
    details: [
      '零平台抽成',
      '即时结算到账',
      '不可篡改的交易记录'
    ]
  },
  {
    id: 3,
    icon: '🏛️',
    title: 'DAO社区治理',
    description: '由WGV持有者共同治理的平台，真正实现社区所有',
    details: [
      '提案与投票系统',
      '社区争议仲裁',
      '协议参数调整'
    ]
  },
  {
    id: 4,
    icon: '🌐',
    title: '统一价值网络',
    description: '连接所有闲置资源，构建跨领域的价值交换生态',
    details: [
      '时间、技能、物品、空间互换',
      '个人信用体系',
      '可组合的价值服务'
    ]
  }
])

// 生态系统节点
const ecosystemNodes = ref([
  { id: 1, icon: '🚗', title: '顺风车', value: '15-80', style: { top: '20%', left: '10%' } },
  { id: 2, icon: '💼', title: '技能服务', value: '50-200', style: { top: '10%', left: '40%' } },
  { id: 3, icon: '🏠', title: '空间共享', value: '30-150', style: { top: '20%', right: '10%' } },
  { id: 4, icon: '📚', title: '知识共享', value: '20-100', style: { top: '50%', left: '5%' } },
  { id: 5, icon: '🐕', title: '宠物照看', value: '25-60', style: { top: '50%', right: '5%' } },
  { id: 6, icon: '🛠️', title: '工具借用', value: '10-40', style: { bottom: '20%', left: '15%' } },
  { id: 7, icon: '🎨', title: '创意服务', value: '75-300', style: { bottom: '10%', left: '45%' } },
  { id: 8, icon: '🛒', title: '代购跑腿', value: '15-50', style: { bottom: '20%', right: '15%' } }
])

// 演示交易记录
const demoTransactions = ref([
  { id: 1, icon: '🚗', title: '顺风车 - 中关村到国贸', time: '今天 08:30', amount: 77.45, type: 'ride' },
  { id: 2, icon: '💻', title: 'Python编程帮助', time: '昨天 14:20', amount: 125.00, type: 'skill' },
  { id: 3, icon: '🏠', title: '会议室共享', time: '昨天 10:15', amount: -30.00, type: 'space' },
  { id: 4, icon: '📦', title: '快递代取', time: '2天前', amount: 15.50, type: 'delivery' }
])

// 计算属性
const isValidEmail = computed(() => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  return emailRegex.test(waitlistEmail.value)
})

// 方法
const toggleMobileMenu = () => {
  showMobileMenu.value = !showMobileMenu.value
}

const closeMobileMenu = () => {
  showMobileMenu.value = false
}

const openWaitlist = () => {
  scrollToCTA()
}

const scrollToCTA = () => {
  const ctaSection = document.getElementById('cta')
  if (ctaSection) {
    ctaSection.scrollIntoView({ behavior: 'smooth' })
  }
  closeMobileMenu()
}

const playDemoVideo = () => {
  showVideoModal.value = true
}

const closeVideoModal = () => {
  showVideoModal.value = false
}

const calculatePrice = () => {
  calculating.value = true
  
  // 模拟AI计算延迟
  setTimeout(() => {
    let base = 0
    
    // 根据服务类型计算基础价值
    switch (pricingDemo.value.serviceType) {
      case 'ride':
        base = pricingDemo.value.distance * 2.5
        break
      case 'skill':
        base = pricingDemo.value.duration * 80
        break
      case 'item':
        base = 25
        break
      case 'space':
        base = 40
        break
    }
    
    // 需求乘数
    let demandMultiplier = 1.0
    switch (pricingDemo.value.demand) {
      case 'low':
        demandMultiplier = 0.8
        break
      case 'medium':
        demandMultiplier = 1.2
        break
      case 'high':
        demandMultiplier = 1.5
        break
    }
    
    // 信用奖励 (分数越高奖励越多)
    const creditBonus = (pricingDemo.value.creditScore - 300) / 650 * 20
    
    // 最终价格
    const finalPrice = base * demandMultiplier + creditBonus
    
    // 竞争对手抽成比例
    const competitorCut = pricingDemo.value.serviceType === 'skill' ? 30 : 25
    
    // 更新数据
    pricingDemo.value.baseValue = base
    pricingDemo.value.demandMultiplier = demandMultiplier
    pricingDemo.value.creditBonus = creditBonus
    pricingDemo.value.finalPrice = finalPrice
    pricingDemo.value.competitorCut = competitorCut
    
    calculating.value = false
  }, 800)
}

const joinWaitlist = () => {
  if (!isValidEmail.value) {
    alert('请输入有效的邮箱地址')
    return
  }
  
  // 模拟API调用
  waitlistCount.value += 1
  alert(`感谢加入！您是我们的第${waitlistCount.value.toLocaleString()}位等候用户。我们将在平台上线时通知您。`)
  waitlistEmail.value = ''
}

// 生命周期钩子
onMounted(() => {
  // 初始化价格计算
  calculatePrice()
  
  // 监听滚动，隐藏移动菜单
  window.addEventListener('scroll', closeMobileMenu)
})

onUnmounted(() => {
  window.removeEventListener('scroll', closeMobileMenu)
})
</script>

<style scoped>
/* 基础样式 */
.landing-page {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
  color: #1a1a1a;
  background: linear-gradient(180deg, #f8fafc 0%, #ffffff 100%);
  min-height: 100vh;
}

/* 导航栏 */
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(0, 0, 0, 0.08);
  z-index: 1000;
  padding: 1rem 0;
}

.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1.5rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.logo {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  text-decoration: none;
}

.logo-icon {
  width: 36px;
  height: 36px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 700;
  font-size: 1.25rem;
}

.logo-text {
  font-size: 1.25rem;
  font-weight: 700;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.nav-links {
  display: flex;
  gap: 2rem;
  align-items: center;
}

.nav-link {
  color: #4a5568;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s;
}

.nav-link:hover {
  color: #667eea;
}

.nav-actions {
  display: flex;
  gap: 1rem;
  align-items: center;
}

.btn {
  padding: 0.625rem 1.25rem;
  border-radius: 8px;
  font-weight: 500;
  font-size: 0.875rem;
  cursor: pointer;
  transition: all 0.2s;
  border: none;
  outline: none;
}

.btn-outline {
  background: transparent;
  border: 1px solid #cbd5e0;
  color: #4a5568;
}

.btn-outline:hover {
  border-color: #667eea;
  color: #667eea;
}

.btn-primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.btn-primary:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
}

.btn-large {
  padding: 0.875rem 1.75rem;
  font-size: 1rem;
}

.btn-secondary {
  background: white;
  border: 1px solid #e2e8f0;
  color: #4a5568;
}

.btn-secondary:hover {
  border-color: #cbd5e0;
  background: #f7fafc;
}

.mobile-menu-btn {
  display: none;
  flex-direction: column;
  gap: 4px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0.5rem;
}

.bar {
  width: 24px;
  height: 2px;
  background: #4a5568;
  border-radius: 1px;
}

.mobile-menu {
  display: none;
  padding: 1rem;
  background: white;
  border-top: 1px solid #e2e8f0;
}

.mobile-nav-link {
  display: block;
  padding: 0.75rem 0;
  color: #4a5568;
  text-decoration: none;
  font-weight: 500;
  border-bottom: 1px solid #f1f5f9;
}

.mobile-actions {
  padding: 1rem 0;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

/* 英雄区域 */
.hero-section {
  padding: 8rem 1.5rem 4rem;
  position: relative;
  overflow: hidden;
}

.hero-content {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;
}

.hero-text {
  animation: fadeInUp 0.8s ease-out;
}

.hero-title {
  font-size: 3rem;
  font-weight: 800;
  line-height: 1.2;
  margin-bottom: 1.5rem;
  background: linear-gradient(135deg, #1a202c 0%, #4a5568 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.highlight {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero-subtitle {
  font-size: 1.25rem;
  color: #4a5568;
  line-height: 1.6;
  margin-bottom: 2rem;
}

.hero-actions {
  display: flex;
  gap: 1rem;
  margin-bottom: 3rem;
}

.icon {
  margin-left: 0.5rem;
}

.hero-stats {
  display: flex;
  gap: 2rem;
}

.stat {
  text-align: center;
}

.stat-value {
  font-size: 2rem;
  font-weight: 700;
  color: #667eea;
  margin-bottom: 0.25rem;
}

.stat-label {
  font-size: 0.875rem;
  color: #718096;
  font-weight: 500;
}

/* 手机模拟器 */
.phone-mockup {
  background: white;
  border-radius: 24px;
  padding: 1rem;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  border: 1px solid #e2e8f0;
  animation: float 6s ease-in-out infinite;
}

.phone-screen {
  width: 300px;
  height: 600px;
  background: #f8fafc;
  border-radius: 16px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.app-header {
  padding: 1rem;
  background: white;
  border-bottom: 1px solid #e2e8f0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.walue-badge {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 600;
}

.balance {
  font-size: 0.875rem;
  color: #4a5568;
}

.value {
  font-weight: 600;
  color: #2d3748;
}

.app-content {
  flex: 1;
  overflow-y: auto;
  padding: 1rem;
}

.transaction-card {
  background: white;
  border-radius: 12px;
  padding: 1rem;
  margin-bottom: 0.75rem;
  display: flex;
  align-items: center;
  gap: 1rem;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  transition: transform 0.2s;
}

.transaction-card:hover {
  transform: translateY(-2px);
}

.tx-icon {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.25rem;
}

.tx-icon.ride {
  background: #ebf8ff;
  color: #3182ce;
}

.tx-icon.skill {
  background: #f0fff4;
  color: #38a169;
}

.tx-icon.space {
  background: #faf5ff;
  color: #805ad5;
}

.tx-icon.delivery {
  background: #fff5f5;
  color: #e53e3e;
}

.tx-details {
  flex: 1;
}

.tx-title {
  font-weight: 500;
  color: #2d3748;
}

.tx-time {
  font-size: 0.75rem;
  color: #a0aec0;
}

.tx-amount {
  font-weight: 600;
  color: #e53e3e;
}

.tx-amount.income {
  color: #38a169;
}

.app-nav {
  display: flex;
  background: white;
  border-top: 1px solid #e2e8f0;
  padding: 0.75rem;
}

.nav-item {
  flex: 1;
  text-align: center;
  padding: 0.5rem;
  font-size: 0.75rem;
  color: #a0aec0;
  border-radius: 8px;
  transition: all 0.2s;
}

.nav-item.active {
  background: #f7fafc;
  color: #667eea;
  font-weight: 500;
}

.wave-background {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: -1;
  color: #667eea;
  opacity: 0.1;
}

.wave-background svg {
  width: 100%;
  height: auto;
  display: block;
}

/* 功能区域 */
.features-section {
  padding: 6rem 1.5rem;
  max-width: 1200px;
  margin: 0 auto;
}

.section-header {
  text-align: center;
  margin-bottom: 4rem;
}

.section-title {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
  color: #1a202c;
}

.section-subtitle {
  font-size: 1.125rem;
  color: #718096;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 2rem;
}

.feature-card {
  background: white;
  border-radius: 16px;
  padding: 2rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  border: 1px solid #e2e8f0;
  transition: all 0.3s ease;
}

.feature-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
  border-color: #667eea;
}

.feature-icon {
  font-size: 3rem;
  margin-bottom: 1.5rem;
}

.feature-title {
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 1rem;
  color: #2d3748;
}

.feature-description {
  color: #718096;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.feature-details {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.detail {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #4a5568;
  font-size: 0.875rem;
}

.check {
  color: #48bb78;
  font-weight: bold;
}

/* 如何运作区域 */
.how-it-works-section {
  padding: 6rem 1.5rem;
  background: linear-gradient(180deg, #ffffff 0%, #f7fafc 100%);
}

.pricing-demo {
  max-width: 1000px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  background: white;
  border-radius: 24px;
  padding: 3rem;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.05);
}

.pricing-inputs {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.input-group {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.input-group label {
  font-weight: 600;
  color: #2d3748;
}

.input-group select,
.input-group input[type="range"] {
  padding: 0.75rem;
  border: 1px solid #cbd5e0;
  border-radius: 8px;
  font-size: 1rem;
  background: white;
}

.range-value {
  text-align: center;
  font-weight: 600;
  color: #667eea;
}

.demand-indicator {
  display: flex;
  gap: 0.5rem;
}

.demand-indicator button {
  flex: 1;
  padding: 0.75rem;
  border: 1px solid #cbd5e0;
  background: white;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
}

.demand-indicator button.active {
  background: #667eea;
  color: white;
  border-color: #667eea;
}

.credit-slider {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.credit-labels {
  display: flex;
  justify-content: space-between;
  font-size: 0.875rem;
  color: #718096;
}

.credit-score {
  text-align: center;
  font-weight: 600;
  color: #667eea;
}

.pricing-result {
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.ai-thinking {
  text-align: center;
  padding: 2rem;
  color: #718096;
}

.ai-dots {
  display: flex;
  justify-content: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.dot {
  width: 8px;
  height: 8px;
  background: #667eea;
  border-radius: 50%;
  animation: bounce 1.4s infinite ease-in-out;
}

.dot:nth-child(2) { animation-delay: -0.32s; }
.dot:nth-child(3) { animation-delay: -0.16s; }

.price-breakdown {
  animation: fadeIn 0.5s ease-out;
}

.price-breakdown h3 {
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 1.5rem;
  color: #2d3748;
}

.final-price {
  font-size: 3.5rem;
  font-weight: 800;
  color: #667eea;
  margin-bottom: 2rem;
}

.currency {
  font-size: 2rem;
  color: #a0aec0;
}

.breakdown {
  background: #f7fafc;
  border-radius: 12px;
  padding: 1.5rem;
  margin-bottom: 2rem;
}

.breakdown-item {
  display: flex;
  justify-content: space-between;
  padding: 0.75rem 0;
  border-bottom: 1px solid #e2e8f0;
}

.breakdown-item:last-child {
  border-bottom: none;
}

.breakdown-item.highlight {
  background: white;
  margin: -0.75rem -1.5rem;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-weight: 600;
  color: #667eea;
}

.comparison {
  display: flex;
  gap: 1rem;
}

.comparison-item {
  flex: 1;
  text-align: center;
  padding: 1rem;
  border-radius: 12px;
}

.comparison-item.walue {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.comparison-item.competitor {
  background: #f7fafc;
  border: 1px solid #e2e8f0;
  color: #4a5568;
}

.comparison-label {
  font-size: 0.875rem;
  opacity: 0.9;
  margin-bottom: 0.5rem;
}

.comparison-value {
  font-weight: 600;
  font-size: 1.125rem;
}

/* 生态系统区域 */
.ecosystem-section {
  padding: 6rem 1.5rem;
  max-width: 1200px;
  margin: 0 auto;
}

.ecosystem-visual {
  position: relative;
  height: 600px;
  margin-top: 4rem;
}

.ecosystem-center {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 200px;
  height: 200px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 50%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: white;
  box-shadow: 0 20px 40px rgba(102, 126, 234, 0.3);
  animation: pulse 2s infinite;
}

.center-logo {
  font-size: 4rem;
  font-weight: 700;
}

.center-text {
  font-size: 1.25rem;
  font-weight: 600;
  margin-top: 0.5rem;
}

.ecosystem-node {
  position: absolute;
  width: 140px;
  height: 140px;
  background: white;
  border-radius: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
  border: 2px solid #e2e8f0;
  transition: all 0.3s ease;
  animation: floatNode 6s ease-in-out infinite;
}

.ecosystem-node:hover {
  transform: scale(1.1);
  border-color: #667eea;
  box-shadow: 0 15px 30px rgba(102, 126, 234, 0.2);
}

.ecosystem-node:nth-child(even) {
  animation-delay: 0.5s;
}

.ecosystem-node:nth-child(3n) {
  animation-delay: 1s;
}

.node-icon {
  font-size: 2.5rem;
  margin-bottom: 0.5rem;
}

.node-title {
  font-weight: 600;
  font-size: 0.875rem;
  color: #2d3748;
  margin-bottom: 0.25rem;
}

.node-value {
  font-size: 0.75rem;
  color: #667eea;
  font-weight: 500;
}

/* CTA区域 */
.cta-section {
  padding: 6rem 1.5rem;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  text-align: center;
}

.cta-content {
  max-width: 800px;
  margin: 0 auto;
}

.cta-title {
  font-size: 3rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.cta-subtitle {
  font-size: 1.25rem;
  opacity: 0.9;
  margin-bottom: 3rem;
}

.cta-subtitle .highlight {
  background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: 600;
}

.waitlist-form {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  padding: 2.5rem;
  margin-bottom: 3rem;
}

.form-group {
  display: flex;
  gap: 1rem;
  margin-bottom: 1.5rem;
}

.form-group input {
  flex: 1;
  padding: 1rem 1.5rem;
  border-radius: 12px;
  border: none;
  font-size: 1rem;
  background: rgba(255, 255, 255, 0.9);
}

.form-note {
  font-size: 0.875rem;
  opacity: 0.8;
  margin-bottom: 2rem;
}

.progress-container {
  text-align: left;
}

.progress-label {
  font-size: 0.875rem;
  margin-bottom: 0.5rem;
  opacity: 0.9;
}

.progress-bar {
  height: 8px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 4px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #f6d365 0%, #fda085 100%);
  border-radius: 4px;
  transition: width 0.5s ease;
}

.platform-coming {
  display: flex;
  justify-content: center;
  gap: 3rem;
  flex-wrap: wrap;
}

.platform-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  background: rgba(255, 255, 255, 0.1);
  padding: 1rem 1.5rem;
  border-radius: 12px;
}

.platform-icon {
  font-size: 2rem;
}

.platform-title {
  font-weight: 600;
  font-size: 1.125rem;
}

.platform-date {
  font-size: 0.875rem;
  opacity: 0.8;
}

/* 底部 */
.footer {
  background: #1a202c;
  color: white;
  padding: 4rem 1.5rem 2rem;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 3rem;
  margin-bottom: 3rem;
}

.footer-section {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.footer-logo {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 1rem;
}

.footer-description {
  color: #a0aec0;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.social-links {
  display: flex;
  gap: 1rem;
}

.social-link {
  color: #cbd5e0;
  text-decoration: none;
  font-size: 0.875rem;
}

.social-link:hover {
  color: white;
}

.footer-heading {
  font-size: 1.125rem;
  font-weight: 600;
  margin-bottom: 1rem;
}

.footer-link {
  color: #a0aec0;
  text-decoration: none;
  margin-bottom: 0.75rem;
  font-size: 0.875rem;
}

.footer-link:hover {
  color: white;
}

.footer-bottom {
  max-width: 1200px;
  margin: 0 auto;
  padding-top: 2rem;
  border-top: 1px solid #2d3748;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 1rem;
}

.copyright {
  color: #a0aec0;
  font-size: 0.875rem;
}

/* 模态框 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(10px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2000;
}

.modal-content {
  background: white;
  border-radius: 24px;
  width: 90%;
  max-width: 800px;
  position: relative;
  overflow: hidden;
}

.modal-close {
  position: absolute;
  top: 1rem;
  right: 1rem;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.5);
  color: white;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  z-index: 10;
}

.video-container {
  aspect-ratio: 16/9;
  background: #1a202c;
  display: flex;
  align-items: center;
  justify-content: center;
}

.video-placeholder {
  text-align: center;
  color: white;
}

.play-icon {
  font-size: 4rem;
  margin-bottom: 1rem;
  opacity: 0.7;
}

/* 动画 */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-10px);
  }
}

@keyframes bounce {
  0%, 80%, 100% {
    transform: scale(0);
  }
  40% {
    transform: scale(1);
  }
}

@keyframes pulse {
  0%, 100% {
    transform: translate(-50%, -50%) scale(1);
  }
  50% {
    transform: translate(-50%, -50%) scale(1.05);
  }
}

@keyframes floatNode {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-15px);
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .hero-content {
    grid-template-columns: 1fr;
    gap: 3rem;
    text-align: center;
  }
  
  .hero-actions {
    justify-content: center;
  }
  
  .hero-stats {
    justify-content: center;
  }
  
  .phone-mockup {
    margin: 0 auto;
  }
  
  .pricing-demo {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .ecosystem-visual {
    height: 500px;
  }
  
  .ecosystem-node {
    width: 120px;
    height: 120px;
  }
}

@media (max-width: 768px) {
  .nav-links, .nav-actions {
    display: none;
  }
  
  .mobile-menu-btn {
    display: flex;
  }
  
  .mobile-menu {
    display: block;
  }
  
  .hero-title {
    font-size: 2.25rem;
  }
  
  .hero-subtitle {
    font-size: 1.125rem;
  }
  
  .section-title {
    font-size: 2rem;
  }
  
  .cta-title {
    font-size: 2.25rem;
  }
  
  .form-group {
    flex-direction: column;
  }
  
  .platform-coming {
    flex-direction: column;
    gap: 1rem;
  }
  
  .footer-content {
    grid-template-columns: 1fr;
  }
  
  .footer-bottom {
    flex-direction: column;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .hero-section {
    padding: 6rem 1rem 3rem;
  }
  
  .features-section,
  .how-it-works-section,
  .ecosystem-section,
  .cta-section {
    padding: 4rem 1rem;
  }
  
  .pricing-demo {
    padding: 2rem 1.5rem;
  }
  
  .ecosystem-visual {
    height: 400px;
  }
  
  .ecosystem-node {
    width: 100px;
    height: 100px;
  }
  
  .node-icon {
    font-size: 1.75rem;
  }
  
  .node-title {
    font-size: 0.75rem;
  }
  
  .node-value {
    font-size: 0.625rem;
  }
}
</style>