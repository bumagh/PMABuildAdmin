<template>
  <!-- 页面容器 -->
  <div class="landing-page">
    <!-- 导航栏 -->
    <header class="header">
      <div class="container">
        <div class="logo">
          <span class="logo-icon">⚡</span>
          <span class="logo-text">骑手闪仓</span>
        </div>
        <nav class="nav">
          <a href="#benefits" class="nav-link">收益优势</a>
          <a href="#process" class="nav-link">加入流程</a>
          <a href="#faq" class="nav-link">常见问题</a>
        </nav>
        <div class="cta-nav">
          <button class="btn btn-outline" @click="scrollToRegister">立即加入</button>
        </div>
      </div>
    </header>

    <!-- 英雄区域 -->
    <section class="hero">
      <div class="container">
        <div class="hero-content">
          <h1 class="hero-title">
            你的后备箱，就是<span class="highlight">赚钱仓</span>
          </h1>
          <p class="hero-subtitle">
            利用送餐间隙与闲置空间，0门槛开启移动零售副业<br>
            <span class="hero-highlight">1元启动，当日即可产生收益</span>
          </p>
          
          <div class="hero-stats">
            <div class="stat">
              <span class="stat-number">500+</span>
              <span class="stat-label">赣州骑手已加入</span>
            </div>
            <div class="stat">
              <span class="stat-number">¥300-1500</span>
              <span class="stat-label">月均额外收入</span>
            </div>
            <div class="stat">
              <span class="stat-number">1元</span>
              <span class="stat-label">启动成本</span>
            </div>
          </div>
          
          <div class="hero-actions">
            <button class="btn btn-primary btn-lg" @click="scrollToRegister">
              <span class="btn-icon">🚀</span>
              1元立即开启闪仓
            </button>
            <button class="btn btn-outline btn-lg" @click="openVideoModal">
              <span class="btn-icon">▶️</span>
              观看介绍视频
            </button>
          </div>
          
          <div class="hero-features">
            <div class="feature">
              <span class="feature-icon">✅</span>
              <span>完全合规，不影响外卖工作</span>
            </div>
            <div class="feature">
              <span class="feature-icon">✅</span>
              <span>平台供货，无压货风险</span>
            </div>
            <div class="feature">
              <span class="feature-icon">✅</span>
              <span>系统自动匹配订单</span>
            </div>
          </div>
        </div>
        
        <div class="hero-visual">
          <div class="mockup-container">
            <div class="mockup-phone">
              <div class="phone-screen">
                <div class="app-screen">
                  <div class="app-header">
                    <span class="app-title">骑手闪仓</span>
                    <span class="app-balance">余额: ¥128.5</span>
                  </div>
                  <div class="app-content">
                    <div class="order-card" v-for="order in demoOrders" :key="order.id">
                      <div class="order-info">
                        <span class="order-product">{{ order.product }}</span>
                        <span class="order-location">距离 {{ order.distance }}</span>
                      </div>
                      <div class="order-earning">+{{ order.earning }}</div>
                    </div>
                  </div>
                  <div class="app-footer">
                    <div class="today-earning">
                      今日收入: <span class="earning-amount">¥{{ todayEarning }}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="visual-badge">
              <span class="badge-text">🔥 今日推荐爆品</span>
              <span class="badge-product">红牛维生素饮料</span>
              <span class="badge-profit">单瓶利润 ¥2.5</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 收益优势 -->
    <section id="benefits" class="benefits">
      <div class="container">
        <h2 class="section-title">为什么选择骑手闪仓？</h2>
        <p class="section-subtitle">为骑手量身打造的移动零售解决方案</p>
        
        <div class="benefits-grid">
          <div class="benefit-card">
            <div class="benefit-icon">💰</div>
            <h3 class="benefit-title">极低启动门槛</h3>
            <p class="benefit-desc">仅需1元认证费，即可获得价值298元的启动包（含展示盒、物料、首批试销商品）</p>
          </div>
          
          <div class="benefit-card">
            <div class="benefit-icon">⚡</div>
            <h3 class="benefit-title">无缝衔接工作</h3>
            <p class="benefit-desc">智能系统仅在骑手休息/等单时推送零售订单，绝不干扰外卖配送</p>
          </div>
          
          <div class="benefit-card">
            <div class="benefit-icon">📦</div>
            <h3 class="benefit-title">零库存风险</h3>
            <p class="benefit-desc">平台统一供货，卖不掉可退回，骑手无需承担压货损失</p>
          </div>
          
          <div class="benefit-card">
            <div class="benefit-icon">🛡️</div>
            <h3 class="benefit-title">100%合规保障</h3>
            <p class="benefit-desc">与外卖平台规则0冲突，技术隔离配送与零售时段，完全合法合规</p>
          </div>
          
          <div class="benefit-card">
            <div class="benefit-icon">🚀</div>
            <h3 class="benefit-title">智能爆款推荐</h3>
            <p class="benefit-desc">大数据分析区域热销商品，智能推荐高利润爆品，提升动销率</p>
          </div>
          
          <div class="benefit-card">
            <div class="benefit-icon">👥</div>
            <h3 class="benefit-title">骑手专属社群</h3>
            <p class="benefit-desc">加入本地骑手交流群，分享经验，获取独家供货渠道与促销活动</p>
          </div>
        </div>
      </div>
    </section>

    <!-- 加入流程 -->
    <section id="process" class="process">
      <div class="container">
        <h2 class="section-title">仅4步，开启你的闪仓副业</h2>
        <p class="section-subtitle">从注册到产生收益，最快仅需30分钟</p>
        
        <div class="process-steps">
          <div class="step">
            <div class="step-number">1</div>
            <h3 class="step-title">1元注册认证</h3>
            <p class="step-desc">支付1元完成实名认证，获取骑手资质审核</p>
          </div>
          
          <div class="step-arrow">➡️</div>
          
          <div class="step">
            <div class="step-number">2</div>
            <h3 class="step-title">领取启动包</h3>
            <p class="step-desc">前往就近配送点领取启动物料包</p>
          </div>
          
          <div class="step-arrow">➡️</div>
          
          <div class="step">
            <div class="step-number">3</div>
            <h3 class="step-title">上架商品</h3>
            <p class="step-desc">通过APP选择爆款商品，设置价格与库存</p>
          </div>
          
          <div class="step-arrow">➡️</div>
          
          <div class="step">
            <div class="step-number">4</div>
            <h3 class="step-title">开始赚钱</h3>
            <p class="step-desc">系统智能推送订单，休息时送货，立即获得收益</p>
          </div>
        </div>
        
        <div class="process-visual">
          <div class="timeline">
            <div class="timeline-marker" style="left: 0%">
              <div class="marker-dot"></div>
              <div class="marker-label">注册</div>
            </div>
            <div class="timeline-marker" style="left: 33%">
              <div class="marker-dot"></div>
              <div class="marker-label">准备</div>
            </div>
            <div class="timeline-marker" style="left: 66%">
              <div class="marker-dot"></div>
              <div class="marker-label">上架</div>
            </div>
            <div class="timeline-marker" style="left: 100%">
              <div class="marker-dot"></div>
              <div class="marker-label">收益</div>
            </div>
            <div class="timeline-progress" :style="{ width: timelineProgress + '%' }"></div>
          </div>
        </div>
      </div>
    </section>

    <!-- 注册表单 -->
    <section id="register" class="register">
      <div class="container">
        <div class="register-card">
          <div class="register-header">
            <h2 class="register-title">立即加入骑手闪仓</h2>
            <p class="register-subtitle">仅需1元，开启你的移动零售副业</p>
          </div>
          
          <form class="register-form" @submit.prevent="handleSubmit">
            <div class="form-group">
              <label for="name" class="form-label">姓名</label>
              <input
                type="text"
                id="name"
                v-model="form.name"
                placeholder="请输入真实姓名"
                required
                class="form-input"
              />
            </div>
            
            <div class="form-group">
              <label for="phone" class="form-label">手机号</label>
              <input
                type="tel"
                id="phone"
                v-model="form.phone"
                placeholder="请输入手机号"
                required
                class="form-input"
              />
            </div>
            
            <div class="form-group">
              <label for="platform" class="form-label">主要工作平台</label>
              <select id="platform" v-model="form.platform" class="form-input">
                <option value="">请选择主要工作平台</option>
                <option value="meituan">美团外卖</option>
                <option value="eleme">饿了么</option>
                <option value="other">其他/众包</option>
              </select>
            </div>
            
            <div class="form-group">
              <label for="area" class="form-label">主要工作区域</label>
              <select id="area" v-model="form.area" class="form-input">
                <option value="">请选择主要工作区域</option>
                <option value="zhangjiang">章江新区</option>
                <option value="wenqing">文清路周边</option>
                <option value="gaoxin">高新区</option>
                <option value="economic">经济技术开发区</option>
                <option value="other">其他区域</option>
              </select>
            </div>
            
            <div class="form-group">
              <label class="form-label">期望月额外收入</label>
              <div class="income-range">
                <div 
                  v-for="range in incomeRanges" 
                  :key="range.value"
                  :class="['income-option', { active: form.expectedIncome === range.value }]"
                  @click="form.expectedIncome = range.value"
                >
                  {{ range.label }}
                </div>
              </div>
            </div>
            
            <div class="form-group terms">
              <input
                type="checkbox"
                id="terms"
                v-model="form.agreeTerms"
                required
                class="terms-checkbox"
              />
              <label for="terms" class="terms-label">
                我已阅读并同意
                <a href="#" @click.prevent="openTermsModal">《骑手闪仓服务协议》</a>
                及
                <a href="#" @click.prevent="openPrivacyModal">《隐私政策》</a>
              </label>
            </div>
            
            <button 
              type="submit" 
              class="btn btn-primary btn-block btn-lg"
              :disabled="submitting"
            >
              <span v-if="submitting" class="spinner"></span>
              <span v-else>{{ submitButtonText }}</span>
            </button>
            
            <div class="register-note">
              <p>✅ 支付1元后，我们的运营专员将在24小时内与您联系，指导后续步骤</p>
              <p>✅ 1元认证费可抵扣首批货款，相当于0成本启动</p>
            </div>
          </form>
        </div>
        
        <div class="register-assurance">
          <h3 class="assurance-title">加入即享三重保障</h3>
          <div class="assurance-list">
            <div class="assurance-item">
              <span class="assurance-icon">🛡️</span>
              <span>合规保障：100%技术隔离外卖时段</span>
            </div>
            <div class="assurance-item">
              <span class="assurance-icon">💼</span>
              <span>收入保障：首月收入不足300元补差额</span>
            </div>
            <div class="assurance-item">
              <span class="assurance-icon">🔄</span>
              <span>退货保障：滞销商品可100%退回</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 常见问题 -->
    <section id="faq" class="faq">
      <div class="container">
        <h2 class="section-title">常见问题</h2>
        
        <div class="faq-list">
          <div 
            v-for="(faq, index) in faqs" 
            :key="index"
            class="faq-item"
            :class="{ active: activeFaq === index }"
          >
            <div class="faq-question" @click="toggleFaq(index)">
              <span>{{ faq.question }}</span>
              <span class="faq-toggle">{{ activeFaq === index ? '−' : '+' }}</span>
            </div>
            <div class="faq-answer" v-show="activeFaq === index">
              {{ faq.answer }}
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 页脚 -->
    <footer class="footer">
      <div class="container">
        <div class="footer-content">
          <div class="footer-section">
            <div class="logo">
              <span class="logo-icon">⚡</span>
              <span class="logo-text">骑手闪仓</span>
            </div>
            <p class="footer-desc">赋能骑手，开启移动零售新副业</p>
          </div>
          
          <div class="footer-section">
            <h4 class="footer-title">联系我们</h4>
            <p>客服微信: qishoushancang</p>
            <p>客服电话: 400-888-1234</p>
            <p>服务时间: 9:00-21:00</p>
          </div>
          
          <div class="footer-section">
            <h4 class="footer-title">办公地址</h4>
            <p>赣州市章贡区红旗大道XX号</p>
            <p>创业大厦3楼301室</p>
          </div>
          
          <div class="footer-section">
            <h4 class="footer-title">关注我们</h4>
            <div class="social-links">
              <a href="#" class="social-link">微信</a>
              <a href="#" class="social-link">抖音</a>
              <a href="#" class="social-link">QQ群</a>
            </div>
          </div>
        </div>
        
        <div class="footer-bottom">
          <p>© 2023 骑手闪仓平台. 保留所有权利. | <a href="#">隐私政策</a> | <a href="#">用户协议</a></p>
        </div>
      </div>
    </footer>

    <!-- 模态框 -->
    <div v-if="showModal" class="modal-overlay" @click="closeModal">
      <div class="modal" @click.stop>
        <div class="modal-header">
          <h3 class="modal-title">{{ modalTitle }}</h3>
          <button class="modal-close" @click="closeModal">×</button>
        </div>
        <div class="modal-content">
          <div v-if="modalType === 'video'">
            <!-- 视频占位 -->
            <div class="video-placeholder">
              <div class="video-play-btn">▶️</div>
              <p>骑手闪仓介绍视频 (25秒)</p>
            </div>
          </div>
          <div v-else-if="modalType === 'terms'">
            <p>这里是《骑手闪仓服务协议》的具体内容...</p>
            <!-- 协议具体内容 -->
          </div>
          <div v-else-if="modalType === 'privacy'">
            <p>这里是《隐私政策》的具体内容...</p>
            <!-- 隐私政策具体内容 -->
          </div>
          <div v-else-if="modalType === 'success'">
            <div class="success-message">
              <div class="success-icon">🎉</div>
              <h3>恭喜！您已成功提交申请</h3>
              <p>我们的运营专员将在24小时内通过电话联系您，请保持手机畅通。</p>
              <p>同时，我们已发送平台使用指南至您的手机短信，请注意查收。</p>
              <button class="btn btn-primary" @click="closeModal">确定</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from 'vue'

// 表单数据
const form = reactive({
  name: '',
  phone: '',
  platform: '',
  area: '',
  expectedIncome: '300-500',
  agreeTerms: false
})

// 状态管理
const submitting = ref(false)
const activeFaq = ref<number | null>(0)
const showModal = ref(false)
const modalType = ref<'video' | 'terms' | 'privacy' | 'success'>('video')
const modalTitle = ref('')

// 演示订单数据
const demoOrders = ref([
  { id: 1, product: '红牛维生素饮料', distance: '0.3km', earning: '¥5.0' },
  { id: 2, product: '乐事薯片', distance: '0.5km', earning: '¥3.5' },
  { id: 3, product: '农夫山泉', distance: '0.8km', earning: '¥2.0' },
  { id: 4, product: '充电宝', distance: '1.2km', earning: '¥8.0' }
])

const todayEarning = ref('28.5')

// 收入范围选项
const incomeRanges = ref([
  { label: '300-500元', value: '300-500' },
  { label: '500-800元', value: '500-800' },
  { label: '800-1200元', value: '800-1200' },
  { label: '1200元以上', value: '1200+' }
])

// 常见问题
const faqs = ref([
  {
    question: '做闪仓会影响我送外卖吗？',
    answer: '完全不会。我们的系统采用智能时间隔离技术，只会在您休息、等单或下线状态时推送零售订单，确保不影响您的外卖工作。'
  },
  {
    question: '1元启动包含哪些东西？',
    answer: '1元启动包含：骑手身份认证、平台使用权限、价值298元的启动物料包（含展示盒、商品价签、宣传物料）以及首批试销商品。'
  },
  {
    question: '商品卖不出去怎么办？',
    answer: '平台提供100%退货保障。滞销商品可在30天内无理由退回，骑手无需承担任何库存损失。'
  },
  {
    question: '如何保证合规性，不被外卖平台处罚？',
    answer: '我们通过技术手段确保零售活动与外卖配送完全隔离：1) 零售时无法接外卖单 2) 使用独立装备 3) 严禁利用外卖订单信息。已获得法律团队合规认证。'
  },
  {
    question: '收益如何结算？多久可以提现？',
    answer: '零售收益实时到账，满10元即可提现，提现申请后24小时内到账。平台不收取任何提现手续费。'
  }
])

// 计算属性
const submitButtonText = computed(() => {
  if (submitting.value) return '提交中...'
  return `支付1元，立即加入`
})

const timelineProgress = ref(0)

// 方法
const scrollToRegister = () => {
  const element = document.getElementById('register')
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' })
  }
}

const openVideoModal = () => {
  modalType.value = 'video'
  modalTitle.value = '骑手闪仓介绍视频'
  showModal.value = true
}

const openTermsModal = () => {
  modalType.value = 'terms'
  modalTitle.value = '骑手闪仓服务协议'
  showModal.value = true
}

const openPrivacyModal = () => {
  modalType.value = 'privacy'
  modalTitle.value = '隐私政策'
  showModal.value = true
}

const openSuccessModal = () => {
  modalType.value = 'success'
  modalTitle.value = '申请成功'
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
}

const toggleFaq = (index: number) => {
  activeFaq.value = activeFaq.value === index ? null : index
}

const handleSubmit = async () => {
  if (!form.agreeTerms) {
    alert('请阅读并同意服务协议与隐私政策')
    return
  }
  
  submitting.value = true
  
  // 模拟API请求
  setTimeout(() => {
    submitting.value = false
    openSuccessModal()
    
    // 重置表单（除了条款同意）
    form.name = ''
    form.phone = ''
    form.platform = ''
    form.area = ''
    form.expectedIncome = '300-500'
  }, 1500)
}

// 生命周期
onMounted(() => {
  // 模拟时间轴动画
  setTimeout(() => {
    timelineProgress.value = 100
  }, 500)
  
  // 模拟今日收入变化
  setInterval(() => {
    const current = parseFloat(todayEarning.value)
    todayEarning.value = (current + 0.5).toFixed(1)
  }, 5000)
})
</script>

<style scoped>
/* 基础样式 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
  line-height: 1.6;
  color: #333;
}

.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 10px 20px;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  border: none;
  font-size: 16px;
}

.btn-primary {
  background: linear-gradient(135deg, #4f46e5, #7c3aed);
  color: white;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(79, 70, 229, 0.3);
}

.btn-outline {
  background: transparent;
  color: #4f46e5;
  border: 2px solid #4f46e5;
}

.btn-outline:hover {
  background: rgba(79, 70, 229, 0.05);
}

.btn-lg {
  padding: 14px 28px;
  font-size: 18px;
}

.btn-block {
  width: 100%;
}

.btn-icon {
  margin-right: 8px;
  font-size: 18px;
}

.spinner {
  width: 20px;
  height: 20px;
  border: 2px solid #ffffff;
  border-top: 2px solid transparent;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-right: 8px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
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
  padding: 15px 0;
  border-bottom: 1px solid #e5e7eb;
}

.header .container {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.logo {
  display: flex;
  align-items: center;
  font-size: 24px;
  font-weight: 700;
  color: #4f46e5;
}

.logo-icon {
  font-size: 28px;
  margin-right: 8px;
}

.nav {
  display: flex;
  gap: 30px;
}

.nav-link {
  color: #4b5563;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s;
}

.nav-link:hover {
  color: #4f46e5;
}

.cta-nav {
  display: flex;
  gap: 15px;
}

/* 英雄区域 */
.hero {
  padding: 140px 0 80px;
  background: linear-gradient(135deg, #f3f4f6 0%, #f9fafb 100%);
  position: relative;
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
  font-weight: 800;
  line-height: 1.2;
  margin-bottom: 20px;
  color: #111827;
}

.highlight {
  color: #4f46e5;
  position: relative;
}

.highlight::after {
  content: '';
  position: absolute;
  bottom: 5px;
  left: 0;
  width: 100%;
  height: 8px;
  background: rgba(79, 70, 229, 0.2);
  z-index: -1;
}

.hero-subtitle {
  font-size: 20px;
  color: #6b7280;
  margin-bottom: 30px;
  line-height: 1.6;
}

.hero-highlight {
  color: #059669;
  font-weight: 600;
}

.hero-stats {
  display: flex;
  gap: 30px;
  margin-bottom: 30px;
}

.stat {
  display: flex;
  flex-direction: column;
}

.stat-number {
  font-size: 28px;
  font-weight: 700;
  color: #4f46e5;
}

.stat-label {
  font-size: 14px;
  color: #6b7280;
  margin-top: 4px;
}

.hero-actions {
  display: flex;
  gap: 20px;
  margin-bottom: 30px;
}

.hero-features {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.feature {
  display: flex;
  align-items: center;
  gap: 10px;
  color: #4b5563;
}

.feature-icon {
  color: #059669;
  font-size: 18px;
}

/* 模拟手机界面 */
.mockup-container {
  position: relative;
}

.mockup-phone {
  width: 300px;
  height: 600px;
  background: #1f2937;
  border-radius: 40px;
  padding: 20px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
  position: relative;
  margin: 0 auto;
}

.phone-screen {
  width: 100%;
  height: 100%;
  background: white;
  border-radius: 24px;
  overflow: hidden;
}

.app-screen {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.app-header {
  padding: 20px;
  background: linear-gradient(135deg, #4f46e5, #7c3aed);
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.app-title {
  font-size: 20px;
  font-weight: 700;
}

.app-balance {
  font-size: 16px;
  font-weight: 600;
}

.app-content {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
}

.order-card {
  background: #f9fafb;
  border-radius: 12px;
  padding: 16px;
  margin-bottom: 12px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border: 1px solid #e5e7eb;
}

.order-info {
  display: flex;
  flex-direction: column;
}

.order-product {
  font-weight: 600;
  color: #111827;
}

.order-location {
  font-size: 14px;
  color: #6b7280;
  margin-top: 4px;
}

.order-earning {
  font-weight: 700;
  color: #059669;
  font-size: 18px;
}

.app-footer {
  padding: 20px;
  border-top: 1px solid #e5e7eb;
}

.today-earning {
  font-size: 18px;
  font-weight: 600;
  color: #111827;
}

.earning-amount {
  color: #059669;
  font-size: 24px;
}

.visual-badge {
  position: absolute;
  bottom: -30px;
  right: -30px;
  background: white;
  padding: 20px;
  border-radius: 16px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  gap: 8px;
  min-width: 180px;
}

.badge-text {
  font-weight: 700;
  color: #dc2626;
  font-size: 14px;
}

.badge-product {
  font-weight: 600;
  font-size: 18px;
}

.badge-profit {
  color: #059669;
  font-weight: 700;
}

/* 收益优势 */
.benefits {
  padding: 100px 0;
  background: white;
}

.section-title {
  font-size: 36px;
  font-weight: 800;
  text-align: center;
  color: #111827;
  margin-bottom: 16px;
}

.section-subtitle {
  font-size: 18px;
  color: #6b7280;
  text-align: center;
  margin-bottom: 60px;
}

.benefits-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
}

.benefit-card {
  background: #f9fafb;
  border-radius: 16px;
  padding: 30px;
  transition: all 0.3s ease;
  border: 2px solid transparent;
}

.benefit-card:hover {
  transform: translateY(-5px);
  border-color: #4f46e5;
  box-shadow: 0 20px 40px rgba(79, 70, 229, 0.1);
}

.benefit-icon {
  font-size: 40px;
  margin-bottom: 20px;
}

.benefit-title {
  font-size: 22px;
  font-weight: 700;
  margin-bottom: 12px;
  color: #111827;
}

.benefit-desc {
  color: #6b7280;
  line-height: 1.6;
}

/* 加入流程 */
.process {
  padding: 80px 0;
  background: #f8fafc;
}

.process-steps {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 40px;
  margin-bottom: 60px;
  flex-wrap: wrap;
}

.step {
  text-align: center;
  max-width: 200px;
}

.step-number {
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, #4f46e5, #7c3aed);
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28px;
  font-weight: 700;
  margin: 0 auto 20px;
}

.step-title {
  font-size: 20px;
  font-weight: 700;
  margin-bottom: 8px;
  color: #111827;
}

.step-desc {
  color: #6b7280;
  font-size: 14px;
}

.step-arrow {
  font-size: 24px;
  color: #9ca3af;
}

.process-visual {
  max-width: 800px;
  margin: 0 auto;
}

.timeline {
  height: 4px;
  background: #e5e7eb;
  border-radius: 2px;
  position: relative;
  margin-top: 60px;
}

.timeline-progress {
  position: absolute;
  height: 100%;
  background: linear-gradient(90deg, #4f46e5, #7c3aed);
  border-radius: 2px;
  transition: width 1.5s ease-in-out;
}

.timeline-marker {
  position: absolute;
  top: -28px;
  transform: translateX(-50%);
}

.marker-dot {
  width: 16px;
  height: 16px;
  background: #4f46e5;
  border-radius: 50%;
  margin: 0 auto 8px;
  border: 3px solid white;
  box-shadow: 0 0 0 3px #4f46e5;
}

.marker-label {
  font-size: 14px;
  font-weight: 600;
  color: #4b5563;
  white-space: nowrap;
}

/* 注册表单 */
.register {
  padding: 100px 0;
  background: white;
}

.register-card {
  max-width: 600px;
  margin: 0 auto 60px;
  background: #f9fafb;
  border-radius: 24px;
  padding: 40px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
}

.register-header {
  text-align: center;
  margin-bottom: 40px;
}

.register-title {
  font-size: 32px;
  font-weight: 800;
  color: #111827;
  margin-bottom: 12px;
}

.register-subtitle {
  font-size: 18px;
  color: #6b7280;
}

.register-form {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.form-group {
  display: flex;
  flex-direction: column;
}

.form-label {
  font-weight: 600;
  margin-bottom: 8px;
  color: #374151;
}

.form-input {
  padding: 14px 16px;
  border: 2px solid #e5e7eb;
  border-radius: 8px;
  font-size: 16px;
  transition: all 0.3s;
}

.form-input:focus {
  outline: none;
  border-color: #4f46e5;
  box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
}

.income-range {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
}

.income-option {
  padding: 14px;
  border: 2px solid #e5e7eb;
  border-radius: 8px;
  text-align: center;
  cursor: pointer;
  transition: all 0.3s;
}

.income-option:hover {
  border-color: #4f46e5;
}

.income-option.active {
  background: #4f46e5;
  color: white;
  border-color: #4f46e5;
}

.terms {
  flex-direction: row;
  align-items: center;
  gap: 12px;
}

.terms-checkbox {
  width: 20px;
  height: 20px;
}

.terms-label {
  font-size: 14px;
  color: #6b7280;
}

.terms-label a {
  color: #4f46e5;
  text-decoration: none;
}

.terms-label a:hover {
  text-decoration: underline;
}

.register-note {
  background: #d1fae5;
  padding: 16px;
  border-radius: 8px;
  font-size: 14px;
  color: #065f46;
  margin-top: 20px;
}

.register-note p {
  margin-bottom: 8px;
}

.register-note p:last-child {
  margin-bottom: 0;
}

.register-assurance {
  max-width: 800px;
  margin: 0 auto;
  text-align: center;
}

.assurance-title {
  font-size: 24px;
  font-weight: 700;
  margin-bottom: 30px;
  color: #111827;
}

.assurance-list {
  display: flex;
  justify-content: center;
  gap: 40px;
  flex-wrap: wrap;
}

.assurance-item {
  display: flex;
  align-items: center;
  gap: 10px;
  font-weight: 500;
}

.assurance-icon {
  font-size: 20px;
}

/* 常见问题 */
.faq {
  padding: 80px 0;
  background: #f8fafc;
}

.faq-list {
  max-width: 800px;
  margin: 0 auto;
}

.faq-item {
  background: white;
  border-radius: 12px;
  margin-bottom: 16px;
  overflow: hidden;
  border: 1px solid #e5e7eb;
}

.faq-question {
  padding: 24px;
  font-weight: 600;
  font-size: 18px;
  color: #111827;
  cursor: pointer;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.faq-toggle {
  font-size: 24px;
  color: #4f46e5;
}

.faq-answer {
  padding: 0 24px 24px;
  color: #6b7280;
  line-height: 1.6;
}

.faq-item.active {
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
}

/* 页脚 */
.footer {
  background: #111827;
  color: white;
  padding: 60px 0 30px;
}

.footer-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 40px;
  margin-bottom: 40px;
}

.footer-section {
  display: flex;
  flex-direction: column;
}

.footer .logo {
  color: white;
  margin-bottom: 16px;
}

.footer-desc {
  color: #9ca3af;
  font-size: 14px;
}

.footer-title {
  font-size: 18px;
  font-weight: 700;
  margin-bottom: 20px;
}

.footer-section p {
  color: #d1d5db;
  margin-bottom: 8px;
  font-size: 14px;
}

.social-links {
  display: flex;
  gap: 15px;
}

.social-link {
  color: #d1d5db;
  text-decoration: none;
  font-size: 14px;
}

.social-link:hover {
  color: white;
}

.footer-bottom {
  padding-top: 30px;
  border-top: 1px solid #374151;
  text-align: center;
  color: #9ca3af;
  font-size: 14px;
}

.footer-bottom a {
  color: #9ca3af;
  text-decoration: none;
}

.footer-bottom a:hover {
  color: white;
}

/* 模态框 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(5px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2000;
}

.modal {
  background: white;
  border-radius: 16px;
  max-width: 500px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
}

.modal-header {
  padding: 24px;
  border-bottom: 1px solid #e5e7eb;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.modal-title {
  font-size: 24px;
  font-weight: 700;
  color: #111827;
}

.modal-close {
  background: none;
  border: none;
  font-size: 28px;
  color: #6b7280;
  cursor: pointer;
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-content {
  padding: 24px;
}

.video-placeholder {
  background: #1f2937;
  border-radius: 12px;
  height: 300px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: white;
}

.video-play-btn {
  font-size: 60px;
  margin-bottom: 20px;
}

.success-message {
  text-align: center;
  padding: 20px 0;
}

.success-icon {
  font-size: 60px;
  margin-bottom: 20px;
}

.success-message h3 {
  font-size: 24px;
  font-weight: 700;
  margin-bottom: 16px;
  color: #111827;
}

.success-message p {
  color: #6b7280;
  margin-bottom: 12px;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .hero .container {
    grid-template-columns: 1fr;
    gap: 40px;
  }
  
  .hero-visual {
    order: -1;
  }
  
  .mockup-phone {
    width: 280px;
    height: 560px;
  }
}

@media (max-width: 768px) {
  .hero-title {
    font-size: 36px;
  }
  
  .section-title {
    font-size: 28px;
  }
  
  .process-steps {
    flex-direction: column;
    gap: 30px;
  }
  
  .step-arrow {
    transform: rotate(90deg);
  }
  
  .income-range {
    grid-template-columns: 1fr;
  }
  
  .nav {
    display: none;
  }
  
  .hero-stats {
    flex-direction: column;
    gap: 20px;
  }
}

@media (max-width: 480px) {
  .hero-actions {
    flex-direction: column;
  }
  
  .btn-lg {
    width: 100%;
  }
  
  .register-card {
    padding: 24px;
  }
  
  .assurance-list {
    flex-direction: column;
    gap: 20px;
  }
}
</style>