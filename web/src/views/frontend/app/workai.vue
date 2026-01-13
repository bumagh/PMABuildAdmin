<template>
  <div class="landing-page">
    <!-- 导航栏 -->
    <header class="header">
      <div class="container">
        <div class="logo">
          <span class="logo-icon">🤖</span>
          <h1>AI营销<span class="logo-highlight">Pro</span></h1>
        </div>
        <nav class="nav">
          <a href="#features" class="nav-link">功能特色</a>
          <a href="#pricing" class="nav-link">订阅服务</a>
          <a href="#agent" class="nav-link">城市代理</a>
          <a href="#contact" class="nav-link">联系我们</a>
        </nav>
        <div class="auth-buttons">
          <button class="btn btn-login" @click="openLogin">登录</button>
          <button class="btn btn-primary" @click="openSignup">免费试用</button>
        </div>
        <button class="mobile-menu-btn" @click="toggleMobileMenu">
          <span v-if="!mobileMenuOpen">☰</span>
          <span v-else>×</span>
        </button>
      </div>
      
      <!-- 移动端菜单 -->
      <div v-if="mobileMenuOpen" class="mobile-menu">
        <a href="#features" class="mobile-nav-link" @click="toggleMobileMenu">功能特色</a>
        <a href="#pricing" class="mobile-nav-link" @click="toggleMobileMenu">订阅服务</a>
        <a href="#agent" class="mobile-nav-link" @click="toggleMobileMenu">城市代理</a>
        <a href="#contact" class="mobile-nav-link" @click="toggleMobileMenu">联系我们</a>
        <div class="mobile-auth">
          <button class="btn btn-login" @click="openLogin">登录</button>
          <button class="btn btn-primary" @click="openSignup">免费试用</button>
        </div>
      </div>
    </header>

    <!-- 英雄区域 -->
    <section class="hero">
      <div class="container">
        <div class="hero-content">
          <h2 class="hero-title">
            让AI为您的业务<span class="text-gradient">自动获客</span>
          </h2>
          <p class="hero-subtitle">
            智能识别高意向客户，自动化营销流程，精准触达，提升转化率300%+
          </p>
          <div class="hero-buttons">
            <button class="btn btn-primary btn-large" @click="openSignup">
              🚀 立即免费试用
            </button>
            <button class="btn btn-secondary btn-large" @click="openVideoDemo">
              ▶️ 观看演示视频
            </button>
          </div>
          <div class="hero-stats">
            <div class="stat-item">
              <div class="stat-number">5,000+</div>
              <div class="stat-label">企业客户</div>
            </div>
            <div class="stat-item">
              <div class="stat-number">92%</div>
              <div class="stat-label">客户满意度</div>
            </div>
            <div class="stat-item">
              <div class="stat-number">300%</div>
              <div class="stat-label">获客效率提升</div>
            </div>
          </div>
        </div>
        <div class="hero-image">
          <div class="dashboard-preview">
            <div class="dashboard-header">
              <div class="dashboard-dot red"></div>
              <div class="dashboard-dot yellow"></div>
              <div class="dashboard-dot green"></div>
            </div>
            <div class="dashboard-content">
              <div class="ai-widget">
                <div class="ai-icon">🤖</div>
                <div class="ai-text">AI正在分析客户行为...</div>
              </div>
              <div class="chart-container">
                <div class="chart-bar" style="height: 80%"></div>
                <div class="chart-bar" style="height: 60%"></div>
                <div class="chart-bar" style="height: 90%"></div>
                <div class="chart-bar" style="height: 70%"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 功能特色 -->
    <section id="features" class="features">
      <div class="container">
        <h2 class="section-title">核心功能</h2>
        <p class="section-subtitle">专为增长设计的AI营销工具</p>
        
        <div class="features-grid">
          <div class="feature-card">
            <div class="feature-icon">🎯</div>
            <h3>智能客户发现</h3>
            <p>AI算法自动识别高意向客户，精准定位目标人群</p>
          </div>
          
          <div class="feature-card">
            <div class="feature-icon">🤖</div>
            <h3>自动化营销</h3>
            <p>可视化流程设计，7×24小时自动获客与培育</p>
          </div>
          
          <div class="feature-card">
            <div class="feature-icon">📊</div>
            <h3>数据分析</h3>
            <p>实时数据看板，多维度分析营销效果</p>
          </div>
          
          <div class="feature-card">
            <div class="feature-icon">🔗</div>
            <h3>多渠道集成</h3>
            <p>微信、抖音、网站等多渠道统一管理</p>
          </div>
        </div>
      </div>
    </section>

    <!-- 订阅服务 -->
    <section id="pricing" class="pricing">
      <div class="container">
        <h2 class="section-title">订阅服务</h2>
        <p class="section-subtitle">选择适合您的方案，支持按需升级</p>
        
        <div class="pricing-tabs">
          <button 
            class="pricing-tab" 
            :class="{ active: billingCycle === 'monthly' }"
            @click="billingCycle = 'monthly'"
          >
            月付
          </button>
          <button 
            class="pricing-tab" 
            :class="{ active: billingCycle === 'yearly' }"
            @click="billingCycle = 'yearly'"
          >
            年付<span class="discount-badge">节省20%</span>
          </button>
        </div>
        
        <div class="pricing-grid">
          <div 
            v-for="plan in subscriptionPlans" 
            :key="plan.id"
            class="pricing-card"
            :class="{ popular: plan.popular }"
          >
            <div v-if="plan.popular" class="popular-badge">最受欢迎</div>
            
            <div class="plan-header">
              <h3>{{ plan.name }}</h3>
              <div class="plan-price">
                <span class="currency">¥</span>
                <span class="amount">{{ getPlanPrice(plan) }}</span>
                <span class="period">/{{ billingCycle === 'monthly' ? '月' : '年' }}</span>
              </div>
              <p class="plan-description">{{ plan.description }}</p>
            </div>
            
            <div class="plan-features">
              <div 
                v-for="feature in plan.features" 
                :key="feature"
                class="feature-item"
              >
                ✓ {{ feature }}
              </div>
            </div>
            
            <button 
              class="btn"
              :class="plan.popular ? 'btn-primary' : 'btn-secondary'"
              @click="subscribe(plan)"
            >
              {{ plan.cta }}
            </button>
          </div>
        </div>
        
        <div class="custom-plan">
          <h3>需要定制方案？</h3>
          <p>联系我们获取企业级定制服务，包括私有化部署、定制开发等</p>
          <button class="btn btn-outline" @click="openContactModal">联系销售</button>
        </div>
      </div>
    </section>

    <!-- 城市代理人 -->
    <section id="agent" class="agent-section">
      <div class="container">
        <div class="agent-content">
          <div class="agent-text">
            <h2 class="section-title">成为城市合伙人</h2>
            <p class="section-subtitle">与我们一起开拓市场，共享增长红利</p>
            
            <div class="agent-benefits">
              <div class="benefit-item">
                <div class="benefit-icon">💰</div>
                <div>
                  <h4>高额佣金</h4>
                  <p>最高可达销售额的40%</p>
                </div>
              </div>
              
              <div class="benefit-item">
                <div class="benefit-icon">🏆</div>
                <div>
                  <h4>独家区域保护</h4>
                  <p>每个城市仅限1-2名合伙人</p>
                </div>
              </div>
              
              <div class="benefit-item">
                <div class="benefit-icon">🎓</div>
                <div>
                  <h4>专业培训</h4>
                  <p>提供完整的产品培训与营销支持</p>
                </div>
              </div>
              
              <div class="benefit-item">
                <div class="benefit-icon">📈</div>
                <div>
                  <h4>持续收入</h4>
                  <p>客户续费可获得持续佣金</p>
                </div>
              </div>
            </div>
          </div>
          
          <div class="agent-form-container">
            <div class="agent-form">
              <h3>申请成为城市合伙人</h3>
              <form @submit.prevent="submitAgentApplication">
                <div class="form-group">
                  <input 
                    v-model="agentForm.name"
                    type="text" 
                    placeholder="您的姓名" 
                    required
                  />
                </div>
                
                <div class="form-group">
                  <input 
                    v-model="agentForm.phone"
                    type="tel" 
                    placeholder="手机号码" 
                    required
                  />
                </div>
                
                <div class="form-group">
                  <input 
                    v-model="agentForm.city"
                    type="text" 
                    placeholder="意向城市" 
                    required
                  />
                </div>
                
                <div class="form-group">
                  <input 
                    v-model="agentForm.company"
                    type="text" 
                    placeholder="公司名称（如有）" 
                  />
                </div>
                
                <div class="form-group">
                  <textarea 
                    v-model="agentForm.experience"
                    placeholder="请简要描述您的相关经验..."
                    rows="3"
                  ></textarea>
                </div>
                
                <button 
                  type="submit" 
                  class="btn btn-primary btn-block"
                  :disabled="isSubmitting"
                >
                  {{ isSubmitting ? '提交中...' : '立即申请' }}
                </button>
                
                <p class="form-note">
                  提交申请后，我们将在24小时内与您联系
                </p>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 页脚 -->
    <footer id="contact" class="footer">
      <div class="container">
        <div class="footer-content">
          <div class="footer-section">
            <div class="logo">
              <span class="logo-icon">🤖</span>
              <h2>AI营销<span class="logo-highlight">Pro</span></h2>
            </div>
            <p>让AI驱动您的业务增长</p>
            <div class="social-links">
              <a href="#" class="social-link">微信</a>
              <a href="#" class="social-link">抖音</a>
              <a href="#" class="social-link">知乎</a>
              <a href="#" class="social-link">CSDN</a>
            </div>
          </div>
          
          <div class="footer-section">
            <h4>产品</h4>
            <a href="#" class="footer-link">功能特色</a>
            <a href="#" class="footer-link">订阅服务</a>
            <a href="#" class="footer-link">更新日志</a>
            <a href="#" class="footer-link">API文档</a>
          </div>
          
          <div class="footer-section">
            <h4>支持</h4>
            <a href="#" class="footer-link">帮助中心</a>
            <a href="#" class="footer-link">在线客服</a>
            <a href="#" class="footer-link">视频教程</a>
            <a href="#" class="footer-link">常见问题</a>
          </div>
          
          <div class="footer-section">
            <h4>联系我们</h4>
            <p>📧 contact@aimarketing.com</p>
            <p>📞 400-123-4567</p>
            <p>📍 北京市朝阳区科技园A座</p>
          </div>
        </div>
        
        <div class="footer-bottom">
          <p>© 2024 AI营销Pro. 保留所有权利.</p>
          <div class="footer-links">
            <a href="#" class="footer-link">隐私政策</a>
            <a href="#" class="footer-link">服务条款</a>
          </div>
        </div>
      </div>
    </footer>

    <!-- 模态框 -->
    <div v-if="showModal" class="modal-overlay" @click="closeModal">
      <div class="modal-content" @click.stop>
        <button class="modal-close" @click="closeModal">×</button>
        <div v-if="modalType === 'signup'">
          <h3>开始免费试用</h3>
          <!-- 注册表单 -->
        </div>
        <div v-else-if="modalType === 'login'">
          <h3>登录账户</h3>
          <!-- 登录表单 -->
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted } from 'vue'

// 响应式状态
const mobileMenuOpen = ref(false)
const billingCycle = ref<'monthly' | 'yearly'>('monthly')
const showModal = ref(false)
const modalType = ref<'signup' | 'login' | 'contact' | null>(null)
const isSubmitting = ref(false)

// 订阅计划数据
const subscriptionPlans = ref([
  {
    id: 1,
    name: '基础版',
    description: '适合初创团队和个人',
    monthlyPrice: 299,
    yearlyPrice: 2870, // 299 * 12 * 0.8
    features: [
      '最多1000个客户',
      '基础AI客户分析',
      '邮件营销自动化',
      '基础数据看板',
      '微信客服集成',
      '5个自动化流程'
    ],
    cta: '开始免费试用',
    popular: false
  },
  {
    id: 2,
    name: '专业版',
    description: '适合中小企业',
    monthlyPrice: 899,
    yearlyPrice: 8630, // 899 * 12 * 0.8
    features: [
      '最多10000个客户',
      '高级AI客户分析',
      '全渠道自动化',
      '高级数据看板',
      '多团队协作',
      '无限自动化流程',
      'A/B测试功能',
      '专属客户成功经理'
    ],
    cta: '选择专业版',
    popular: true
  },
  {
    id: 3,
    name: '企业版',
    description: '适合大型企业',
    monthlyPrice: 2999,
    yearlyPrice: 28790, // 2999 * 12 * 0.8
    features: [
      '无限客户数量',
      '定制AI模型',
      '私有化部署',
      '专属技术支持',
      '定制开发接口',
      'SLA服务保障',
      '安全审计报告',
      '现场培训支持'
    ],
    cta: '联系销售',
    popular: false
  }
])

// 代理人申请表单
const agentForm = reactive({
  name: '',
  phone: '',
  city: '',
  company: '',
  experience: ''
})

// 计算属性
const getPlanPrice = (plan: any) => {
  return billingCycle.value === 'monthly' 
    ? plan.monthlyPrice 
    : plan.yearlyPrice
}

// 方法
const toggleMobileMenu = () => {
  mobileMenuOpen.value = !mobileMenuOpen.value
}

const openSignup = () => {
  modalType.value = 'signup'
  showModal.value = true
  mobileMenuOpen.value = false
}

const openLogin = () => {
  modalType.value = 'login'
  showModal.value = true
  mobileMenuOpen.value = false
}

const openContactModal = () => {
  modalType.value = 'contact'
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
  modalType.value = null
}

const openVideoDemo = () => {
  // 在实际应用中，这里可以打开视频模态框
  window.open('https://example.com/demo-video', '_blank')
}

const subscribe = (plan: any) => {
  if (plan.id === 3) {
    openContactModal()
  } else {
    openSignup()
    // 在实际应用中，这里可以记录选择的计划
    console.log(`选择订阅: ${plan.name}`)
  }
}

const submitAgentApplication = async () => {
  if (!agentForm.name || !agentForm.phone || !agentForm.city) {
    alert('请填写必填字段')
    return
  }
  
  isSubmitting.value = true
  
  try {
    // 模拟API调用
    await new Promise(resolve => setTimeout(resolve, 1500))
    
    alert('申请提交成功！我们将在24小时内与您联系。')
    
    // 重置表单
    Object.assign(agentForm, {
      name: '',
      phone: '',
      city: '',
      company: '',
      experience: ''
    })
    
  } catch (error) {
    alert('提交失败，请稍后重试')
  } finally {
    isSubmitting.value = false
  }
}

// 生命周期钩子
onMounted(() => {
  // 平滑滚动
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault()
      const targetId = this.getAttribute('href')
      if (targetId === '#') return
      
      const targetElement = document.querySelector(targetId)
      if (targetElement) {
        window.scrollTo({
          top: targetElement.offsetTop - 80,
          behavior: 'smooth'
        })
      }
    })
  })
})
</script>

<style scoped>
/* 基础样式 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

:root {
  --primary-color: #6366f1;
  --primary-dark: #4f46e5;
  --secondary-color: #10b981;
  --text-color: #1f2937;
  --text-light: #6b7280;
  --bg-color: #ffffff;
  --bg-light: #f9fafb;
  --border-color: #e5e7eb;
  --shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
  --radius: 12px;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  color: var(--text-color);
  line-height: 1.6;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

/* 按钮样式 */
.btn {
  padding: 12px 24px;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  border: none;
  font-size: 16px;
}

.btn-primary {
  background: var(--primary-color);
  color: white;
}

.btn-primary:hover {
  background: var(--primary-dark);
  transform: translateY(-2px);
}

.btn-secondary {
  background: white;
  color: var(--primary-color);
  border: 2px solid var(--primary-color);
}

.btn-secondary:hover {
  background: var(--bg-light);
}

.btn-login {
  background: transparent;
  color: var(--text-color);
  margin-right: 12px;
}

.btn-login:hover {
  color: var(--primary-color);
}

.btn-large {
  padding: 16px 32px;
  font-size: 18px;
}

.btn-block {
  width: 100%;
}

.btn-outline {
  background: transparent;
  border: 2px solid var(--primary-color);
  color: var(--primary-color);
}

.btn-outline:hover {
  background: var(--primary-color);
  color: white;
}

/* 头部样式 */
.header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  z-index: 1000;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  padding: 16px 0;
}

.header .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  display: flex;
  align-items: center;
  gap: 8px;
}

.logo h1 {
  font-size: 24px;
  font-weight: 700;
}

.logo-icon {
  font-size: 28px;
}

.logo-highlight {
  color: var(--primary-color);
}

.nav {
  display: flex;
  gap: 32px;
}

.nav-link {
  color: var(--text-color);
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s;
}

.nav-link:hover {
  color: var(--primary-color);
}

.mobile-menu-btn {
  display: none;
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
}

.mobile-menu {
  display: none;
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  padding: 20px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.mobile-nav-link {
  display: block;
  padding: 12px 0;
  color: var(--text-color);
  text-decoration: none;
  border-bottom: 1px solid var(--border-color);
}

.mobile-auth {
  margin-top: 20px;
  display: flex;
  gap: 12px;
}

/* 英雄区域 */
.hero {
  padding: 160px 0 80px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  overflow: hidden;
}

.hero .container {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
  align-items: center;
}

.hero-title {
  font-size: 48px;
  line-height: 1.2;
  margin-bottom: 24px;
}

.text-gradient {
  background: linear-gradient(45deg, #ff6b6b, #feca57);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero-subtitle {
  font-size: 20px;
  margin-bottom: 32px;
  opacity: 0.9;
}

.hero-buttons {
  display: flex;
  gap: 16px;
  margin-bottom: 48px;
}

.hero-stats {
  display: flex;
  gap: 48px;
}

.stat-item {
  text-align: center;
}

.stat-number {
  font-size: 32px;
  font-weight: 700;
  margin-bottom: 4px;
}

.stat-label {
  opacity: 0.8;
}

/* 仪表板预览 */
.dashboard-preview {
  background: white;
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  overflow: hidden;
}

.dashboard-header {
  background: var(--bg-light);
  padding: 12px 20px;
  display: flex;
  gap: 8px;
}

.dashboard-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
}

.dashboard-dot.red { background: #ff5f57; }
.dashboard-dot.yellow { background: #ffbd2e; }
.dashboard-dot.green { background: #28ca42; }

.dashboard-content {
  padding: 30px;
  min-height: 300px;
}

.ai-widget {
  background: var(--bg-light);
  border-radius: 8px;
  padding: 16px;
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 30px;
}

.ai-icon {
  font-size: 24px;
}

.chart-container {
  display: flex;
  align-items: flex-end;
  gap: 20px;
  height: 200px;
  padding: 20px;
  background: var(--bg-light);
  border-radius: 8px;
}

.chart-bar {
  flex: 1;
  background: linear-gradient(to top, var(--primary-color), #8b5cf6);
  border-radius: 4px;
  min-height: 40px;
}

/* 功能特色 */
.features {
  padding: 100px 0;
  background: var(--bg-light);
}

.section-title {
  text-align: center;
  font-size: 36px;
  margin-bottom: 16px;
}

.section-subtitle {
  text-align: center;
  color: var(--text-light);
  margin-bottom: 60px;
  font-size: 18px;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
}

.feature-card {
  background: white;
  padding: 40px 30px;
  border-radius: var(--radius);
  text-align: center;
  box-shadow: var(--shadow);
  transition: transform 0.3s ease;
}

.feature-card:hover {
  transform: translateY(-5px);
}

.feature-icon {
  font-size: 48px;
  margin-bottom: 24px;
}

.feature-card h3 {
  margin-bottom: 16px;
  font-size: 20px;
}

/* 定价区域 */
.pricing {
  padding: 100px 0;
}

.pricing-tabs {
  display: flex;
  justify-content: center;
  gap: 16px;
  margin-bottom: 40px;
}

.pricing-tab {
  padding: 12px 32px;
  border: 2px solid var(--border-color);
  border-radius: 8px;
  background: white;
  cursor: pointer;
  transition: all 0.3s;
  font-weight: 600;
}

.pricing-tab.active {
  border-color: var(--primary-color);
  background: var(--primary-color);
  color: white;
}

.discount-badge {
  background: var(--secondary-color);
  color: white;
  padding: 2px 8px;
  border-radius: 12px;
  font-size: 12px;
  margin-left: 8px;
}

.pricing-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  margin-bottom: 60px;
}

.pricing-card {
  background: white;
  border-radius: var(--radius);
  padding: 40px 30px;
  position: relative;
  box-shadow: var(--shadow);
  display: flex;
  flex-direction: column;
}

.pricing-card.popular {
  border: 2px solid var(--primary-color);
  transform: scale(1.05);
}

.popular-badge {
  position: absolute;
  top: -12px;
  left: 50%;
  transform: translateX(-50%);
  background: var(--primary-color);
  color: white;
  padding: 6px 20px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 600;
}

.plan-header {
  text-align: center;
  margin-bottom: 30px;
}

.plan-header h3 {
  font-size: 24px;
  margin-bottom: 16px;
}

.plan-price {
  margin-bottom: 16px;
}

.currency {
  font-size: 24px;
  vertical-align: top;
}

.amount {
  font-size: 48px;
  font-weight: 700;
  margin: 0 4px;
}

.period {
  color: var(--text-light);
  font-size: 16px;
}

.plan-description {
  color: var(--text-light);
}

.plan-features {
  flex: 1;
  margin-bottom: 30px;
}

.feature-item {
  padding: 12px 0;
  border-bottom: 1px solid var(--border-color);
}

.feature-item:last-child {
  border-bottom: none;
}

.custom-plan {
  text-align: center;
  padding: 40px;
  background: var(--bg-light);
  border-radius: var(--radius);
}

.custom-plan h3 {
  margin-bottom: 16px;
  font-size: 24px;
}

.custom-plan p {
  margin-bottom: 24px;
  color: var(--text-light);
}

/* 城市代理人区域 */
.agent-section {
  padding: 100px 0;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.agent-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
  align-items: center;
}

.agent-benefits {
  margin-top: 40px;
}

.benefit-item {
  display: flex;
  gap: 16px;
  margin-bottom: 24px;
  align-items: flex-start;
}

.benefit-icon {
  font-size: 32px;
  flex-shrink: 0;
}

.benefit-item h4 {
  margin-bottom: 8px;
}

.agent-form-container {
  background: white;
  border-radius: var(--radius);
  padding: 40px;
  color: var(--text-color);
}

.agent-form h3 {
  margin-bottom: 24px;
  font-size: 24px;
  text-align: center;
}

.form-group {
  margin-bottom: 20px;
}

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 14px 16px;
  border: 2px solid var(--border-color);
  border-radius: 8px;
  font-size: 16px;
  transition: border-color 0.3s;
}

.form-group input:focus,
.form-group textarea:focus {
  outline: none;
  border-color: var(--primary-color);
}

.form-note {
  text-align: center;
  margin-top: 16px;
  color: var(--text-light);
  font-size: 14px;
}

/* 页脚 */
.footer {
  background: var(--text-color);
  color: white;
  padding: 80px 0 30px;
}

.footer-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 40px;
  margin-bottom: 60px;
}

.footer-section h4 {
  margin-bottom: 20px;
  font-size: 18px;
}

.footer-link {
  display: block;
  color: #9ca3af;
  text-decoration: none;
  margin-bottom: 12px;
  transition: color 0.3s;
}

.footer-link:hover {
  color: white;
}

.social-links {
  display: flex;
  gap: 16px;
  margin-top: 20px;
}

.social-link {
  color: #9ca3af;
  text-decoration: none;
  transition: color 0.3s;
}

.social-link:hover {
  color: white;
}

.footer-bottom {
  padding-top: 30px;
  border-top: 1px solid #374151;
  display: flex;
  justify-content: space-between;
  align-items: center;
  color: #9ca3af;
}

.footer-links {
  display: flex;
  gap: 24px;
}

/* 模态框 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2000;
}

.modal-content {
  background: white;
  border-radius: var(--radius);
  padding: 40px;
  max-width: 500px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
  position: relative;
}

.modal-close {
  position: absolute;
  top: 20px;
  right: 20px;
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: var(--text-light);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .nav,
  .auth-buttons {
    display: none;
  }
  
  .mobile-menu-btn {
    display: block;
  }
  
  .mobile-menu {
    display: block;
  }
  
  .hero .container {
    grid-template-columns: 1fr;
    text-align: center;
  }
  
  .hero-title {
    font-size: 36px;
  }
  
  .hero-buttons {
    flex-direction: column;
  }
  
  .hero-stats {
    justify-content: center;
  }
  
  .agent-content {
    grid-template-columns: 1fr;
  }
  
  .pricing-card.popular {
    transform: none;
  }
  
  .footer-bottom {
    flex-direction: column;
    gap: 16px;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .hero-title {
    font-size: 28px;
  }
  
  .section-title {
    font-size: 28px;
  }
  
  .features-grid,
  .pricing-grid {
    grid-template-columns: 1fr;
  }
}
</style>