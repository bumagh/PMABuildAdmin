<template>
  <div class="subscription-page">
    <!-- 导航栏 -->
    <nav class="navbar">
      <div class="container nav-container">
        <div class="logo">
          <div class="logo-icon"></div>
          <span>谁是珠王</span>
        </div>
        <div class="nav-links">
          <a href="#overview" @click.prevent="scrollToSection('overview')">订阅总览</a>
          <a href="#tiers" @click.prevent="scrollToSection('tiers')">订阅阶梯</a>
          <a href="#faq" @click.prevent="scrollToSection('faq')">常见问题</a>
          <a href="#cta" @click.prevent="scrollToSection('cta')">立即加入</a>
        </div>
      </div>
    </nav>

    <!-- 主视觉区 -->
    <section class="hero">
      <div class="container">
        <h1 class="hero-title">不止于玩家，成为「创世元老」</h1>
        <p class="hero-subtitle">
          解锁独家开发幕后、影响游戏走向、珍藏绝版资产。这是一张通往游戏灵魂的VIP通行证。
        </p>
        <button class="cta-button" @click="openSubscriptionModal('弹珠学徒', 18)">
          <i class="fas fa-crown"></i> 立即订阅，加入创世议会
        </button>
      </div>
    </section>

    <!-- 订阅总览 -->
    <section class="overview" id="overview" ref="overviewSection">
      <div class="container">
        <h2 class="section-title">三个圈层，一种身份</h2>
        <p class="overview-text">
          我们推出阶梯式「频道订阅」服务。订阅期内，您将定期获得<strong>无法用常规方式获取</strong>的独家数字内容、开发物资与专属特权。所有订阅者将获得
          <span class="highlight-gold">"创世议会"</span> 社区永久身份。
        </p>

        <div class="highlight-box">
          <div class="highlight-title">
            <i class="fas fa-exclamation-circle"></i>
            重要提示
          </div>
          <p><strong>订阅周期：</strong>按月订阅，随时可取消。但<strong>绝版内容仅在订阅期内发放</strong>，错过不补。</p>
          <p><strong>内容交付：</strong>所有数字内容将通过 <strong>专属私密微信社群 + 加密网盘</strong> 定期推送。</p>
          <p>
            <strong>预售目标：</strong>总订阅人数将直接决定<strong>游戏首发版本的额外内容规模</strong>（如新增主题战场、Boss数量）。
          </p>
        </div>
      </div>
    </section>

    <!-- 订阅阶梯 -->
    <section class="tiers" id="tiers" ref="tiersSection">
      <div class="container">
        <h2 class="section-title">订阅阶梯详情</h2>

        <div class="tiers-container">
          <!-- 第一阶 -->
          <div class="tier-card">
            <div class="tier-header">
              <h3 class="tier-name">弹珠学徒</h3>
              <div class="tier-price">18<span>元/月</span></div>
              <p class="tier-desc">体验派支持者，获得内部测试资格与基础福利。</p>
            </div>

            <div class="tier-features">
              <div class="tier-feature">
                <i class="fas fa-check-circle"></i>
                <div><strong>游戏Demo优先访问权：</strong>比公众提前 1-2个月 体验开发中版本。</div>
              </div>
              <div class="tier-feature">
                <i class="fas fa-check-circle"></i>
                <div><strong>月度更新礼包：</strong>开发中原画/设定图、BGM抢先试听、设定集片段。</div>
              </div>
              <div class="tier-feature">
                <i class="fas fa-check-circle"></i>
                <div><strong>游戏内福利：</strong>"先行者"限定称号、专属头像框、每月300钻石。</div>
              </div>
            </div>

            <button class="tier-button" @click="openSubscriptionModal('弹珠学徒', 18)">选择此计划</button>
          </div>

          <!-- 第二阶 -->
          <div class="tier-card featured">
            <div class="tier-badge">最受欢迎</div>
            <div class="tier-header">
              <h3 class="tier-name">艺术参赞</h3>
              <div class="tier-price">58<span>元/月</span></div>
              <p class="tier-desc">鉴赏家与收藏者，深入创作腹地，获取高价值数字资产。</p>
            </div>

            <div class="tier-features">
              <div class="tier-feature">
                <i class="fas fa-check-circle"></i>
                <div><strong>包含「弹珠学徒」全部权益</strong></div>
              </div>
              <div class="tier-feature">
                <i class="fas fa-check-circle"></i>
                <div><strong>独家数字藏品：</strong>高清无水印原画、概念设计稿、动态壁纸、矢量素材包。</div>
              </div>
              <div class="tier-feature">
                <i class="fas fa-check-circle"></i>
                <div><strong>完整游戏原声OST：</strong>每季度更新一张高品质数字专辑。</div>
              </div>
              <div class="tier-feature">
                <i class="fas fa-check-circle"></i>
                <div><strong>「创世收藏家」系列弹珠皮肤：</strong>仅限此阶获取，每两月发放一款。</div>
              </div>
            </div>

            <button class="tier-button featured" @click="openSubscriptionModal('艺术参赞', 58)">
              选择此计划
            </button>
          </div>

          <!-- 第三阶 -->
          <div class="tier-card">
            <div class="tier-header">
              <h3 class="tier-name">首席赞助官</h3>
              <div class="tier-price">158<span>元/月</span></div>
              <p class="tier-desc">游戏共创伙伴，获得冠名级荣誉与决策影响力。</p>
            </div>

            <div class="tier-features">
              <div class="tier-feature">
                <i class="fas fa-check-circle"></i>
                <div><strong>包含「艺术参赞」全部权益</strong></div>
              </div>
              <div class="tier-feature">
                <i class="fas fa-check-circle"></i>
                <div><strong>永恒留名：</strong>名字刻录在游戏启动画面的「特别鸣谢」独立铭牌中。</div>
              </div>
              <div class="tier-feature">
                <i class="fas fa-check-circle"></i>
                <div><strong>决策影响力：</strong>参与季度「策划面对面」会议，投票决定新内容方向。</div>
              </div>
              <div class="tier-feature">
                <i class="fas fa-check-circle"></i>
                <div><strong>命名权：</strong>每年一次为新弹珠皮肤或新战场提交命名建议。</div>
              </div>
            </div>

            <button class="tier-button" @click="openSubscriptionModal('首席赞助官', 158)">
              选择此计划
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- 常见问题 -->
    <section class="faq" id="faq" ref="faqSection">
      <div class="container">
        <h2 class="section-title">订阅常见问题</h2>

        <div class="faq-container">
          <div
            v-for="(item, index) in faqItems"
            :key="index"
            class="faq-item"
            :class="{ active: activeFaqIndex === index }"
          >
            <div class="faq-question" @click="toggleFaq(index)">
              {{ item.question }}
              <span class="faq-toggle">{{ activeFaqIndex === index ? '−' : '+' }}</span>
            </div>
            <div class="faq-answer">
              <p v-html="item.answer"></p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 最终召唤区 -->
    <section class="final-cta" id="cta" ref="ctaSection">
      <div class="container">
        <h2 class="section-title">为什么值得订阅？</h2>

        <div class="quote-box">
          您不是在购买一个商品，而是在<strong>资助并参与一场创造</strong>。<br /><br />
          • <strong>见证生长</strong>：从线稿到动画，从旋律到史诗，您将看到一切如何从无到有。<br />
          • <strong>塑造历史</strong>：您的反馈可能直接改变某个弹珠的轨迹，或是一个战场的样貌。<br />
          • <strong>收藏时光</strong>：这些数字资产，是您与《谁是珠王》共同记忆的独一无二的琥珀。
        </div>

        <div class="quote-box" style="border-left-color: var(--accent-gold)">
          <strong
            >2026年2月，当所有玩家涌入赛场时，只有您，能指着某处设计、某个名字、或一种玩法，自豪地说：</strong
          ><br /><br />
          <span class="highlight-gold">"嘿，这个点子，有我的一份。"</span><br /><br />
          加入创世议会，让我们共同拧紧发条，为这个世界注入第一次旋转的动力。
        </div>

        <button class="cta-button" @click="openSubscriptionModal('艺术参赞', 58)">
          <i class="fas fa-rocket"></i> 立即选择您的席位，开启共创之旅
        </button>
      </div>
    </section>

    <!-- 页脚 -->
    <footer>
      <div class="container">
        <p>《谁是珠王》「创世议会」订阅计划 | 通往游戏灵魂的VIP通行证</p>
        <p class="footer-copyright">Copyright © 2023-2026 谁是珠王开发团队. 所有权利保留.</p>
      </div>
    </footer>

    <!-- 订阅弹窗 -->
    <div class="modal-overlay" :class="{ active: showSubscriptionModal }" @click="closeModalOnOverlay">
      <div class="modal">
        <div class="modal-header">
          <h3 class="modal-title">加入创世议会</h3>
          <button class="modal-close" @click="closeSubscriptionModal">&times;</button>
        </div>

        <div class="modal-tier-info">
          <div class="modal-tier-name">{{ selectedSubscription.name }}</div>
          <div class="modal-tier-price">{{ selectedSubscription.price }}<span>元/月</span></div>
          <p>按月订阅，随时可取消。绝版内容仅在订阅期内发放。</p>
        </div>

        <form @submit.prevent="handleSubscriptionSubmit">
          <div class="form-group">
            <label class="form-label" for="user-name">姓名 / 昵称</label>
            <input
              v-model="subscriptionForm.name"
              type="text"
              id="user-name"
              class="form-input"
              placeholder="用于社区身份标识"
              required
            />
          </div>

          <div class="form-group">
            <label class="form-label" for="user-contact">联系方式</label>
            <input
              v-model="subscriptionForm.contact"
              type="text"
              id="user-contact"
              class="form-input"
              placeholder="微信号 / 手机号 / 邮箱"
              required
            />
          </div>

          <div class="form-group">
            <label class="form-label" for="payment-method">支付方式</label>
            <select
              v-model="subscriptionForm.paymentMethod"
              id="payment-method"
              class="form-input"
              required
            >
              <option value="">请选择支付方式</option>
              <option value="wechat">微信支付</option>
              <option value="alipay">支付宝</option>
            </select>
          </div>

          <div class="modal-actions">
            <button type="button" class="modal-btn modal-btn-secondary" @click="closeSubscriptionModal">
              取消
            </button>
            <button type="submit" class="modal-btn modal-btn-primary" :disabled="isSubmitting">
              {{ isSubmitting ? '处理中...' : '确认订阅并支付' }}
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- 支付成功提示 -->
    <div class="success-message" :class="{ active: showSuccessMessage }" id="success-message">
      <div class="success-header">
        <i class="fas fa-check-circle"></i>
        <strong>订阅成功！</strong>
      </div>
      <p>
        感谢您加入「创世议会」！我们的客服将在24小时内通过您提供的联系方式与您联系，邀请您进入专属社群。
      </p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, onUnmounted } from 'vue'

// 类型定义
interface SubscriptionTier {
  name: string
  price: number
}

interface SubscriptionForm {
  name: string
  contact: string
  paymentMethod: string
}

interface FAQItem {
  question: string
  answer: string
}

// 响应式数据
const showSubscriptionModal = ref(false)
const showSuccessMessage = ref(false)
const activeFaqIndex = ref<number | null>(null)
const isSubmitting = ref(false)

const selectedSubscription = reactive<SubscriptionTier>({
  name: '弹珠学徒',
  price: 18
})

const subscriptionForm = reactive<SubscriptionForm>({
  name: '',
  contact: '',
  paymentMethod: ''
})

const faqItems = ref<FAQItem[]>([
  {
    question: '订阅后如何获取内容？',
    answer:
      '支付成功后，系统将引导您加入对应的<strong>专属微信社群</strong>。所有更新、资料链接、Demo下载码均在群内以公告形式发布。同时会绑定一个加密云盘，用于存放大型文件。'
  },
  {
    question: 'Demo可以一直玩吗？',
    answer:
      'Demo为阶段性测试版本，有固定的测试开放期（通常为2周）。测试结束后服务器关闭，但安装包您可以保留。'
  },
  {
    question: '取消订阅后，已获得的内容会消失吗？',
    answer:
      '<strong>数字文件（原画、音乐、设定集）一旦发送，永久属于您</strong>。游戏内的虚拟物品（皮肤、称号）也会永久保留。但取消后将无法接收后续更新，并失去社群身份和访问权限。'
  },
  {
    question: '游戏上线后，这个订阅会怎样？',
    answer:
      '游戏正式上线后，「创世议会」订阅计划将<strong>停止新用户加入</strong>。但对老订阅者，我们将转型为一个持续的 <strong>"幕后内容更新"频道</strong>，继续提供开发幕后、扩展包前瞻等内容，订阅费可能会调整，但老用户享原价续订权。'
  }
])

// DOM 引用
const overviewSection = ref<HTMLElement | null>(null)
const tiersSection = ref<HTMLElement | null>(null)
const faqSection = ref<HTMLElement | null>(null)
const ctaSection = ref<HTMLElement | null>(null)

// 方法
const openSubscriptionModal = (name: string, price: number) => {
  selectedSubscription.name = name
  selectedSubscription.price = price
  showSubscriptionModal.value = true
  document.body.style.overflow = 'hidden'
}

const closeSubscriptionModal = () => {
  showSubscriptionModal.value = false
  document.body.style.overflow = 'auto'
  resetSubscriptionForm()
}

const closeModalOnOverlay = (event: MouseEvent) => {
  if ((event.target as HTMLElement).classList.contains('modal-overlay')) {
    closeSubscriptionModal()
  }
}

const resetSubscriptionForm = () => {
  subscriptionForm.name = ''
  subscriptionForm.contact = ''
  subscriptionForm.paymentMethod = ''
}

const handleSubscriptionSubmit = async () => {
  // 表单验证
  if (!subscriptionForm.name || !subscriptionForm.contact || !subscriptionForm.paymentMethod) {
    alert('请填写所有必填字段')
    return
  }

  isSubmitting.value = true

  try {
    // 模拟 API 调用
    await new Promise(resolve => setTimeout(resolve, 1500))

    // 在实际应用中，这里应该发送数据到服务器并进行支付处理
    console.log('订阅信息:', {
      tier: selectedSubscription,
      form: { ...subscriptionForm }
    })

    // 显示成功消息
    showSuccessMessage.value = true
    closeSubscriptionModal()

    // 5秒后隐藏成功消息
    setTimeout(() => {
      showSuccessMessage.value = false
    }, 5000)
  } catch (error) {
    console.error('订阅失败:', error)
    alert('订阅失败，请稍后再试')
  } finally {
    isSubmitting.value = false
  }
}

const toggleFaq = (index: number) => {
  activeFaqIndex.value = activeFaqIndex.value === index ? null : index
}

const scrollToSection = (sectionId: string) => {
  const sections: Record<string, any> = {
    overview: overviewSection,
    tiers: tiersSection,
    faq: faqSection,
    cta: ctaSection
  }

  const section = sections[sectionId]
  if (section?.value) {
    section.value.scrollIntoView({ behavior: 'smooth', block: 'start' })
  }
}

// 监听滚动，更新导航栏高亮
const handleScroll = () => {
  // 这里可以添加滚动监听逻辑
}

// 生命周期钩子
onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped>
/* 变量定义 */
:root {
  --primary-blue: #00b4ff;
  --neon-cyan: #00f3ff;
  --neon-purple: #bc13fe;
  --accent-gold: #ffd700;
  --dark-bg: #0a0a15;
  --card-bg: rgba(20, 25, 40, 0.9);
  --text-light: #f0f8ff;
  --text-dim: #a0c8ff;
  --success-green: #00ff88;
}

/* 全局样式 */
.subscription-page {
  font-family: 'Exo 2', sans-serif;
  background-color: var(--dark-bg);
  color: var(--text-light);
  line-height: 1.6;
  overflow-x: hidden;
  background-image: radial-gradient(circle at 20% 30%, rgba(0, 180, 255, 0.05) 0%, transparent 20%),
    radial-gradient(circle at 80% 70%, rgba(188, 19, 254, 0.05) 0%, transparent 20%);
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.highlight-gold {
  color: var(--accent-gold);
}

/* 导航栏 */
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background: rgba(10, 10, 21, 0.95);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(0, 180, 255, 0.2);
  z-index: 1000;
  padding: 15px 0;
}

.nav-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  display: flex;
  align-items: center;
  gap: 12px;
  font-family: 'Orbitron', sans-serif;
  font-weight: 700;
  font-size: 1.5rem;
  color: var(--text-light);
}

.logo-icon {
  width: 40px;
  height: 40px;
  background: linear-gradient(135deg, var(--primary-blue), var(--neon-purple));
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
}

.logo-icon::after {
  content: '';
  position: absolute;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  background: white;
  box-shadow: 0 0 15px white;
  animation: float 4s ease-in-out infinite;
}

@keyframes float {
  0%,
  100% {
    transform: translateY(0) translateX(0);
  }
  50% {
    transform: translateY(-10px) translateX(5px);
  }
}

.nav-links {
  display: flex;
  gap: 30px;
}

.nav-links a {
  color: var(--text-dim);
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s ease;
  position: relative;
}

.nav-links a:hover {
  color: var(--primary-blue);
}

.nav-links a::after {
  content: '';
  position: absolute;
  bottom: -5px;
  left: 0;
  width: 0;
  height: 2px;
  background: var(--primary-blue);
  transition: width 0.3s ease;
}

.nav-links a:hover::after {
  width: 100%;
}

/* 英雄区域 */
.hero {
  padding: 180px 0 100px;
  text-align: center;
  position: relative;
  overflow: hidden;
}

.hero::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: radial-gradient(ellipse at center, rgba(0, 180, 255, 0.1) 0%, transparent 70%);
  z-index: -1;
}

.hero-title {
  font-family: 'Orbitron', sans-serif;
  font-size: 3.5rem;
  font-weight: 900;
  margin-bottom: 20px;
  background: linear-gradient(90deg, var(--primary-blue), var(--neon-cyan));
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  text-shadow: 0 0 30px rgba(0, 180, 255, 0.3);
}

.hero-subtitle {
  font-size: 1.4rem;
  color: var(--text-dim);
  max-width: 800px;
  margin: 0 auto 40px;
}

.cta-button {
  display: inline-block;
  background: linear-gradient(90deg, var(--primary-blue), var(--neon-purple));
  color: white;
  padding: 18px 45px;
  border-radius: 50px;
  font-family: 'Orbitron', sans-serif;
  font-weight: 700;
  font-size: 1.3rem;
  text-decoration: none;
  text-transform: uppercase;
  letter-spacing: 1px;
  box-shadow: 0 10px 30px rgba(0, 180, 255, 0.3);
  transition: all 0.3s ease;
  border: none;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.cta-button:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 40px rgba(0, 180, 255, 0.5);
}

.cta-button::after {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.7s ease;
}

.cta-button:hover::after {
  left: 100%;
}

.cta-button:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

/* 订阅总览 */
.section-title {
  font-family: 'Orbitron', sans-serif;
  font-size: 2.5rem;
  text-align: center;
  margin-bottom: 20px;
  position: relative;
  display: inline-block;
  left: 50%;
  transform: translateX(-50%);
}

.section-title::after {
  content: '';
  position: absolute;
  bottom: -10px;
  left: 0;
  width: 100%;
  height: 3px;
  background: linear-gradient(90deg, transparent, var(--primary-blue), transparent);
}

.overview {
  padding: 80px 0;
}

.overview-text {
  text-align: center;
  max-width: 800px;
  margin: 0 auto 50px;
  color: var(--text-dim);
  font-size: 1.1rem;
}

.highlight-box {
  background: var(--card-bg);
  border: 1px solid rgba(0, 180, 255, 0.2);
  border-radius: 15px;
  padding: 30px;
  margin-bottom: 30px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
}

.highlight-title {
  color: var(--accent-gold);
  font-family: 'Orbitron', sans-serif;
  font-size: 1.3rem;
  margin-bottom: 15px;
  display: flex;
  align-items: center;
  gap: 10px;
}

/* 订阅阶梯 */
.tiers {
  padding: 80px 0;
  background: rgba(10, 15, 25, 0.5);
  border-radius: 20px;
  margin: 40px 0;
}

.tiers-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 30px;
  margin-top: 50px;
}

.tier-card {
  background: var(--card-bg);
  border-radius: 15px;
  overflow: hidden;
  flex: 1;
  min-width: 300px;
  max-width: 350px;
  border: 1px solid rgba(0, 180, 255, 0.1);
  transition: all 0.3s ease;
  position: relative;
}

.tier-card:hover {
  transform: translateY(-10px);
  border-color: var(--primary-blue);
  box-shadow: 0 15px 40px rgba(0, 180, 255, 0.2);
}

.tier-card.featured {
  border: 2px solid var(--accent-gold);
  transform: scale(1.05);
}

.tier-card.featured:hover {
  transform: scale(1.05) translateY(-10px);
}

.tier-badge {
  position: absolute;
  top: 20px;
  right: -30px;
  background: var(--accent-gold);
  color: #000;
  font-weight: 700;
  padding: 5px 30px;
  transform: rotate(45deg);
  font-size: 0.8rem;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
}

.tier-header {
  padding: 30px 25px;
  border-bottom: 1px solid rgba(0, 180, 255, 0.1);
}

.tier-name {
  font-family: 'Orbitron', sans-serif;
  font-size: 1.8rem;
  margin-bottom: 10px;
}

.tier-price {
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--primary-blue);
  margin-bottom: 5px;
}

.tier-price span {
  font-size: 1rem;
  color: var(--text-dim);
}

.tier-desc {
  color: var(--text-dim);
  font-size: 0.95rem;
}

.tier-features {
  padding: 25px;
}

.tier-feature {
  margin-bottom: 15px;
  display: flex;
  align-items: flex-start;
  gap: 10px;
}

.tier-feature i {
  color: var(--success-green);
  margin-top: 3px;
}

.tier-button {
  display: block;
  width: calc(100% - 50px);
  text-align: center;
  background: linear-gradient(90deg, var(--primary-blue), var(--neon-cyan));
  color: white;
  padding: 15px;
  border-radius: 10px;
  text-decoration: none;
  font-weight: 700;
  margin: 20px 25px 25px;
  transition: all 0.3s ease;
  border: none;
  cursor: pointer;
}

.tier-button:hover {
  background: linear-gradient(90deg, var(--neon-cyan), var(--primary-blue));
  box-shadow: 0 5px 20px rgba(0, 180, 255, 0.4);
}

.tier-button.featured {
  background: linear-gradient(90deg, var(--accent-gold), #ffaa00);
  color: #000;
}

.tier-button.featured:hover {
  background: linear-gradient(90deg, #ffaa00, var(--accent-gold));
}

/* FAQ */
.faq {
  padding: 80px 0;
}

.faq-container {
  max-width: 800px;
  margin: 50px auto 0;
}

.faq-item {
  margin-bottom: 20px;
  border-bottom: 1px solid rgba(0, 180, 255, 0.1);
  padding-bottom: 20px;
}

.faq-question {
  font-size: 1.2rem;
  font-weight: 600;
  margin-bottom: 10px;
  color: var(--text-light);
  cursor: pointer;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.faq-toggle {
  font-size: 1.5rem;
  color: var(--primary-blue);
  transition: transform 0.3s ease;
}

.faq-item.active .faq-question .faq-toggle {
  transform: rotate(45deg);
}

.faq-answer {
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.3s ease;
  color: var(--text-dim);
}

.faq-item.active .faq-answer {
  max-height: 500px;
}

/* 最终召唤 */
.final-cta {
  padding: 100px 0;
  text-align: center;
  background: radial-gradient(ellipse at center, rgba(0, 20, 40, 0.8) 0%, transparent 70%);
  position: relative;
}

.quote-box {
  max-width: 800px;
  margin: 0 auto 50px;
  padding: 40px;
  background: rgba(0, 30, 60, 0.5);
  border-radius: 15px;
  border-left: 5px solid var(--primary-blue);
  font-style: italic;
  font-size: 1.2rem;
  color: var(--text-dim);
  position: relative;
}

.quote-box::before {
  content: '“';
  position: absolute;
  top: -20px;
  left: 20px;
  font-size: 4rem;
  color: var(--primary-blue);
  font-family: serif;
}

/* 页脚 */
footer {
  padding: 40px 0;
  text-align: center;
  border-top: 1px solid rgba(0, 180, 255, 0.1);
  color: var(--text-dim);
  font-size: 0.9rem;
}

.footer-copyright {
  margin-top: 10px;
  font-size: 0.8rem;
  opacity: 0.7;
}

/* 订阅弹窗 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.8);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2000;
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
}

.modal-overlay.active {
  opacity: 1;
  visibility: visible;
}

.modal {
  background: var(--dark-bg);
  border-radius: 15px;
  width: 90%;
  max-width: 500px;
  padding: 30px;
  border: 1px solid rgba(0, 180, 255, 0.3);
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
  transform: translateY(30px);
  transition: transform 0.3s ease;
}

.modal-overlay.active .modal {
  transform: translateY(0);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 1px solid rgba(0, 180, 255, 0.2);
}

.modal-title {
  font-family: 'Orbitron', sans-serif;
  font-size: 1.5rem;
  color: var(--primary-blue);
}

.modal-close {
  background: none;
  border: none;
  color: var(--text-dim);
  font-size: 1.5rem;
  cursor: pointer;
  transition: color 0.3s ease;
}

.modal-close:hover {
  color: var(--primary-blue);
}

.modal-tier-info {
  background: rgba(0, 30, 60, 0.5);
  border-radius: 10px;
  padding: 20px;
  margin-bottom: 25px;
}

.modal-tier-name {
  font-size: 1.3rem;
  font-weight: 700;
  margin-bottom: 5px;
}

.modal-tier-price {
  font-size: 2rem;
  color: var(--primary-blue);
  font-weight: 700;
  margin-bottom: 15px;
}

.modal-tier-price span {
  font-size: 1rem;
  color: var(--text-dim);
}

.form-group {
  margin-bottom: 20px;
}

.form-label {
  display: block;
  margin-bottom: 8px;
  color: var(--text-dim);
}

.form-input {
  width: 100%;
  padding: 12px 15px;
  background: rgba(0, 20, 40, 0.5);
  border: 1px solid rgba(0, 180, 255, 0.3);
  border-radius: 8px;
  color: white;
  font-size: 1rem;
  transition: border-color 0.3s ease;
}

.form-input:focus {
  outline: none;
  border-color: var(--primary-blue);
}

select.form-input {
  appearance: none;
  background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2300b4ff' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
  background-repeat: no-repeat;
  background-position: right 15px center;
  background-size: 16px;
  padding-right: 45px;
}

.modal-actions {
  display: flex;
  gap: 15px;
  margin-top: 30px;
}

.modal-btn {
  flex: 1;
  padding: 15px;
  border-radius: 8px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
  border: none;
}

.modal-btn-primary {
  background: linear-gradient(90deg, var(--primary-blue), var(--neon-cyan));
  color: white;
}

.modal-btn-secondary {
  background: rgba(255, 255, 255, 0.1);
  color: var(--text-light);
}

.modal-btn:hover:not(:disabled) {
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

.modal-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

/* 支付成功提示 */
.success-message {
  position: fixed;
  top: 100px;
  right: 20px;
  background: rgba(0, 255, 136, 0.1);
  border: 1px solid var(--success-green);
  color: var(--success-green);
  padding: 20px;
  border-radius: 10px;
  z-index: 3000;
  transform: translateX(150%);
  transition: transform 0.5s ease;
  max-width: 350px;
}

.success-message.active {
  transform: translateX(0);
}

.success-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 10px;
}

.success-header i {
  font-size: 1.5rem;
}

.success-header strong {
  font-size: 1.1rem;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }

  .hero-subtitle {
    font-size: 1.1rem;
  }

  .section-title {
    font-size: 2rem;
  }

  .nav-links {
    display: none;
  }

  .tier-card.featured {
    transform: none;
  }

  .tier-card.featured:hover {
    transform: translateY(-10px);
  }

  .tiers-container {
    flex-direction: column;
    align-items: center;
  }

  .tier-card {
    max-width: 100%;
  }

  .quote-box {
    padding: 25px 20px;
    font-size: 1rem;
  }

  .modal {
    padding: 20px;
  }
}

@media (max-width: 480px) {
  .hero-title {
    font-size: 2rem;
  }

  .cta-button {
    padding: 15px 30px;
    font-size: 1.1rem;
  }

  .tier-price {
    font-size: 2rem;
  }

  .modal-actions {
    flex-direction: column;
  }
}
</style>