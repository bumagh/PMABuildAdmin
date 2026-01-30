<template>
  <div class="landing-page">
    <!-- 导航栏 -->
    <header class="header">
      <div class="container">
        <div class="logo">
          <span class="logo-icon">✨</span>
          <span class="logo-text">创梦AI</span>
        </div>
        <nav class="nav">
          <a href="#features" class="nav-link">核心功能</a>
          <a href="#process" class="nav-link">工作流程</a>
          <a href="#pricing" class="nav-link">价格方案</a>
          <a href="#cases" class="nav-link">成功案例</a>
        </nav>
        <div class="header-actions">
          <button class="btn btn-login" @click="handleLogin">登录</button>
          <button class="btn btn-primary" @click="handleStart">立即体验</button>
        </div>
      </div>
    </header>

    <!-- 主视觉区域 -->
    <section class="hero">
      <div class="container">
        <div class="hero-content">
          <h1 class="hero-title">
            <span class="gradient-text">AI驱动</span> 创意实现
            <br />
            让每一个梦想<span class="highlight">快速落地</span>
          </h1>
          <p class="hero-description">
            无需编程基础，通过人工+AI协同，快速生成小程序、H5游戏、网页应用及创业方案
            <br />
            从创意到成品，创梦AI为您提供全流程服务
          </p>
          <div class="hero-actions">
            <button class="btn btn-primary btn-large" @click="handleStart">
              立即开始创作
              <span class="icon-arrow">→</span>
            </button>
            <button class="btn btn-outline btn-large" @click="handleDemo">
              查看演示视频
            </button>
          </div>
          <div class="hero-stats">
            <div class="stat-item">
              <div class="stat-number">{{ stats.projects }}+</div>
              <div class="stat-label">项目已生成</div>
            </div>
            <div class="stat-item">
              <div class="stat-number">{{ stats.users }}+</div>
              <div class="stat-label">注册用户</div>
            </div>
            <div class="stat-item">
              <div class="stat-number">{{ stats.successRate }}%</div>
              <div class="stat-label">用户满意度</div>
            </div>
          </div>
        </div>
        <div class="hero-visual">
          <div class="dashboard-preview">
            <div class="dashboard-header">
              <div class="dashboard-tabs">
                <span class="tab active">项目创建</span>
                <span class="tab">AI助手</span>
                <span class="tab">进度跟踪</span>
              </div>
            </div>
            <div class="dashboard-content">
              <div class="ai-chat">
                <div class="message user">
                  <span class="avatar">👤</span>
                  <div class="bubble">我想要一个宠物用品电商小程序，需要有商品展示、购物车和在线支付功能</div>
                </div>
                <div class="message ai">
                  <span class="avatar">🤖</span>
                  <div class="bubble">
                    <div class="typing">
                      <span></span><span></span><span></span>
                    </div>
                    <div class="suggestions">
                      <div class="suggestion-tag">#电商模板</div>
                      <div class="suggestion-tag">#支付集成</div>
                      <div class="suggestion-tag">#UI设计</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 核心功能 -->
    <section id="features" class="features">
      <div class="container">
        <h2 class="section-title">核心功能</h2>
        <div class="features-grid">
          <div class="feature-card">
            <div class="feature-icon">🎯</div>
            <h3 class="feature-title">智能需求解析</h3>
            <p class="feature-description">
              通过对话式交互，AI自动解析您的需求，生成专业的需求文档和功能清单
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">🛠️</div>
            <h3 class="feature-title">多平台生成</h3>
            <p class="feature-description">
              支持生成小程序、H5应用、安卓应用、PC工具，一次描述，多端适配
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">⚡</div>
            <h3 class="feature-title">加速交付</h3>
            <p class="feature-description">
              积分加速系统，通过消耗积分可提升项目优先级，最快24小时交付
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">👥</div>
            <h3 class="feature-title">人工协同</h3>
            <p class="feature-description">
              专业策划师全程跟进，弥补纯AI生成的不足，确保项目质量
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- 工作流程 -->
    <section id="process" class="process">
      <div class="container">
        <h2 class="section-title">简单四步，实现创意</h2>
        <div class="process-steps">
          <div class="step">
            <div class="step-number">01</div>
            <div class="step-content">
              <h3>提交需求</h3>
              <p>通过对话描述您的想法，上传参考文档、图片或原型图</p>
            </div>
          </div>
          <div class="step-arrow">→</div>
          <div class="step">
            <div class="step-number">02</div>
            <div class="step-content">
              <h3>AI分析策划</h3>
              <p>AI自动分析需求，生成方案建议，人工策划师介入优化</p>
            </div>
          </div>
          <div class="step-arrow">→</div>
          <div class="step">
            <div class="step-number">03</div>
            <div class="step-content">
              <h3>执行与生成</h3>
              <p>专业团队使用AI工具协同工作，高效生成项目代码和素材</p>
            </div>
          </div>
          <div class="step-arrow">→</div>
          <div class="step">
            <div class="step-number">04</div>
            <div class="step-content">
              <h3>交付与支持</h3>
              <p>完整项目文件交付，提供部署指导和7天技术支持</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 价格方案 -->
    <section id="pricing" class="pricing">
      <div class="container">
        <h2 class="section-title">灵活的价格方案</h2>
        <div class="pricing-cards">
          <div class="pricing-card">
            <div class="pricing-header">
              <h3>体验版</h3>
              <div class="price">
                <span class="currency">¥</span>
                <span class="amount">0</span>
                <span class="period">/永久免费</span>
              </div>
            </div>
            <ul class="pricing-features">
              <li><span class="check">✓</span> 1次基础项目体验</li>
              <li><span class="check">✓</span> 3天标准处理周期</li>
              <li><span class="check">✓</span> 基础技术支持</li>
              <li><span class="cross">✗</span> 无加速服务</li>
              <li><span class="cross">✗</span> 无专属客服</li>
            </ul>
            <button class="btn btn-outline btn-block" @click="handleFree">开始体验</button>
          </div>
          <div class="pricing-card featured">
            <div class="badge">最受欢迎</div>
            <div class="pricing-header">
              <h3>专业版</h3>
              <div class="price">
                <span class="currency">¥</span>
                <span class="amount">99</span>
                <span class="period">/月</span>
              </div>
              <div class="integral-info">包含1000积分</div>
            </div>
            <ul class="pricing-features">
              <li><span class="check">✓</span> 3次基础项目生成</li>
              <li><span class="check">✓</span> 积分加速通道</li>
              <li><span class="check">✓</span> 多格式素材上传</li>
              <li><span class="check">✓</span> 专属客服支持</li>
              <li><span class="check">✓</span> 优先处理队列</li>
            </ul>
            <button class="btn btn-primary btn-block" @click="handleSubscribe">立即订阅</button>
          </div>
          <div class="pricing-card">
            <div class="pricing-header">
              <h3>企业版</h3>
              <div class="price">
                <span class="currency">¥</span>
                <span class="amount">3000</span>
                <span class="period">/起</span>
              </div>
              <div class="integral-info">定制化方案</div>
            </div>
            <ul class="pricing-features">
              <li><span class="check">✓</span> 定制化需求开发</li>
              <li><span class="check">✓</span> 专属项目经理</li>
              <li><span class="check">✓</span> 无限次项目生成</li>
              <li><span class="check">✓</span> 源码交付</li>
              <li><span class="check">✓</span> 30天技术支持</li>
            </ul>
            <button class="btn btn-outline btn-block" @click="handleContact">联系商务</button>
          </div>
        </div>
        <div class="pricing-note">
          * 积分可用于加速、修改和专属服务，未使用积分可累积到下月
        </div>
      </div>
    </section>

    <!-- 成功案例 -->
    <section id="cases" class="cases">
      <div class="container">
        <h2 class="section-title">成功案例</h2>
        <div class="cases-grid">
          <div class="case-card">
            <div class="case-image">
              <div class="case-badge">小程序</div>
            </div>
            <div class="case-content">
              <h3>宠物电商小程序</h3>
              <p>某宠物用品店通过创梦AI在48小时内生成完整电商小程序，包含商品展示、购物车和在线支付功能</p>
              <div class="case-stats">
                <span>生成时间：2天</span>
                <span>成本：300积分</span>
              </div>
            </div>
          </div>
          <div class="case-card">
            <div class="case-image">
              <div class="case-badge">H5游戏</div>
            </div>
            <div class="case-content">
              <h3>营销互动游戏</h3>
              <p>品牌营销团队快速生成节日营销H5游戏，实现用户裂变和品牌传播</p>
              <div class="case-stats">
                <span>生成时间：3天</span>
                <span>成本：400积分</span>
              </div>
            </div>
          </div>
          <div class="case-card">
            <div class="case-image">
              <div class="case-badge">创业方案</div>
            </div>
            <div class="case-content">
              <h3>在线教育创业方案</h3>
              <p>创业者获得完整的产品方案、技术架构和商业计划书，成功获得天使投资</p>
              <div class="case-stats">
                <span>策划周期：1周</span>
                <span>成本：800积分</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA区域 -->
    <section class="cta">
      <div class="container">
        <div class="cta-content">
          <h2 class="cta-title">立即开始您的创意之旅</h2>
          <p class="cta-description">
            无需等待，无需技术背景，让AI和专业团队帮助您快速实现梦想
          </p>
          <div class="cta-form">
            <input
              v-model="email"
              type="email"
              placeholder="输入您的邮箱获取免费体验"
              class="email-input"
            />
            <button class="btn btn-primary btn-large" @click="handleGetStarted">
              免费体验
            </button>
          </div>
          <p class="cta-note">24小时内将有专属顾问联系您</p>
        </div>
      </div>
    </section>

    <!-- 页脚 -->
    <footer class="footer">
      <div class="container">
        <div class="footer-content">
          <div class="footer-section">
            <div class="logo">
              <span class="logo-icon">✨</span>
              <span class="logo-text">创梦AI</span>
            </div>
            <p class="footer-description">
              让每一个创业梦想都能通过技术快速验证
            </p>
          </div>
          <div class="footer-section">
            <h4>产品</h4>
            <a href="#" class="footer-link">小程序生成</a>
            <a href="#" class="footer-link">H5游戏生成</a>
            <a href="#" class="footer-link">创业方案策划</a>
            <a href="#" class="footer-link">多端应用生成</a>
          </div>
          <div class="footer-section">
            <h4>资源</h4>
            <a href="#" class="footer-link">帮助文档</a>
            <a href="#" class="footer-link">视频教程</a>
            <a href="#" class="footer-link">开发者API</a>
            <a href="#" class="footer-link">模板市场</a>
          </div>
          <div class="footer-section">
            <h4>联系我们</h4>
            <a href="#" class="footer-link">商务合作</a>
            <a href="#" class="footer-link">技术支持</a>
            <a href="#" class="footer-link">反馈建议</a>
            <a href="#" class="footer-link">加入我们</a>
          </div>
        </div>
        <div class="footer-bottom">
          <p>© 2024 创梦AI. 保留所有权利.</p>
        </div>
      </div>
    </footer>

    <!-- 浮动按钮 -->
    <button class="float-button" @click="handleFloat">
      <span class="float-icon">💬</span>
      <span class="float-text">开始咨询</span>
    </button>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

// 响应式数据
const stats = ref({
  projects: 1287,
  users: 892,
  successRate: 96
})

const email = ref('')

// 生命周期
onMounted(() => {
  // 可以添加页面加载后的初始化逻辑
  console.log('Landing page mounted')
})

// 事件处理函数
const handleLogin = () => {
  alert('跳转到登录页面')
}

const handleStart = () => {
  alert('开始创建项目')
}

const handleDemo = () => {
  alert('播放演示视频')
}

const handleFree = () => {
  alert('开始免费体验')
}

const handleSubscribe = () => {
  alert('订阅专业版')
}

const handleContact = () => {
  alert('联系商务')
}

const handleGetStarted = () => {
  if (!email.value) {
    alert('请输入邮箱')
    return
  }
  alert(`我们将发送体验链接至: ${email.value}`)
  email.value = ''
}

const handleFloat = () => {
  alert('打开在线客服')
}
</script>

<style scoped>
.landing-page {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  color: #333;
  line-height: 1.6;
}

/* 通用样式 */
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.btn {
  padding: 10px 24px;
  border-radius: 8px;
  border: none;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}

.btn-outline {
  background: transparent;
  border: 2px solid #667eea;
  color: #667eea;
}

.btn-outline:hover {
  background: #667eea;
  color: white;
}

.btn-large {
  padding: 14px 32px;
  font-size: 18px;
}

.btn-block {
  width: 100%;
  margin-top: 20px;
}

.btn-login {
  background: transparent;
  color: #667eea;
  margin-right: 12px;
}

/* 导航栏 */
.header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  z-index: 1000;
  padding: 16px 0;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.header .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  display: flex;
  align-items: center;
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.logo-icon {
  margin-right: 8px;
  font-size: 28px;
}

.nav {
  display: flex;
  gap: 32px;
}

.nav-link {
  text-decoration: none;
  color: #666;
  font-weight: 500;
  transition: color 0.3s;
}

.nav-link:hover {
  color: #667eea;
}

/* 主视觉区域 */
.hero {
  padding: 160px 0 100px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
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
  margin-bottom: 24px;
}

.gradient-text {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.highlight {
  color: #667eea;
}

.hero-description {
  font-size: 18px;
  color: #666;
  margin-bottom: 32px;
  line-height: 1.6;
}

.hero-actions {
  display: flex;
  gap: 16px;
  margin-bottom: 48px;
}

.icon-arrow {
  margin-left: 8px;
  transition: transform 0.3s;
}

.btn:hover .icon-arrow {
  transform: translateX(4px);
}

.hero-stats {
  display: flex;
  gap: 40px;
}

.stat-item {
  text-align: center;
}

.stat-number {
  font-size: 32px;
  font-weight: 700;
  color: #667eea;
  margin-bottom: 4px;
}

.stat-label {
  font-size: 14px;
  color: #666;
}

/* 仪表板预览 */
.dashboard-preview {
  background: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  transform: perspective(1000px) rotateY(-10deg);
  animation: float 6s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: perspective(1000px) rotateY(-10deg) translateY(0); }
  50% { transform: perspective(1000px) rotateY(-10deg) translateY(-10px); }
}

.dashboard-tabs {
  display: flex;
  gap: 16px;
  margin-bottom: 24px;
}

.tab {
  padding: 8px 16px;
  border-radius: 6px;
  font-size: 14px;
  color: #666;
  cursor: pointer;
}

.tab.active {
  background: #667eea;
  color: white;
}

.ai-chat {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.message {
  display: flex;
  gap: 12px;
  align-items: flex-start;
}

.message.user {
  flex-direction: row-reverse;
}

.avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: #f0f0f0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
}

.bubble {
  background: #f0f0f0;
  padding: 12px 16px;
  border-radius: 12px;
  max-width: 70%;
}

.message.user .bubble {
  background: #667eea;
  color: white;
  border-radius: 12px 12px 0 12px;
}

.typing {
  display: flex;
  gap: 4px;
  margin-bottom: 8px;
}

.typing span {
  width: 8px;
  height: 8px;
  background: #667eea;
  border-radius: 50%;
  animation: typing 1.4s infinite;
}

.typing span:nth-child(2) { animation-delay: 0.2s; }
.typing span:nth-child(3) { animation-delay: 0.4s; }

@keyframes typing {
  0%, 100% { opacity: 0.3; }
  50% { opacity: 1; }
}

.suggestions {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.suggestion-tag {
  background: rgba(102, 126, 234, 0.1);
  color: #667eea;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
}

/* 核心功能区域 */
.features {
  padding: 100px 0;
  background: white;
}

.section-title {
  text-align: center;
  font-size: 36px;
  font-weight: 700;
  margin-bottom: 60px;
  color: #333;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
}

.feature-card {
  background: #f8f9fa;
  padding: 32px;
  border-radius: 16px;
  text-align: center;
  transition: transform 0.3s;
}

.feature-card:hover {
  transform: translateY(-10px);
}

.feature-icon {
  font-size: 48px;
  margin-bottom: 20px;
}

.feature-title {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 12px;
}

.feature-description {
  color: #666;
  line-height: 1.6;
}

/* 工作流程 */
.process {
  padding: 100px 0;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.process .section-title {
  color: white;
}

.process-steps {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  gap: 40px;
}

.step {
  display: flex;
  align-items: center;
  gap: 20px;
  background: rgba(255, 255, 255, 0.1);
  padding: 24px;
  border-radius: 16px;
  backdrop-filter: blur(10px);
  min-width: 200px;
}

.step-number {
  font-size: 32px;
  font-weight: 800;
  color: rgba(255, 255, 255, 0.2);
}

.step-content h3 {
  font-size: 20px;
  margin-bottom: 8px;
}

.step-arrow {
  font-size: 24px;
  color: rgba(255, 255, 255, 0.5);
}

/* 价格方案 */
.pricing {
  padding: 100px 0;
  background: white;
}

.pricing-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  margin-bottom: 20px;
}

.pricing-card {
  background: #f8f9fa;
  padding: 32px;
  border-radius: 16px;
  position: relative;
  transition: transform 0.3s;
}

.pricing-card:hover {
  transform: translateY(-5px);
}

.pricing-card.featured {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  transform: scale(1.05);
}

.badge {
  position: absolute;
  top: -12px;
  left: 50%;
  transform: translateX(-50%);
  background: #ff6b6b;
  color: white;
  padding: 6px 16px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 600;
}

.pricing-header {
  text-align: center;
  margin-bottom: 24px;
  border-bottom: 2px solid rgba(0, 0, 0, 0.1);
  padding-bottom: 24px;
}

.pricing-card.featured .pricing-header {
  border-bottom-color: rgba(255, 255, 255, 0.2);
}

.price {
  font-size: 48px;
  font-weight: 700;
  margin-top: 12px;
}

.currency {
  font-size: 24px;
  vertical-align: top;
}

.period {
  font-size: 16px;
  color: #666;
  font-weight: 400;
}

.pricing-card.featured .period {
  color: rgba(255, 255, 255, 0.8);
}

.integral-info {
  margin-top: 8px;
  color: #667eea;
  font-weight: 500;
}

.pricing-card.featured .integral-info {
  color: white;
}

.pricing-features {
  list-style: none;
  padding: 0;
  margin: 0 0 24px;
}

.pricing-features li {
  padding: 8px 0;
  display: flex;
  align-items: center;
  gap: 8px;
}

.check {
  color: #4CAF50;
}

.cross {
  color: #f44336;
}

.pricing-card.featured .check,
.pricing-card.featured .cross {
  color: white;
}

.pricing-note {
  text-align: center;
  color: #666;
  font-size: 14px;
}

/* 成功案例 */
.cases {
  padding: 100px 0;
  background: #f8f9fa;
}

.cases-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
}

.case-card {
  background: white;
  border-radius: 16px;
  overflow: hidden;
  transition: transform 0.3s;
}

.case-card:hover {
  transform: translateY(-5px);
}

.case-image {
  height: 200px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  position: relative;
}

.case-badge {
  position: absolute;
  top: 20px;
  left: 20px;
  background: white;
  color: #667eea;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 600;
}

.case-content {
  padding: 24px;
}

.case-content h3 {
  font-size: 20px;
  margin-bottom: 12px;
  color: #333;
}

.case-content p {
  color: #666;
  margin-bottom: 16px;
  line-height: 1.6;
}

.case-stats {
  display: flex;
  justify-content: space-between;
  color: #667eea;
  font-size: 14px;
  font-weight: 500;
}

/* CTA区域 */
.cta {
  padding: 100px 0;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  text-align: center;
}

.cta-title {
  font-size: 36px;
  font-weight: 700;
  margin-bottom: 20px;
}

.cta-description {
  font-size: 18px;
  margin-bottom: 40px;
  opacity: 0.9;
}

.cta-form {
  max-width: 500px;
  margin: 0 auto 20px;
  display: flex;
  gap: 12px;
}

.email-input {
  flex: 1;
  padding: 16px 20px;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  outline: none;
}

.cta-note {
  font-size: 14px;
  opacity: 0.7;
}

/* 页脚 */
.footer {
  background: #333;
  color: white;
  padding: 60px 0 30px;
}

.footer-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 40px;
  margin-bottom: 40px;
}

.footer-section h4 {
  font-size: 18px;
  margin-bottom: 20px;
  color: white;
}

.footer-link {
  display: block;
  color: rgba(255, 255, 255, 0.7);
  text-decoration: none;
  margin-bottom: 12px;
  transition: color 0.3s;
}

.footer-link:hover {
  color: white;
}

.footer-bottom {
  text-align: center;
  padding-top: 30px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  color: rgba(255, 255, 255, 0.5);
  font-size: 14px;
}

/* 浮动按钮 */
.float-button {
  position: fixed;
  bottom: 30px;
  right: 30px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  border-radius: 50px;
  padding: 16px 24px;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  box-shadow: 0 4px 20px rgba(102, 126, 234, 0.4);
  transition: all 0.3s ease;
  z-index: 1000;
}

.float-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 25px rgba(102, 126, 234, 0.6);
}

.float-icon {
  font-size: 20px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .header .container {
    flex-direction: column;
    gap: 16px;
  }
  
  .nav {
    gap: 16px;
    flex-wrap: wrap;
    justify-content: center;
  }
  
  .hero .container {
    grid-template-columns: 1fr;
    text-align: center;
  }
  
  .hero-title {
    font-size: 36px;
  }
  
  .hero-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .hero-stats {
    justify-content: center;
  }
  
  .process-steps {
    flex-direction: column;
  }
  
  .step-arrow {
    transform: rotate(90deg);
  }
  
  .cta-form {
    flex-direction: column;
  }
  
  .dashboard-preview {
    transform: none;
    animation: none;
  }
}
</style>