<template>
  <div class="landing-page">
    <!-- 头部 Banner -->
    <header class="hero-section">
      <div class="container">
        <h1 class="hero-title">
          小程序小游戏最快<em>30天</em>上线创收
        </h1>
        <p class="hero-subtitle">您的小程序<span class="highlight">睡后收入引擎</span>，最快30天上线创收</p>
        <div class="hero-cta">
          <div class="pricing-tag">
            <span class="original-price">原价 ¥19999</span>
            <span class="current-price"><strong>1元</strong>锁定排期</span>
          </div>
          <button class="cta-button" @click="handleConsult">
            立即咨询，抢占名额
            <span class="button-sub">仅限前50名</span>
          </button>
          <p class="cta-note">告别复杂开发，我们为您定制、上架、运营，您坐享分成</p>
        </div>
      </div>
    </header>

    <!-- 价值主张 -->
    <section class="value-proposition">
      <div class="container">
        <p class="value-text">
          如果您正在寻找一个门槛低、上线快、能持续产生被动收入的数字化资产，那么您来对地方了。我们专注将已验证的微信小游戏模型，如《多米诺骨牌》这类解压、易传播的明星品类，快速转化为属于您的盈利工具。
        </p>
      </div>
    </section>

    <!-- 痛点对比 -->
    <section class="pain-points section">
      <div class="container">
        <h2 class="section-title">
          ❌ 为什么自己从零开发是个<span class="warning">"陷阱"</span>？
        </h2>
        <div class="comparison-grid">
          <div class="bad-side">
            <h3>自己开发的困境</h3>
            <ul class="point-list danger-list">
              <li>
                <span class="icon">⏰</span>
                <div>
                  <strong>周期长：</strong>从学技术到上线，动辄3-6个月，市场机会稍纵即逝。
                </div>
              </li>
              <li>
                <span class="icon">💰</span>
                <div>
                  <strong>成本高：</strong>聘请开发、设计团队，成本轻易超过数万元。
                </div>
              </li>
              <li>
                <span class="icon">🕳️</span>
                <div>
                  <strong>坑太多：</strong>性能优化、平台审核、广告接入，处处是隐性成本。
                </div>
              </li>
              <li>
                <span class="icon">📉</span>
                <div>
                  <strong>变现难：</strong>缺乏运营经验，游戏上线后无用户、无收入，前期投入打水漂。
                </div>
              </li>
            </ul>
          </div>
          <div class="good-side">
            <h3>✅ 我们的解决方案</h3>
            <div class="solution-card">
              <div class="solution-header">
                <span class="tag">交钥匙工程</span>
                <h4>您当"甩手掌柜"</h4>
              </div>
              <p class="solution-desc">
                我们提供从定制开发到稳定营收的全包服务。您只需一个想法，我们来负责所有执行，最快30天内让您的小游戏上线并开始产生广告收益。
              </p>
              <div class="highlight-box">
                <span class="highlight-text">今天只需1元，即可锁定专属排期与定制咨询！</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 交付蓝图 -->
    <section class="delivery-blueprint section">
      <div class="container">
        <h2 class="section-title">
          🚀 我们的"四步快营收"交付蓝图
        </h2>
        <div class="timeline">
          <div class="timeline-item" v-for="(step, index) in deliverySteps" :key="index">
            <div class="timeline-marker">
              <div class="step-number">第{{ index + 1 }}阶段</div>
              <div class="step-week">第{{ step.week }}周</div>
            </div>
            <div class="timeline-content">
              <h3>{{ step.title }}</h3>
              <p class="timeline-desc">{{ step.desc }}</p>
              <ul class="feature-list">
                <li v-for="(feature, fIndex) in step.features" :key="fIndex">● {{ feature }}</li>
              </ul>
              <div v-if="step.note" class="timeline-note">
                {{ step.note }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 盈利模型 -->
    <section class="revenue-model section">
      <div class="container">
        <h2 class="section-title">
          💰 清晰的盈利前景：广告+订阅双引擎
        </h2>
        <p class="section-subtitle">
          您的收入将主要来源于微信平台庞大的广告生态，透明可分润。
        </p>
        
        <div class="revenue-cards">
          <div class="revenue-card">
            <div class="card-header">
              <h3>1. 广告收益（核心来源）</h3>
              <span class="revenue-tag">主要收入</span>
            </div>
            <div class="ad-types">
              <div class="ad-type">
                <div class="ad-icon">🎬</div>
                <div class="ad-info">
                  <h4>激励视频</h4>
                  <p>用户主动观看，获得道具或特权。<br>eCPM最高（通常在50-300元区间波动）</p>
                </div>
              </div>
              <div class="ad-type">
                <div class="ad-icon">📱</div>
                <div class="ad-info">
                  <h4>插屏广告</h4>
                  <p>自然场景弹出，收益稳定</p>
                </div>
              </div>
              <div class="ad-type">
                <div class="ad-icon">📊</div>
                <div class="ad-info">
                  <h4>Banner广告</h4>
                  <p>底部持续展示，细水长流</p>
                </div>
              </div>
            </div>
            
            <div class="revenue-simulation">
              <h4>收益模拟（以保守数据估算）</h4>
              <div class="simulation-formula">
                <div class="formula-line">
                  <span class="formula-part">日广告收入</span>
                  <span class="operator">≈</span>
                  <span class="formula-part">500 (DAU)</span>
                  <span class="operator">×</span>
                  <span class="formula-part">4 (人均展示)</span>
                  <span class="operator">×</span>
                  <span class="formula-part">￥60 (eCPM)</span>
                  <span class="operator">÷</span>
                  <span class="formula-part">1000</span>
                </div>
                <div class="formula-result">
                  = <strong>120元/天</strong>
                </div>
                <div class="formula-result">
                  月广告收入 ≈ 120 × 30 = <strong>3,600元/月</strong>
                </div>
              </div>
            </div>
          </div>
          
          <div class="revenue-card">
            <div class="card-header">
              <h3>2. 订阅会员模式（增值选项）</h3>
              <span class="revenue-tag secondary">增值收入</span>
            </div>
            <div class="subscription-features">
              <div class="subscription-item">
                <span class="check-icon">✅</span>
                <p>可设计月费会员，去除广告、解锁专属皮肤与高级功能</p>
              </div>
              <div class="subscription-item">
                <span class="check-icon">✅</span>
                <p>提供更稳定、优质的持续性收入来源，与广告收益形成互补</p>
              </div>
            </div>
            <div class="subscription-benefits">
              <div class="benefit-card">
                <div class="benefit-icon">🛡️</div>
                <h4>收入稳定</h4>
                <p>月费模式提供可预测的现金流</p>
              </div>
              <div class="benefit-card">
                <div class="benefit-icon">⭐</div>
                <h4>用户粘性</h4>
                <p>会员用户留存率更高</p>
              </div>
              <div class="benefit-card">
                <div class="benefit-icon">💰</div>
                <h4>溢价收入</h4>
                <p>ARPU值显著提升</p>
              </div>
            </div>
          </div>
        </div>
        
        <div class="disclaimer">
          * 所有收入数据均为基于行业模型的估算，实际收益取决于运营情况与市场环境，不作为收入保证。
        </div>
      </div>
    </section>

    <!-- 风险保障 -->
    <section class="risk-guarantee section">
      <div class="container">
        <h2 class="section-title">
          🛡️ 您的风险极低，而我们已为您兜底
        </h2>
        <div class="guarantee-grid">
          <div class="guarantee-card">
            <div class="guarantee-icon">🚫</div>
            <h3>技术风险为零</h3>
            <p>成熟框架交付，无性能卡顿、上线失败之忧</p>
          </div>
          <div class="guarantee-card">
            <div class="guarantee-icon">📜</div>
            <h3>政策风险为零</h3>
            <p>严格遵守平台规则，确保合规稳定运营</p>
          </div>
          <div class="guarantee-card">
            <div class="guarantee-icon">💸</div>
            <h3>投入风险极低</h3>
            <p>远低于自建团队的成本，且1元即可启动进程</p>
          </div>
        </div>
      </div>
    </section>

    <!-- 目标客户 -->
    <section class="target-audience section">
      <div class="container">
        <h2 class="section-title">
          👥 适合谁？
        </h2>
        <div class="audience-grid">
          <div class="audience-card" v-for="(audience, index) in targetAudiences" :key="index">
            <div class="audience-icon">{{ audience.icon }}</div>
            <h3>{{ audience.title }}</h3>
            <p class="audience-desc">{{ audience.desc }}</p>
            <ul class="audience-features">
              <li v-for="(feature, fIndex) in audience.features" :key="fIndex">{{ feature }}</li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- 最终行动号召 -->
    <section class="final-cta section">
      <div class="container">
        <div class="cta-card">
          <h2 class="cta-title">立即行动，抢占下一个流量红利</h2>
          <p class="cta-text">
            我们不只是开发商，更是您的数字资产合伙人。我们的目标是：用最高效的方式，为您在微信生态内搭建一台自动化、可持续的"睡后收入"生成器。
          </p>
          
          <div class="cta-benefits">
            <h3>扫码添加顾问，支付1元预定金，解锁以下权益：</h3>
            <div class="benefits-grid">
              <div class="benefit">
                <span class="benefit-number">1</span>
                <p>1对1专属需求分析</p>
              </div>
              <div class="benefit">
                <span class="benefit-number">2</span>
                <p>获取为您定制的《项目规划与收益预估方案》</p>
              </div>
              <div class="benefit">
                <span class="benefit-number">3</span>
                <p>锁定当前开发排期，享受优先开发权</p>
              </div>
            </div>
          </div>
          
          <div class="cta-footnote">
            <p>
              <strong>注：</strong>1元为诚意排期预定费用，用于锁定项目席位与深度咨询服务，后续开发费用将在双方确认方案后另行商议。
            </p>
          </div>
          
          <button class="final-cta-button" @click="handleConsult">
            <span class="button-main">支付1元锁定名额</span>
            <span class="button-sub">仅剩{{ remainingSlots }}个名额</span>
          </button>
          
          <div class="urgency-message">
            <span class="urgency-icon">⏰</span>
            <span>本次优惠仅限前50名，已有{{ 50 - remainingSlots }}人加入</span>
          </div>
        </div>
      </div>
    </section>

    <!-- 咨询弹窗 -->
    <div class="consult-modal" v-if="showConsultModal" @click="closeModal">
      <div class="modal-content" @click.stop>
        <button class="modal-close" @click="closeModal">×</button>
        <h3 class="modal-title">1元锁定专属咨询名额</h3>
        <div class="modal-body">
          <p>请留下您的联系方式，顾问将在15分钟内与您联系</p>
          <div class="form-group">
            <input 
              type="text" 
              v-model="formData.name"
              placeholder="您的姓名"
              class="form-input"
            />
          </div>
          <div class="form-group">
            <input 
              type="tel" 
              v-model="formData.phone"
              placeholder="手机号码"
              class="form-input"
            />
          </div>
          <div class="form-group">
            <input 
              type="email" 
              v-model="formData.email"
              placeholder="电子邮箱（选填）"
              class="form-input"
            />
          </div>
          <div class="form-group">
            <textarea 
              v-model="formData.message"
              placeholder="您的需求或疑问（选填）"
              class="form-textarea"
              rows="3"
            ></textarea>
          </div>
          <button class="modal-submit" @click="submitConsult">
            确认提交，支付1元
          </button>
          <p class="modal-note">
            提交后，您将跳转至支付页面完成1元支付，即视为锁定咨询名额
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'

interface DeliveryStep {
  week: string
  title: string
  desc: string
  features: string[]
  note?: string
}

interface TargetAudience {
  icon: string
  title: string
  desc: string
  features: string[]
}

// 响应式数据
const remainingSlots = ref(23)
const showConsultModal = ref(false)
const formData = reactive({
  name: '',
  phone: '',
  email: '',
  message: ''
})

// 交付步骤数据
const deliverySteps: DeliveryStep[] = [
  {
    week: '1',
    title: '需求定制与敏捷启动',
    desc: '我们与您深度沟通，基于成熟的游戏玩法和盈利模型，为您量身定制：',
    features: [
      '玩法微调：定制主题（国潮、星空、萌宠等）、特殊元素（您的品牌元素可融入）',
      '变现设计：为您配置最优的广告位组合与潜在的订阅（会员）模式，最大化收益',
      '签订协议，启动项目'
    ]
  },
  {
    week: '2-3',
    title: '高效开发与集成',
    desc: '使用我们成熟的开发框架与素材库，极速推进。',
    features: [
      '核心交付：流畅的物理体验、直观的操作、完整的广告系统（激励视频+插屏+ Banner）已预先集成',
      '安全合规：确保符合微信平台规范，规避政策风险，一次过审'
    ],
    note: '您的参与：仅需在关键节点确认效果，无需操心技术细节。'
  },
  {
    week: '4',
    title: '测试、上线与冷启动',
    desc: '',
    features: [
      '专业测试：我们进行多机型性能调优，确保流畅不卡顿',
      '一键上架：我们代为提交至微信平台，直至成功审核发布',
      '启动支持：提供基础的社交分享裂变与视频号引流策略，助力获取首批用户'
    ]
  },
  {
    week: '5及以后',
    title: '交付与收益循环启动',
    desc: '',
    features: [
      '完整交付：您将获得游戏的全部管理后台与收益数据权限',
      '营收开始：游戏上线后，广告收益即开始每日自动产生',
      '可选托管：我们提供持续的迭代与运营服务（需另购），助您提升收入天花板'
    ]
  }
]

// 目标客户数据
const targetAudiences: TargetAudience[] = [
  {
    icon: '👨‍💼',
    title: '小微企业主',
    desc: '拥有线下业务，希望增加线上收入管道',
    features: ['不懂技术', '认可小程序价值', '寻求业务多元化']
  },
  {
    icon: '💼',
    title: '斜杠青年',
    desc: '寻求副业机会的上班族',
    features: ['工作繁忙', '想建被动收入', '怕试错成本高']
  },
  {
    icon: '📱',
    title: '私域流量主',
    desc: '拥有粉丝社群的创作者',
    features: ['有流量难变现', '需要互动工具', '寻求变现产品']
  },
  {
    icon: '📈',
    title: '理财投资者',
    desc: '关注稳健数字投资',
    features: ['寻求现金流项目', '厌恶复杂管理', '喜欢清晰模型']
  }
]

// 事件处理函数
const handleConsult = () => {
  showConsultModal.value = true
  // 模拟滚动锁定
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  showConsultModal.value = false
  document.body.style.overflow = ''
}

const submitConsult = async () => {
  if (!formData.name || !formData.phone) {
    alert('请填写姓名和手机号码')
    return
  }
  
  // 这里可以添加API调用
  try {
    // const response = await fetch('/api/consult', {
    //   method: 'POST',
    //   body: JSON.stringify(formData)
    // })
    
    // 模拟API调用
    console.log('提交咨询:', formData)
    
    // 模拟支付跳转
    alert('即将跳转支付页面...')
    // window.location.href = '/payment?amount=1'
    
    // 清空表单
    Object.keys(formData).forEach(key => {
      formData[key as keyof typeof formData] = ''
    })
    
    closeModal()
    remainingSlots.value -= 1
    
  } catch (error) {
    console.error('提交失败:', error)
    alert('提交失败，请稍后重试')
  }
}

// 生命周期钩子
onMounted(() => {
  // 可以添加一些初始化逻辑
  console.log('Landing page mounted')
})
</script>

<style scoped>
.landing-page {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  color: #333;
  line-height: 1.6;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.section {
  padding: 80px 0;
}

/* Hero Section */
.hero-section {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 100px 0;
  text-align: center;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 800;
  margin-bottom: 20px;
  line-height: 1.2;
}

.hero-title em {
  font-style: normal;
  color: #ffd700;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

.hero-subtitle {
  font-size: 1.5rem;
  margin-bottom: 40px;
  opacity: 0.9;
}

.highlight {
  background: linear-gradient(120deg, #f093fb 0%, #f5576c 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: bold;
}

.hero-cta {
  max-width: 600px;
  margin: 0 auto;
}

.pricing-tag {
  display: inline-flex;
  align-items: center;
  gap: 15px;
  background: rgba(255,255,255,0.1);
  padding: 15px 30px;
  border-radius: 50px;
  margin-bottom: 30px;
  backdrop-filter: blur(10px);
}

.original-price {
  text-decoration: line-through;
  opacity: 0.7;
}

.current-price {
  font-size: 1.8rem;
  color: #ffd700;
}

.cta-button {
  display: block;
  width: 100%;
  background: #ff6b6b;
  color: white;
  border: none;
  padding: 25px;
  font-size: 1.3rem;
  font-weight: bold;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-bottom: 15px;
  position: relative;
}

.cta-button:hover {
  background: #ff5252;
  transform: translateY(-2px);
  box-shadow: 0 10px 20px rgba(255,107,107,0.3);
}

.button-sub {
  display: block;
  font-size: 0.9rem;
  opacity: 0.9;
  margin-top: 5px;
}

.cta-note {
  font-size: 0.9rem;
  opacity: 0.8;
}

/* Value Proposition */
.value-proposition {
  background: #f8f9fa;
  padding: 60px 0;
}

.value-text {
  font-size: 1.2rem;
  max-width: 800px;
  margin: 0 auto;
  text-align: center;
  line-height: 1.8;
}

/* Pain Points */
.pain-points {
  background: white;
}

.section-title {
  font-size: 2.2rem;
  margin-bottom: 50px;
  text-align: center;
}

.warning {
  color: #ff6b6b;
}

.comparison-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 40px;
}

.bad-side, .good-side {
  padding: 30px;
  border-radius: 15px;
}

.bad-side {
  background: #fff5f5;
  border: 2px solid #ff6b6b;
}

.good-side {
  background: #f0fff4;
  border: 2px solid #38a169;
}

.point-list {
  list-style: none;
  padding: 0;
}

.point-list li {
  display: flex;
  gap: 15px;
  margin-bottom: 25px;
  padding: 15px;
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.point-list .icon {
  font-size: 1.5rem;
  flex-shrink: 0;
}

.danger-list .icon {
  color: #ff6b6b;
}

.solution-card {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(56, 161, 105, 0.1);
}

.solution-header {
  margin-bottom: 20px;
}

.tag {
  display: inline-block;
  background: #38a169;
  color: white;
  padding: 5px 15px;
  border-radius: 20px;
  font-size: 0.9rem;
  margin-bottom: 10px;
}

.highlight-box {
  background: linear-gradient(120deg, #a8edea 0%, #fed6e3 100%);
  padding: 20px;
  border-radius: 10px;
  margin-top: 20px;
  text-align: center;
}

.highlight-text {
  font-size: 1.1rem;
  font-weight: bold;
  color: #2d3748;
}

/* Delivery Blueprint */
.delivery-blueprint {
  background: #f8f9fa;
}

.timeline {
  position: relative;
  max-width: 800px;
  margin: 0 auto;
}

.timeline::before {
  content: '';
  position: absolute;
  left: 30px;
  top: 0;
  bottom: 0;
  width: 4px;
  background: linear-gradient(to bottom, #667eea, #764ba2);
}

.timeline-item {
  display: flex;
  margin-bottom: 50px;
  position: relative;
}

.timeline-marker {
  width: 60px;
  flex-shrink: 0;
  text-align: right;
  padding-right: 20px;
}

.step-number {
  background: #667eea;
  color: white;
  padding: 8px 12px;
  border-radius: 6px;
  font-size: 0.9rem;
  font-weight: bold;
  margin-bottom: 5px;
}

.step-week {
  font-size: 0.9rem;
  color: #666;
}

.timeline-content {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 5px 15px rgba(0,0,0,0.08);
  flex: 1;
  margin-left: 20px;
}

.timeline-content h3 {
  color: #2d3748;
  margin-bottom: 15px;
}

.feature-list {
  list-style: none;
  padding: 0;
  margin-top: 15px;
}

.feature-list li {
  padding: 8px 0;
  border-bottom: 1px solid #e2e8f0;
}

.timeline-note {
  background: #e6f7ff;
  padding: 15px;
  border-radius: 8px;
  margin-top: 20px;
  border-left: 4px solid #1890ff;
}

/* Revenue Model */
.revenue-model {
  background: white;
}

.revenue-cards {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 30px;
  margin-top: 50px;
}

.revenue-card {
  padding: 30px;
  border-radius: 15px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

.revenue-card:first-child {
  background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
  border: 2px solid #667eea;
}

.revenue-card:last-child {
  background: linear-gradient(135deg, #38a16915 0%, #2f855a15 100%);
  border: 2px solid #38a169;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

.revenue-tag {
  background: #667eea;
  color: white;
  padding: 5px 15px;
  border-radius: 20px;
  font-size: 0.9rem;
}

.revenue-tag.secondary {
  background: #38a169;
}

.ad-types {
  margin-bottom: 40px;
}

.ad-type {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 20px;
  background: white;
  border-radius: 10px;
  margin-bottom: 15px;
  border: 1px solid #e2e8f0;
}

.ad-icon {
  font-size: 2rem;
  flex-shrink: 0;
}

.revenue-simulation {
  background: white;
  padding: 25px;
  border-radius: 12px;
  border: 2px dashed #667eea;
}

.simulation-formula {
  margin-top: 20px;
}

.formula-line {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  flex-wrap: wrap;
  margin-bottom: 15px;
}

.formula-part {
  padding: 8px 15px;
  background: #f7fafc;
  border-radius: 6px;
}

.operator {
  font-size: 1.5rem;
  color: #667eea;
}

.formula-result {
  text-align: center;
  font-size: 1.2rem;
  margin: 10px 0;
}

.subscription-features {
  margin-bottom: 30px;
}

.subscription-item {
  display: flex;
  gap: 15px;
  margin-bottom: 20px;
  align-items: flex-start;
}

.check-icon {
  color: #38a169;
  font-size: 1.2rem;
  flex-shrink: 0;
}

.subscription-benefits {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
  margin-top: 30px;
}

.benefit-card {
  text-align: center;
  padding: 20px;
  background: white;
  border-radius: 10px;
  border: 1px solid #e2e8f0;
}

.benefit-icon {
  font-size: 2rem;
  margin-bottom: 15px;
}

.disclaimer {
  margin-top: 50px;
  text-align: center;
  color: #718096;
  font-size: 0.9rem;
  padding: 20px;
  background: #f7fafc;
  border-radius: 10px;
}

/* Risk Guarantee */
.risk-guarantee {
  background: #f8f9fa;
}

.guarantee-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 30px;
  max-width: 900px;
  margin: 0 auto;
}

.guarantee-card {
  text-align: center;
  padding: 40px 20px;
  background: white;
  border-radius: 15px;
  box-shadow: 0 5px 15px rgba(0,0,0,0.05);
}

.guarantee-icon {
  font-size: 3rem;
  margin-bottom: 20px;
}

/* Target Audience */
.target-audience {
  background: white;
}

.audience-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 30px;
}

.audience-card {
  text-align: center;
  padding: 30px 20px;
  border-radius: 12px;
  border: 2px solid #e2e8f0;
  transition: all 0.3s ease;
}

.audience-card:hover {
  border-color: #667eea;
  transform: translateY(-5px);
}

.audience-icon {
  font-size: 3rem;
  margin-bottom: 20px;
}

.audience-desc {
  color: #718096;
  margin: 15px 0;
  font-size: 0.9rem;
}

.audience-features {
  list-style: none;
  padding: 0;
  margin-top: 20px;
}

.audience-features li {
  padding: 8px 0;
  border-top: 1px solid #e2e8f0;
  font-size: 0.9rem;
  color: #4a5568;
}

/* Final CTA */
.final-cta {
  background: linear-gradient(135deg, #1a202c 0%, #2d3748 100%);
  color: white;
}

.cta-card {
  max-width: 800px;
  margin: 0 auto;
  background: rgba(255,255,255,0.05);
  padding: 60px;
  border-radius: 20px;
  backdrop-filter: blur(10px);
  text-align: center;
}

.cta-title {
  font-size: 2.5rem;
  margin-bottom: 20px;
  background: linear-gradient(120deg, #a8edea 0%, #fed6e3 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.cta-text {
  font-size: 1.2rem;
  opacity: 0.9;
  margin-bottom: 40px;
}

.cta-benefits {
  text-align: left;
  background: rgba(255,255,255,0.1);
  padding: 30px;
  border-radius: 15px;
  margin-bottom: 30px;
}

.benefits-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 30px;
  margin-top: 30px;
}

.benefit {
  display: flex;
  gap: 15px;
  align-items: flex-start;
}

.benefit-number {
  width: 40px;
  height: 40px;
  background: #667eea;
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  font-weight: bold;
}

.cta-footnote {
  margin: 30px 0;
  padding: 20px;
  background: rgba(255,255,255,0.1);
  border-radius: 10px;
  text-align: left;
}

.final-cta-button {
  display: block;
  width: 100%;
  background: linear-gradient(120deg, #f093fb 0%, #f5576c 100%);
  color: white;
  border: none;
  padding: 25px;
  font-size: 1.5rem;
  font-weight: bold;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-bottom: 20px;
}

.final-cta-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 30px rgba(245, 87, 108, 0.4);
}

.urgency-message {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  background: rgba(255, 107, 107, 0.2);
  padding: 15px 30px;
  border-radius: 50px;
}

.urgency-icon {
  animation: pulse 2s infinite;
}

/* Modal */
.consult-modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.8);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  backdrop-filter: blur(5px);
}

.modal-content {
  background: white;
  width: 90%;
  max-width: 500px;
  border-radius: 20px;
  padding: 40px;
  position: relative;
  animation: slideIn 0.3s ease;
}

.modal-close {
  position: absolute;
  top: 15px;
  right: 20px;
  font-size: 2rem;
  background: none;
  border: none;
  cursor: pointer;
  color: #718096;
}

.modal-title {
  font-size: 1.8rem;
  margin-bottom: 20px;
  text-align: center;
  color: #2d3748;
}

.form-group {
  margin-bottom: 20px;
}

.form-input, .form-textarea {
  width: 100%;
  padding: 15px;
  border: 2px solid #e2e8f0;
  border-radius: 10px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
}

.form-input:focus, .form-textarea:focus {
  outline: none;
  border-color: #667eea;
}

.form-textarea {
  resize: vertical;
}

.modal-submit {
  width: 100%;
  background: linear-gradient(120deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  padding: 20px;
  font-size: 1.2rem;
  font-weight: bold;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-top: 20px;
}

.modal-submit:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
}

.modal-note {
  text-align: center;
  color: #718096;
  font-size: 0.9rem;
  margin-top: 20px;
}

/* Animations */
@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(-50px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Responsive Design */
@media (max-width: 1024px) {
  .hero-title {
    font-size: 2.8rem;
  }
  
  .revenue-cards,
  .guarantee-grid,
  .audience-grid,
  .benefits-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .comparison-grid {
    grid-template-columns: 1fr;
  }
  
  .section {
    padding: 50px 0;
  }
  
  .hero-section {
    padding: 60px 0;
  }
  
  .hero-title {
    font-size: 2.2rem;
  }
  
  .section-title {
    font-size: 1.8rem;
  }
  
  .timeline::before {
    left: 20px;
  }
  
  .timeline-marker {
    width: 40px;
  }
  
  .subscription-benefits {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 480px) {
  .container {
    padding: 0 15px;
  }
  
  .hero-title {
    font-size: 1.8rem;
  }
  
  .pricing-tag {
    flex-direction: column;
    gap: 10px;
  }
  
  .modal-content {
    padding: 30px 20px;
  }
}
</style>