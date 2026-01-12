<template>
  <div class="petto-landing-page">
    <!-- 导航栏 -->
    <nav class="petto-nav">
      <div class="nav-container">
        <div class="nav-logo">
          <span class="logo-text">宠物安心上门</span>
          <span class="logo-sub">Petto</span>
        </div>
        <div class="nav-links">
          <a href="#services" class="nav-link">服务项目</a>
          <a href="#early-bird" class="nav-link">1元锁定</a>
          <a href="#features" class="nav-link">核心优势</a>
          <a href="#testimonials" class="nav-link">用户评价</a>
          <a href="#pricing" class="nav-link">价格方案</a>
          <button class="nav-cta" @click="scrollToEarlyBird">立即锁定</button>
        </div>
        <button class="nav-mobile-toggle" @click="toggleMobileMenu">
          <span :class="['hamburger-line', { 'line-1-active': mobileMenuOpen }]"></span>
          <span :class="['hamburger-line', { 'line-2-active': mobileMenuOpen }]"></span>
          <span :class="['hamburger-line', { 'line-3-active': mobileMenuOpen }]"></span>
        </button>
      </div>
      
      <!-- 移动端菜单 -->
      <div v-if="mobileMenuOpen" class="mobile-menu">
        <a href="#services" class="mobile-link" @click="closeMobileMenu">服务项目</a>
        <a href="#early-bird" class="mobile-link" @click="closeMobileMenu">1元锁定</a>
        <a href="#features" class="mobile-link" @click="closeMobileMenu">核心优势</a>
        <a href="#testimonials" class="mobile-link" @click="closeMobileMenu">用户评价</a>
        <a href="#pricing" class="mobile-link" @click="closeMobileMenu">价格方案</a>
        <button class="mobile-cta" @click="scrollToEarlyBird">立即锁定</button>
      </div>
    </nav>

    <!-- 英雄区域 -->
    <section class="petto-hero">
      <div class="hero-container">
        <div class="hero-content">
          <div class="hero-badge">
            <span class="badge-text">🔥 限时1元锁定特权</span>
          </div>
          <h1 class="hero-title">
            专业宠物上门服务
            <span class="hero-subtitle">成为首批体验官，享专属代理权益</span>
          </h1>
          <p class="hero-description">
            现在仅需<b>1元</b>即可锁定城市体验官或代理人资格<br>
            享受多重特权与高额回报，抢占宠物服务市场先机
          </p>
          <div class="hero-actions">
            <button class="hero-cta-primary" @click="scrollToEarlyBird">
              <span class="cta-text">1元锁定资格</span>
              <span class="cta-sub">限前100名</span>
            </button>
            <button class="hero-cta-secondary" @click="scrollToServices">了解服务详情</button>
          </div>
          <div class="hero-stats">
            <div class="stat-item">
              <span class="stat-number">1元</span>
              <span class="stat-label">锁定特权</span>
            </div>
            <div class="stat-item">
              <span class="stat-number">100名</span>
              <span class="stat-label">限额抢购</span>
            </div>
            <div class="stat-item">
              <span class="stat-number">30城</span>
              <span class="stat-label">首批开放</span>
            </div>
          </div>
        </div>
        <div class="hero-visual">
          <div class="visual-container">
            <div class="visual-main">
              <div class="cat-illustration"></div>
              <div class="service-badge badge-1">
                <div class="badge-icon">👑</div>
                <div class="badge-text">城市代理人</div>
              </div>
              <div class="service-badge badge-2">
                <div class="badge-icon">🎯</div>
                <div class="badge-text">GPS签到</div>
              </div>
              <div class="service-badge badge-3">
                <div class="badge-icon">💰</div>
                <div class="badge-text">佣金回报</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 滚动指示器 -->
      <div class="scroll-indicator" @click="scrollToEarlyBird">
        <span class="scroll-text">查看特权</span>
        <div class="scroll-arrow"></div>
      </div>
    </section>

    <!-- 1元锁定特权区域 -->
    <section id="early-bird" class="petto-early-bird" ref="earlyBirdSection">
      <div class="early-bird-container">
        <!-- 限时优惠提示 -->
        <div class="countdown-section">
          <div class="countdown-header">
            <div class="countdown-badge">🔥 限时抢购</div>
            <h2 class="countdown-title">1元锁定城市代理特权</h2>
            <p class="countdown-subtitle">仅需1元，抢占宠物服务市场先机，享多重特权</p>
          </div>
          
          <div class="countdown-timer">
            <div class="timer-label">剩余抢购时间</div>
            <div class="timer-display">
              <div class="timer-unit">
                <span class="timer-number">{{ countdown.hours }}</span>
                <span class="timer-label-small">小时</span>
              </div>
              <span class="timer-colon">:</span>
              <div class="timer-unit">
                <span class="timer-number">{{ countdown.minutes }}</span>
                <span class="timer-label-small">分钟</span>
              </div>
              <span class="timer-colon">:</span>
              <div class="timer-unit">
                <span class="timer-number">{{ countdown.seconds }}</span>
                <span class="timer-label-small">秒</span>
              </div>
            </div>
            <div class="sold-count">
              <div class="sold-progress">
                <div class="progress-bar" :style="{ width: `${soldPercentage}%` }"></div>
              </div>
              <div class="sold-text">
                <span class="sold-number">{{ earlyBirdData.soldCount }}</span>
                <span class="sold-total">/{{ earlyBirdData.totalCount }} 名额已锁定</span>
              </div>
            </div>
          </div>
        </div>

        <!-- 特权选项 -->
        <div class="privilege-options">
          <div 
            class="privilege-card" 
            :class="{ 'featured': activeOption === 0 }"
            @click="selectOption(0)"
          >
            <div class="privilege-badge">最受欢迎</div>
            <div class="privilege-header">
              <h3 class="privilege-title">城市合伙人</h3>
              <div class="privilege-price">
                <span class="original-price">¥2999</span>
                <span class="current-price">¥1</span>
                <span class="price-note">锁定资格</span>
              </div>
              <p class="privilege-description">全面代理权益，最高佣金回报，区域独家经营权</p>
            </div>
            
            <div class="privilege-features">
              <div class="feature-item">
                <span class="feature-icon">💼</span>
                <div class="feature-content">
                  <span class="feature-title">区域独家代理权</span>
                  <span class="feature-desc">指定区域内独家经营权</span>
                </div>
              </div>
              <div class="feature-item">
                <span class="feature-icon">💰</span>
                <div class="feature-content">
                  <span class="feature-title">最高40%佣金</span>
                  <span class="feature-desc">下级代理及订单佣金</span>
                </div>
              </div>
              <div class="feature-item">
                <span class="feature-icon">🏢</span>
                <div class="feature-content">
                  <span class="feature-title">运营支持</span>
                  <span class="feature-desc">专业运营团队1对1指导</span>
                </div>
              </div>
              <div class="feature-item">
                <span class="feature-icon">🎁</span>
                <div class="feature-content">
                  <span class="feature-title">万元开业礼包</span>
                  <span class="feature-desc">包含推广物料、系统使用权等</span>
                </div>
              </div>
            </div>
            
            <div class="privilege-stats">
              <div class="stat">
                <span class="stat-value">10个</span>
                <span class="stat-label">剩余名额</span>
              </div>
              <div class="stat">
                <span class="stat-value">30城</span>
                <span class="stat-label">开放城市</span>
              </div>
            </div>
            
            <button 
              class="privilege-action" 
              :class="{ 'active': activeOption === 0 }"
              @click.stop="lockPrivilege('partner')"
              :disabled="earlyBirdData.soldCount >= earlyBirdData.totalCount"
            >
              <span v-if="earlyBirdData.soldCount >= earlyBirdData.totalCount">已售罄</span>
              <span v-else>立即锁定资格</span>
            </button>
          </div>

          <div 
            class="privilege-card" 
            :class="{ 'featured': activeOption === 1 }"
            @click="selectOption(1)"
          >
            <div class="privilege-badge">推荐选择</div>
            <div class="privilege-header">
              <h3 class="privilege-title">超级体验官</h3>
              <div class="privilege-price">
                <span class="original-price">¥1999</span>
                <span class="current-price">¥1</span>
                <span class="price-note">尊享体验</span>
              </div>
              <p class="privilege-description">深度体验权益，优先合作机会，推广奖励</p>
            </div>
            
            <div class="privilege-features">
              <div class="feature-item">
                <span class="feature-icon">⭐</span>
                <div class="feature-content">
                  <span class="feature-title">VIP尊享体验</span>
                  <span class="feature-desc">全年服务5折特权</span>
                </div>
              </div>
              <div class="feature-item">
                <span class="feature-icon">🤝</span>
                <div class="feature-content">
                  <span class="feature-title">优先合作权</span>
                  <span class="feature-desc">优先升级城市合伙人</span>
                </div>
              </div>
              <div class="feature-item">
                <span class="feature-icon">📈</span>
                <div class="feature-content">
                  <span class="feature-title">推广佣金</span>
                  <span class="feature-desc">推荐客户享20%佣金</span>
                </div>
              </div>
              <div class="feature-item">
                <span class="feature-icon">🎫</span>
                <div class="feature-content">
                  <span class="feature-title">千元礼包</span>
                  <span class="feature-desc">体验券、优惠券等</span>
                </div>
              </div>
            </div>
            
            <div class="privilege-stats">
              <div class="stat">
                <span class="stat-value">25个</span>
                <span class="stat-label">剩余名额</span>
              </div>
              <div class="stat">
                <span class="stat-value">50城</span>
                <span class="stat-label">开放城市</span>
              </div>
            </div>
            
            <button 
              class="privilege-action" 
              :class="{ 'active': activeOption === 1 }"
              @click.stop="lockPrivilege('experience')"
              :disabled="earlyBirdData.soldCount >= earlyBirdData.totalCount"
            >
              <span v-if="earlyBirdData.soldCount >= earlyBirdData.totalCount">已售罄</span>
              <span v-else>立即锁定资格</span>
            </button>
          </div>

          <div 
            class="privilege-card" 
            :class="{ 'featured': activeOption === 2 }"
            @click="selectOption(2)"
          >
            <div class="privilege-badge">基础入门</div>
            <div class="privilege-header">
              <h3 class="privilege-title">推广大使</h3>
              <div class="privilege-price">
                <span class="original-price">¥999</span>
                <span class="current-price">¥1</span>
                <span class="price-note">入门资格</span>
              </div>
              <p class="privilege-description">基础推广权益，灵活参与，持续收益</p>
            </div>
            
            <div class="privilege-features">
              <div class="feature-item">
                <span class="feature-icon">📱</span>
                <div class="feature-content">
                  <span class="feature-title">推广工具</span>
                  <span class="feature-desc">专属推广链接与素材</span>
                </div>
              </div>
              <div class="feature-item">
                <span class="feature-icon">💵</span>
                <div class="feature-content">
                  <span class="feature-title">15%佣金</span>
                  <span class="feature-desc">成功推荐订单佣金</span>
                </div>
              </div>
              <div class="feature-item">
                <span class="feature-icon">🔄</span>
                <div class="feature-content">
                  <span class="feature-title">灵活参与</span>
                  <span class="feature-desc">无强制业绩要求</span>
                </div>
              </div>
              <div class="feature-item">
                <span class="feature-icon">📊</span>
                <div class="feature-content">
                  <span class="feature-title">数据看板</span>
                  <span class="feature-desc">实时推广数据统计</span>
                </div>
              </div>
            </div>
            
            <div class="privilege-stats">
              <div class="stat">
                <span class="stat-value">65个</span>
                <span class="stat-label">剩余名额</span>
              </div>
              <div class="stat">
                <span class="stat-value">全国</span>
                <span class="stat-label">开放区域</span>
              </div>
            </div>
            
            <button 
              class="privilege-action" 
              :class="{ 'active': activeOption === 2 }"
              @click.stop="lockPrivilege('ambassador')"
              :disabled="earlyBirdData.soldCount >= earlyBirdData.totalCount"
            >
              <span v-if="earlyBirdData.soldCount >= earlyBirdData.totalCount">已售罄</span>
              <span v-else>立即锁定资格</span>
            </button>
          </div>
        </div>

        <!-- 特权对比表格 -->
        <div class="privilege-comparison">
          <h3 class="comparison-title">特权详细对比</h3>
          <div class="comparison-table">
            <table>
              <thead>
                <tr>
                  <th>权益项目</th>
                  <th>推广大使</th>
                  <th>超级体验官</th>
                  <th>城市合伙人</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="item in privilegeComparison" :key="item.feature">
                  <td class="feature-name">{{ item.feature }}</td>
                  <td :class="{ 'highlight': item.ambassador === '★' }">{{ item.ambassador }}</td>
                  <td :class="{ 'highlight': item.experience === '★' }">{{ item.experience }}</td>
                  <td :class="{ 'highlight': item.partner === '★' }">{{ item.partner }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- 成功案例展示 -->
        <div class="success-cases">
          <h3 class="cases-title">已锁定用户分享</h3>
          <div class="cases-container">
            <div class="case-card" v-for="caseItem in successCases" :key="caseItem.id">
              <div class="case-header">
                <div class="case-avatar" :style="{ backgroundColor: caseItem.color }">
                  {{ caseItem.name.charAt(0) }}
                </div>
                <div class="case-user">
                  <div class="case-name">{{ caseName(caseItem) }}</div>
                  <div class="case-role">{{ caseItem.role }}</div>
                </div>
                <div class="case-time">{{ caseItem.time }}</div>
              </div>
              <div class="case-content">
                <p class="case-text">"{{ caseItem.comment }}"</p>
                <div class="case-stats">
                  <div class="case-stat">
                    <span class="stat-icon">💰</span>
                    <span class="stat-text">已赚 ¥{{ caseItem.earned }}</span>
                  </div>
                  <div class="case-stat">
                    <span class="stat-icon">👥</span>
                    <span class="stat-text">{{ caseItem.team }}人团队</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 服务项目 -->
    <section id="services" class="petto-services">
      <div class="section-header">
        <h2 class="section-title">专业服务项目</h2>
        <p class="section-subtitle">为您的爱宠提供全方位专业呵护</p>
      </div>
      
      <div class="services-container">
        <div class="service-card" v-for="service in services" :key="service.id">
          <div class="service-icon" :style="{ backgroundColor: service.color }">
            {{ service.icon }}
          </div>
          <h3 class="service-title">{{ service.title }}</h3>
          <p class="service-description">{{ service.description }}</p>
          <div class="service-features">
            <div v-for="feature in service.features" :key="feature" class="service-feature">
              <span class="feature-icon">✓</span>
              <span>{{ feature }}</span>
            </div>
          </div>
          <div class="service-footer">
            <span class="service-price">{{ service.price }}</span>
            <button class="service-book" @click="bookService(service.id)">预约服务</button>
          </div>
        </div>
      </div>
    </section>

    <!-- 核心优势 -->
    <section id="features" class="petto-features">
      <div class="section-header">
        <h2 class="section-title">为什么选择Petto</h2>
        <p class="section-subtitle">我们提供超越期望的宠物服务体验</p>
      </div>
      
      <div class="features-container">
        <div class="feature-item" v-for="feature in features" :key="feature.id">
          <div class="feature-visual">
            <div class="feature-number">{{ feature.id }}</div>
          </div>
          <div class="feature-content">
            <h3 class="feature-title">{{ feature.title }}</h3>
            <p class="feature-description">{{ feature.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- 用户评价 -->
    <section id="testimonials" class="petto-testimonials">
      <div class="section-header">
        <h2 class="section-title">用户真实评价</h2>
        <p class="section-subtitle">听听其他宠物家长怎么说</p>
      </div>
      
      <div class="testimonials-container">
        <div class="testimonial-card" v-for="testimonial in testimonials" :key="testimonial.id">
          <div class="testimonial-header">
            <div class="user-avatar" :style="{ backgroundColor: getRandomColor() }">
              {{ testimonial.name.charAt(0) }}
            </div>
            <div class="user-info">
              <h4 class="user-name">{{ testimonial.name }}</h4>
              <div class="user-pet">{{ testimonial.pet }}</div>
            </div>
            <div class="rating">
              <span v-for="n in 5" :key="n" class="star">★</span>
            </div>
          </div>
          <p class="testimonial-text">"{{ testimonial.text }}"</p>
          <div class="testimonial-service">
            <span class="service-tag">{{ testimonial.service }}</span>
          </div>
        </div>
      </div>
    </section>

    <!-- 价格方案 -->
    <section id="pricing" class="petto-pricing">
      <div class="section-header">
        <h2 class="section-title">常规价格方案</h2>
        <p class="section-subtitle">选择最适合您和爱宠的服务方案</p>
      </div>
      
      <div class="pricing-container">
        <div class="pricing-card" :class="{ 'featured': plan.featured }" v-for="plan in pricingPlans" :key="plan.id">
          <div v-if="plan.featured" class="popular-badge">最受欢迎</div>
          <div class="pricing-header">
            <h3 class="plan-name">{{ plan.name }}</h3>
            <div class="plan-price">
              <span class="price-currency">¥</span>
              <span class="price-amount">{{ plan.price }}</span>
              <span class="price-period">/{{ plan.period }}</span>
            </div>
            <p class="plan-description">{{ plan.description }}</p>
          </div>
          <div class="plan-features">
            <div v-for="feature in plan.features" :key="feature" class="plan-feature">
              <span class="feature-icon">✓</span>
              <span>{{ feature }}</span>
            </div>
          </div>
          <button class="plan-select" :class="{ 'featured-btn': plan.featured }" @click="selectPlan(plan.id)">
            选择此方案
          </button>
        </div>
      </div>
      
      <!-- 返回1元锁定区域的提示 -->
      <div class="back-to-lock">
        <p class="lock-reminder">
          💡 <strong>更优惠的选择：</strong>返回上方参与1元锁定活动，享更多特权与优惠
        </p>
        <button class="back-to-lock-btn" @click="scrollToEarlyBird">
          返回查看1元锁定特权
        </button>
      </div>
    </section>

    <!-- 预约区域 -->
    <section class="petto-booking" ref="bookingSection">
      <div class="booking-container">
        <div class="booking-visual">
          <div class="booking-illustration"></div>
        </div>
        <div class="booking-form">
          <h2 class="booking-title">立即预约服务</h2>
          <p class="booking-subtitle">填写简单信息，专业宠妈/宠爸将尽快联系您</p>
          
          <form @submit.prevent="submitBooking">
            <div class="form-group">
              <label for="name">您的姓名</label>
              <input 
                type="text" 
                id="name" 
                v-model="bookingForm.name"
                placeholder="请输入您的姓名"
                required
              >
            </div>
            
            <div class="form-row">
              <div class="form-group">
                <label for="phone">联系电话</label>
                <input 
                  type="tel" 
                  id="phone" 
                  v-model="bookingForm.phone"
                  placeholder="请输入您的手机号"
                  required
                >
              </div>
              
              <div class="form-group">
                <label for="petType">宠物类型</label>
                <select id="petType" v-model="bookingForm.petType" required>
                  <option value="" disabled selected>请选择宠物类型</option>
                  <option value="cat">猫咪</option>
                  <option value="dog">狗狗</option>
                  <option value="other">其他</option>
                </select>
              </div>
            </div>
            
            <div class="form-group">
              <label for="serviceType">服务类型</label>
              <select id="serviceType" v-model="bookingForm.serviceType" required>
                <option value="" disabled selected>请选择服务类型</option>
                <option value="grooming">宠物美容</option>
                <option value="training">宠物训练</option>
                <option value="bathing">宠物洗护</option>
                <option value="combo">组合套餐</option>
              </select>
            </div>
            
            <div class="form-group">
              <label for="message">附加信息（可选）</label>
              <textarea 
                id="message" 
                v-model="bookingForm.message"
                placeholder="请告诉我们宠物的特殊需求或您的其他要求"
                rows="3"
              ></textarea>
            </div>
            
            <div class="form-submit">
              <button type="submit" class="submit-btn" :disabled="isSubmitting">
                {{ isSubmitting ? '提交中...' : '提交预约' }}
              </button>
              <p class="form-note">
                提交预约后，我们的客服将在24小时内联系您确认服务细节
              </p>
            </div>
          </form>
        </div>
      </div>
    </section>

    <!-- 页脚 -->
    <footer class="petto-footer">
      <div class="footer-container">
        <div class="footer-main">
          <div class="footer-brand">
            <div class="footer-logo">宠物安心上门</div>
            <div class="footer-sub">Petto</div>
            <p class="footer-mission">
              致力于为宠物和主人提供最安心、专业的上门服务体验
            </p>
          </div>
          
          <div class="footer-links">
            <div class="link-group">
              <h4 class="link-title">服务项目</h4>
              <a href="#" class="footer-link">宠物美容</a>
              <a href="#" class="footer-link">宠物训练</a>
              <a href="#" class="footer-link">宠物洗护</a>
              <a href="#" class="footer-link">上门喂养</a>
            </div>
            
            <div class="link-group">
              <h4 class="link-title">代理合作</h4>
              <a href="#early-bird" class="footer-link" @click="scrollToEarlyBird">1元锁定特权</a>
              <a href="#" class="footer-link">城市合伙人</a>
              <a href="#" class="footer-link">超级体验官</a>
              <a href="#" class="footer-link">推广大使</a>
            </div>
            
            <div class="link-group">
              <h4 class="link-title">帮助支持</h4>
              <a href="#" class="footer-link">常见问题</a>
              <a href="#" class="footer-link">用户协议</a>
              <a href="#" class="footer-link">隐私政策</a>
              <a href="#" class="footer-link">联系我们</a>
            </div>
          </div>
        </div>
        
        <div class="footer-contact">
          <div class="contact-info">
            <div class="contact-item">
              <span class="contact-icon">📧</span>
              <span>service@petto.com</span>
            </div>
            <div class="contact-item">
              <span class="contact-icon">📱</span>
              <span>400-123-4567</span>
            </div>
            <div class="contact-item">
              <span class="contact-icon">📍</span>
              <span>赣州市章贡区</span>
            </div>
          </div>
          
          <div class="footer-social">
            <a href="#" class="social-link">微信</a>
            <a href="#" class="social-link">微博</a>
            <a href="#" class="social-link">小红书</a>
            <a href="#" class="social-link">抖音</a>
          </div>
        </div>
        
        <div class="footer-bottom">
          <p class="copyright">© 2026 宠物安心上门 (Petto) 版权所有</p>
          <p class="footer-note">让每只宠物都能享受到专业、安心的上门服务</p>
        </div>
      </div>
    </footer>

    <!-- 返回顶部按钮 -->
    <button v-if="showScrollTop" class="scroll-top-btn" @click="scrollToTop">
      ↑
    </button>

    <!-- 1元锁定弹窗 -->
    <div v-if="showLockModal" class="lock-modal">
      <div class="modal-content">
        <button class="modal-close-btn" @click="closeLockModal">×</button>
        
        <div class="modal-header">
          <div class="modal-icon">🎉</div>
          <h3 class="modal-title">确认锁定资格</h3>
          <p class="modal-subtitle">仅需1元，立即锁定{{ selectedPrivilegeTitle }}特权</p>
        </div>
        
        <div class="modal-privilege">
          <div class="privilege-summary">
            <span class="privilege-name">{{ selectedPrivilegeTitle }}</span>
            <div class="privilege-price">
              <span class="original-price">原价 ¥{{ selectedOriginalPrice }}</span>
              <span class="current-price">现价 <span class="price-amount">¥1</span></span>
            </div>
          </div>
          
          <div class="privilege-features-list">
            <div v-for="(feature, index) in selectedPrivilegeFeatures" :key="index" class="modal-feature">
              <span class="feature-icon">✓</span>
              <span>{{ feature }}</span>
            </div>
          </div>
        </div>
        
        <form @submit.prevent="confirmLock" class="modal-form">
          <div class="form-group">
            <label for="lockName">姓名</label>
            <input 
              type="text" 
              id="lockName" 
              v-model="lockForm.name"
              placeholder="请输入您的姓名"
              required
            >
          </div>
          
          <div class="form-group">
            <label for="lockPhone">手机号</label>
            <input 
              type="tel" 
              id="lockPhone" 
              v-model="lockForm.phone"
              placeholder="用于接收确认信息"
              required
            >
          </div>
          
          <div class="form-group">
            <label for="lockCity">意向城市</label>
            <select id="lockCity" v-model="lockForm.city" required>
              <option value="" disabled selected>请选择意向城市</option>
              <option value="beijing">北京</option>
              <option value="shanghai">上海</option>
              <option value="guangzhou">广州</option>
              <option value="shenzhen">深圳</option>
              <option value="hangzhou">杭州</option>
              <option value="chengdu">成都</option>
            </select>
          </div>
          
          <div class="modal-actions">
            <button type="button" class="modal-cancel" @click="closeLockModal">取消</button>
            <button type="submit" class="modal-confirm" :disabled="isLocking">
              {{ isLocking ? '处理中...' : '立即支付1元锁定' }}
            </button>
          </div>
          
          <p class="modal-note">
            💡 支付成功后，专属顾问将在24小时内联系您，确认后续合作细节
          </p>
        </form>
      </div>
    </div>

    <!-- 锁定成功弹窗 -->
    <div v-if="showLockSuccessModal" class="success-modal">
      <div class="modal-content">
        <div class="modal-icon">🎊</div>
        <h3 class="modal-title">恭喜！锁定成功</h3>
        <p class="modal-text">
          您已成功锁定<b>{{ selectedPrivilegeTitle }}</b>资格<br>
          专属顾问将在24小时内联系您确认合作细节
        </p>
        <div class="success-details">
          <div class="detail-item">
            <span class="detail-label">订单号：</span>
            <span class="detail-value">{{ lockSuccessData.orderNo }}</span>
          </div>
          <div class="detail-item">
            <span class="detail-label">锁定资格：</span>
            <span class="detail-value">{{ selectedPrivilegeTitle }}</span>
          </div>
          <div class="detail-item">
            <span class="detail-label">支付金额：</span>
            <span class="detail-value">¥1</span>
          </div>
        </div>
        <div class="success-actions">
          <button class="modal-close" @click="closeLockSuccessModal">完成</button>
          <button class="modal-contact" @click="contactAdvisor">联系顾问</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, onUnmounted, computed } from 'vue'

// 响应式数据
const mobileMenuOpen = ref(false)
const showScrollTop = ref(false)
const showSuccessModal = ref(false)
const showLockModal = ref(false)
const showLockSuccessModal = ref(false)
const isSubmitting = ref(false)
const isLocking = ref(false)
const activeOption = ref(1) // 默认选中超级体验官
const earlyBirdSection = ref<HTMLElement | null>(null)
const bookingSection = ref<HTMLElement | null>(null)

// 倒计时数据
const countdown = reactive({
  hours: '23',
  minutes: '59',
  seconds: '59'
})

// 早鸟数据
const earlyBirdData = reactive({
  soldCount: 72,
  totalCount: 100,
  soldPercentage: 72
})

// 计算售出百分比
const soldPercentage = computed(() => {
  return (earlyBirdData.soldCount / earlyBirdData.totalCount) * 100
})

// 1元锁定表单数据
const lockForm = reactive({
  name: "",
  phone: "",
  city: ""
})

// 锁定成功数据
const lockSuccessData = reactive({
  orderNo: "PT20231125001"
})

// 选择的特权类型
const selectedPrivilegeType = ref('experience')
const selectedPrivilegeTitle = ref('超级体验官')
const selectedOriginalPrice = ref('1999')
const selectedPrivilegeFeatures = ref<string[]>([])

// 特权对比数据
const privilegeComparison = ref([
  { feature: '1元锁定资格', ambassador: '✓', experience: '✓', partner: '✓' },
  { feature: '推广佣金比例', ambassador: '15%', experience: '20%', partner: '最高40%' },
  { feature: '区域独家经营权', ambassador: '—', experience: '—', partner: '★' },
  { feature: '运营团队支持', ambassador: '—', experience: '基础', partner: '1对1专属' },
  { feature: '开业支持礼包', ambassador: '—', experience: '¥1000', partner: '¥10000' },
  { feature: '服务折扣特权', ambassador: '9折', experience: '5折', partner: '3折' },
  { feature: '下级代理发展', ambassador: '—', experience: '✓', partner: '✓' },
  { feature: '优先合作权', ambassador: '—', experience: '★', partner: '★' }
])

// 成功案例数据
const successCases = ref([
  {
    id: 1,
    name: '张先生',
    city: '上海',
    role: '城市合伙人',
    time: '2天前锁定',
    comment: '看准宠物服务市场潜力，1元锁定城市合伙人资格，现已组建5人团队，月佣金预估超2万！',
    earned: '0',
    team: 5,
    color: '#FF7A2D'
  },
  {
    id: 2,
    name: '李女士',
    city: '北京',
    role: '超级体验官',
    time: '3天前锁定',
    comment: '作为宠物博主，1元锁定体验官资格太划算了，既能享受优惠服务，还能赚取推广佣金。',
    earned: '3200',
    team: 2,
    color: '#34D399'
  },
  {
    id: 3,
    name: '王先生',
    city: '广州',
    role: '推广大使',
    time: '5天前锁定',
    comment: '简单分享就有佣金，1元投资当天就回本了，现在已经推荐了8个客户。',
    earned: '1500',
    team: 0,
    color: '#60A5FA'
  }
])

// 服务列表（保持原样）
const services = ref([
  {
    id: 1,
    icon: "✂️",
    title: "宠物美容",
    description: "专业开结、修剪、造型，让爱宠焕然一新",
    features: ["专业开结(De-matting)", "脚底毛修剪(Paw-dicure)", "面部清洁", "全身造型设计"],
    price: "¥199起",
    color: "#FF7A2D"
  },
  {
    id: 2,
    icon: "🎓",
    title: "宠物训练",
    description: "正向激励训练，解决行为问题，增进人宠关系",
    features: ["响片训练(Clicker Training)", "基础指令训练", "行为问题纠正", "社交能力培养"],
    price: "¥299起",
    color: "#34D399"
  },
  {
    id: 3,
    icon: "🛁",
    title: "宠物洗护",
    description: "低压力洗护流程，专业按摩手法，让宠物享受洗澡",
    features: ["低压力护理(Low-Stress Grooming)", "专业按摩手法", "天然洗护产品", "深度皮毛护理"],
    price: "¥149起",
    color: "#60A5FA"
  },
  {
    id: 4,
    icon: "🏠",
    title: "上门喂养",
    description: "出差旅行时的安心之选，全流程透明服务",
    features: ["GPS定位签到", "实时视频报告", "健康状况记录", "环境清洁维护"],
    price: "¥89/次起",
    color: "#8A2BE2"
  }
])

// 核心优势（保持原样）
const features = ref([
  {
    id: 1,
    title: "专业认证服务者",
    description: "所有服务者均通过严格筛选与专业培训，持证上岗，确保服务品质"
  },
  {
    id: 2,
    title: "全流程透明",
    description: "GPS签到、服务过程记录、实时报告，让您随时掌握服务动态"
  },
  {
    id: 3,
    title: "定制化服务方案",
    description: "根据宠物品种、性格和需求，提供个性化的服务方案"
  },
  {
    id: 4,
    title: "安全放心保障",
    description: "服务全程保险保障，严格消毒流程，确保宠物健康安全"
  }
])

// 用户评价（保持原样）
const testimonials = ref([
  {
    id: 1,
    name: "张女士",
    pet: "布偶猫「奶糖」",
    text: "服务者非常专业，我家奶糖平时很怕生，但这次美容过程特别顺利，全程都有视频记录，太安心了！",
    service: "宠物美容"
  },
  {
    id: 2,
    name: "李先生",
    pet: "柯基「元宝」",
    text: "宠物训练服务太棒了！元宝以前总爱乱叫，经过几次训练后改善了很多，训练师还教了我们很多互动技巧。",
    service: "宠物训练"
  },
  {
    id: 3,
    name: "王小姐",
    pet: "金毛「可乐」",
    text: "每周一次的上门洗护服务解决了我的大难题，服务专业，吹毛特别仔细，可乐现在特别享受洗澡时间。",
    service: "宠物洗护"
  }
])

// 价格方案（保持原样）
const pricingPlans = ref([
  {
    id: 1,
    name: "单次体验",
    price: "199",
    period: "次",
    description: "适合初次体验或偶尔需要服务的用户",
    features: ["单次服务", "基础服务报告", "服务者保险", "7x12客服支持"],
    featured: false
  },
  {
    id: 2,
    name: "月度套餐",
    price: "699",
    period: "月",
    description: "适合有定期服务需求的宠物家庭",
    features: ["4次服务/月", "详细服务报告", "优先预约权", "9折附加服务", "专属服务顾问"],
    featured: true
  },
  {
    id: 3,
    name: "季度尊享",
    price: "1899",
    period: "季",
    description: "适合追求高品质服务的宠物家庭",
    features: ["12次服务/季", "VIP服务报告", "随时预约权", "8折附加服务", "专属服务团队", "节日专属礼包"],
    featured: false
  }
])

// 预约表单数据（保持原样）
const bookingForm = reactive({
  name: "",
  phone: "",
  petType: "",
  serviceType: "",
  message: ""
})

// 方法
const toggleMobileMenu = () => {
  mobileMenuOpen.value = !mobileMenuOpen.value
}

const closeMobileMenu = () => {
  mobileMenuOpen.value = false
}

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

const scrollToServices = () => {
  const element = document.getElementById('services')
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' })
  }
}

const scrollToEarlyBird = () => {
  if (earlyBirdSection.value) {
    earlyBirdSection.value.scrollIntoView({ behavior: 'smooth' })
  }
  closeMobileMenu()
}

const scrollToFeatures = () => {
  const element = document.getElementById('features')
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' })
  }
}

const scrollToBooking = () => {
  if (bookingSection.value) {
    bookingSection.value.scrollIntoView({ behavior: 'smooth' })
  }
  closeMobileMenu()
}

const bookService = (serviceId: number) => {
  const service = services.value.find(s => s.id === serviceId)
  if (service) {
    bookingForm.serviceType = service.title
    scrollToBooking()
  }
}

const selectPlan = (planId: number) => {
  console.log(`Selected plan: ${planId}`)
  scrollToBooking()
}

const selectOption = (optionIndex: number) => {
  activeOption.value = optionIndex
}

const lockPrivilege = (type: string) => {
  if (earlyBirdData.soldCount >= earlyBirdData.totalCount) {
    alert('抱歉，名额已售罄！')
    return
  }
  
  selectedPrivilegeType.value = type
  
  // 根据类型设置特权信息
  switch (type) {
    case 'partner':
      selectedPrivilegeTitle.value = '城市合伙人'
      selectedOriginalPrice.value = '2999'
      selectedPrivilegeFeatures.value = [
        '区域独家代理权',
        '最高40%佣金回报',
        '专业运营团队1对1指导',
        '万元开业支持礼包',
        '优先参与平台活动'
      ]
      break
    case 'experience':
      selectedPrivilegeTitle.value = '超级体验官'
      selectedOriginalPrice.value = '1999'
      selectedPrivilegeFeatures.value = [
        '全年服务5折特权',
        '优先升级城市合伙人',
        '推荐客户享20%佣金',
        '千元体验礼包',
        '专属推广素材支持'
      ]
      break
    case 'ambassador':
      selectedPrivilegeTitle.value = '推广大使'
      selectedOriginalPrice.value = '999'
      selectedPrivilegeFeatures.value = [
        '专属推广链接与素材',
        '成功推荐订单享15%佣金',
        '无强制业绩要求',
        '实时推广数据统计',
        '灵活参与时间'
      ]
      break
  }
  
  showLockModal.value = true
}

const closeLockModal = () => {
  showLockModal.value = false
  // 重置表单
  lockForm.name = ""
  lockForm.phone = ""
  lockForm.city = ""
}

const confirmLock = () => {
  if (!lockForm.name || !lockForm.phone || !lockForm.city) {
    alert('请填写完整信息')
    return
  }
  
  isLocking.value = true
  
  // 模拟API请求
  setTimeout(() => {
    console.log('Lock submitted:', { ...lockForm, type: selectedPrivilegeType.value })
    isLocking.value = false
    
    // 更新售出数量
    earlyBirdData.soldCount += 1
    
    // 生成随机订单号
    lockSuccessData.orderNo = `PT${new Date().getFullYear()}${String(new Date().getMonth() + 1).padStart(2, '0')}${String(new Date().getDate()).padStart(2, '0')}${String(Math.floor(Math.random() * 1000)).padStart(3, '0')}`
    
    showLockModal.value = false
    showLockSuccessModal.value = true
  }, 1500)
}

const closeLockSuccessModal = () => {
  showLockSuccessModal.value = false
}

const contactAdvisor = () => {
  alert('顾问将在24小时内联系您，请保持手机畅通')
  showLockSuccessModal.value = false
}

const submitBooking = () => {
  if (!bookingForm.name || !bookingForm.phone || !bookingForm.petType || !bookingForm.serviceType) {
    alert('请填写完整信息')
    return
  }
  
  isSubmitting.value = true
  
  // 模拟API请求
  setTimeout(() => {
    console.log('Booking submitted:', bookingForm)
    isSubmitting.value = false
    showSuccessModal.value = true
    
    // 重置表单
    bookingForm.name = ""
    bookingForm.phone = ""
    bookingForm.petType = ""
    bookingForm.serviceType = ""
    bookingForm.message = ""
  }, 1500)
}

const closeSuccessModal = () => {
  showSuccessModal.value = false
}

const getRandomColor = () => {
  const colors = ['#FF7A2D', '#34D399', '#60A5FA', '#8A2BE2', '#FFD700']
  return colors[Math.floor(Math.random() * colors.length)]
}

const caseName = (caseItem: any) => {
  return `${caseItem.name} · ${caseItem.city}`
}

// 倒计时逻辑
let countdownInterval: NodeJS.Timeout | null = null

const startCountdown = () => {
  // 设置24小时倒计时
  let totalSeconds = 24 * 60 * 60 // 24小时
  
  countdownInterval = setInterval(() => {
    if (totalSeconds <= 0) {
      clearInterval(countdownInterval!)
      return
    }
    
    totalSeconds--
    
    const hours = Math.floor(totalSeconds / 3600)
    const minutes = Math.floor((totalSeconds % 3600) / 60)
    const seconds = totalSeconds % 60
    
    countdown.hours = String(hours).padStart(2, '0')
    countdown.minutes = String(minutes).padStart(2, '0')
    countdown.seconds = String(seconds).padStart(2, '0')
  }, 1000)
}

// 监听滚动事件
const handleScroll = () => {
  showScrollTop.value = window.scrollY > 500
}

// 生命周期钩子
onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  startCountdown()
  
  // 清理函数
  onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll)
    if (countdownInterval) {
      clearInterval(countdownInterval)
    }
  })
})
</script>

<style scoped>
/* 全局样式 */
.petto-landing-page {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  color: #333;
  overflow-x: hidden;
  line-height: 1.6;
  margin: 0;
  padding: 0;
}

/* 修复导航栏 */
.petto-nav {
  background-color: rgba(255, 255, 255, 0.98);
  backdrop-filter: blur(10px);
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 1000;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  height: 70px;
  display: flex;
  align-items: center;
}

.nav-container {
  max-width: 1200px;
  width: 100%;
  margin: 0 auto;
  padding: 0 1.5rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-sizing: border-box;
}

.nav-logo {
  display: flex;
  flex-direction: column;
  font-weight: 700;
  flex-shrink: 0;
}

.logo-text {
  font-size: 1.4rem;
  color: #FF7A2D;
  letter-spacing: -0.5px;
  line-height: 1.2;
}

.logo-sub {
  font-size: 0.8rem;
  color: #666;
  letter-spacing: 1.5px;
  margin-top: 2px;
}

.nav-links {
  display: flex;
  gap: 1.8rem;
  align-items: center;
  flex-wrap: wrap;
  justify-content: flex-end;
}

.nav-link {
  color: #555;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s;
  position: relative;
  font-size: 0.95rem;
  white-space: nowrap;
  padding: 0.5rem 0;
}

.nav-link:hover {
  color: #FF7A2D;
}

.nav-link::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0;
  height: 2px;
  background-color: #FF7A2D;
  transition: width 0.3s;
}

.nav-link:hover::after {
  width: 100%;
}

.nav-cta {
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  border: none;
  padding: 0.65rem 1.4rem;
  border-radius: 50px;
  font-weight: 600;
  cursor: pointer;
  transition: transform 0.3s, box-shadow 0.3s;
  font-size: 0.95rem;
  white-space: nowrap;
  margin-left: 0.5rem;
}

.nav-cta:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(255, 122, 45, 0.3);
}

.nav-mobile-toggle {
  display: none;
  flex-direction: column;
  gap: 4px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 5px;
  z-index: 1001;
}

.hamburger-line {
  display: block;
  width: 24px;
  height: 2px;
  background-color: #333;
  transition: transform 0.3s, opacity 0.3s;
}

.line-1-active {
  transform: rotate(45deg) translate(5px, 5px);
}

.line-2-active {
  opacity: 0;
}

.line-3-active {
  transform: rotate(-45deg) translate(5px, -5px);
}

.mobile-menu {
  display: none;
  flex-direction: column;
  padding: 1rem 1.5rem;
  background-color: white;
  border-top: 1px solid #eee;
  position: absolute;
  top: 70px;
  left: 0;
  right: 0;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.mobile-link {
  padding: 1rem 0;
  color: #555;
  text-decoration: none;
  border-bottom: 1px solid #f5f5f5;
  font-weight: 500;
}

.mobile-cta {
  margin-top: 1rem;
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  border: none;
  padding: 1rem;
  border-radius: 50px;
  font-weight: 600;
  cursor: pointer;
  width: 100%;
}

/* 修复英雄区域 */
.petto-hero {
  padding: 120px 1.5rem 80px;
  background: linear-gradient(135deg, #fef7f0 0%, #f0f9ff 100%);
  position: relative;
  overflow: hidden;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  box-sizing: border-box;
  margin-top: 70px; /* 为固定导航栏留出空间 */
}

.hero-container {
  max-width: 1200px;
  width: 100%;
  margin: 0 auto;
  display: flex;
  align-items: center;
  gap: 3rem;
  box-sizing: border-box;
}

.hero-content {
  flex: 1;
  min-width: 0;
}

.hero-badge {
  display: inline-block;
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  padding: 0.6rem 1.2rem;
  border-radius: 50px;
  font-weight: 600;
  margin-bottom: 1.5rem;
  font-size: 0.9rem;
  animation: badgePulse 2s ease-in-out infinite;
}

@keyframes badgePulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.hero-title {
  font-size: 3rem;
  font-weight: 800;
  line-height: 1.2;
  color: #222;
  margin-bottom: 1rem;
  letter-spacing: -0.5px;
  overflow-wrap: break-word;
}

.hero-subtitle {
  display: block;
  font-size: 1.3rem;
  font-weight: 400;
  color: #666;
  margin-top: 0.5rem;
  line-height: 1.4;
}

.hero-description {
  font-size: 1.1rem;
  color: #666;
  margin-bottom: 2rem;
  line-height: 1.7;
}

.hero-description b {
  color: #FF7A2D;
  font-weight: 700;
}

.hero-actions {
  display: flex;
  gap: 1rem;
  margin-bottom: 3rem;
  flex-wrap: wrap;
}

.hero-cta-primary {
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  border: none;
  padding: 1rem 2rem;
  border-radius: 50px;
  font-size: 1.1rem;
  font-weight: 600;
  cursor: pointer;
  transition: transform 0.3s, box-shadow 0.3s;
  display: flex;
  flex-direction: column;
  align-items: center;
  min-width: 180px;
}

.hero-cta-primary:hover {
  transform: translateY(-3px);
  box-shadow: 0 10px 20px rgba(255, 122, 45, 0.3);
}

.cta-text {
  font-size: 1.1rem;
}

.cta-sub {
  font-size: 0.85rem;
  opacity: 0.9;
  font-weight: 400;
  margin-top: 3px;
}

.hero-cta-secondary {
  background: transparent;
  color: #FF7A2D;
  border: 2px solid #FF7A2D;
  padding: 1rem 2rem;
  border-radius: 50px;
  font-size: 1.1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
  min-width: 150px;
}

.hero-cta-secondary:hover {
  background-color: #FF7A2D;
  color: white;
}

.hero-stats {
  display: flex;
  gap: 2.5rem;
  flex-wrap: wrap;
}

.stat-item {
  display: flex;
  flex-direction: column;
  min-width: 80px;
}

.stat-number {
  font-size: 2.2rem;
  font-weight: 700;
  color: #FF7A2D;
  line-height: 1;
}

.stat-label {
  font-size: 0.9rem;
  color: #666;
  margin-top: 0.5rem;
}

.hero-visual {
  flex: 1;
  min-width: 0;
}

.visual-container {
  position: relative;
  height: 400px;
  width: 100%;
}

.visual-main {
  position: relative;
  width: 100%;
  height: 100%;
  min-height: 350px;
}

.cat-illustration {
  width: 300px;
  height: 300px;
  background: linear-gradient(135deg, #FFD700, #FF9E5C);
  border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  animation: float 6s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: translate(-50%, -50%) rotate(0deg); }
  50% { transform: translate(-50%, -55%) rotate(5deg); }
}

.service-badge {
  position: absolute;
  background: white;
  padding: 0.7rem 1.1rem;
  border-radius: 50px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  display: flex;
  align-items: center;
  gap: 0.5rem;
  animation: badgeFloat 4s ease-in-out infinite;
  z-index: 2;
  white-space: nowrap;
}

.service-badge.badge-1 {
  top: 15%;
  right: 5%;
  animation-delay: 0s;
}

.service-badge.badge-2 {
  bottom: 35%;
  left: 5%;
  animation-delay: 1s;
}

.service-badge.badge-3 {
  bottom: 15%;
  right: 10%;
  animation-delay: 2s;
}

@keyframes badgeFloat {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

.badge-icon {
  font-size: 1.2rem;
}

.badge-text {
  font-weight: 600;
  color: #333;
  font-size: 0.9rem;
}

.scroll-indicator {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
  animation: bounce 2s infinite;
}

@keyframes bounce {
  0%, 20%, 50%, 80%, 100% { transform: translateX(-50%) translateY(0); }
  40% { transform: translateX(-50%) translateY(-10px); }
  60% { transform: translateX(-50%) translateY(-5px); }
}

.scroll-text {
  font-size: 0.85rem;
  color: #666;
  margin-bottom: 0.5rem;
}

.scroll-arrow {
  width: 20px;
  height: 20px;
  border-right: 2px solid #666;
  border-bottom: 2px solid #666;
  transform: rotate(45deg);
}

/* 通用区块样式 */
section {
  padding: 80px 2rem;
  box-sizing: border-box;
}

.section-header {
  text-align: center;
  margin-bottom: 3rem;
}

.section-title {
  font-size: 2.5rem;
  font-weight: 700;
  color: #222;
  margin-bottom: 0.5rem;
}

.section-subtitle {
  font-size: 1.125rem;
  color: #666;
  max-width: 600px;
  margin: 0 auto;
}

/* 1元锁定特权区域样式 */
.petto-early-bird {
  padding: 100px 2rem 80px;
  background: linear-gradient(135deg, #fff9f0 0%, #fff0f5 100%);
  position: relative;
  overflow: hidden;
  box-sizing: border-box;
}

.early-bird-container {
  max-width: 1200px;
  margin: 0 auto;
}

/* 倒计时区域 */
.countdown-section {
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  border-radius: 20px;
  padding: 3rem;
  color: white;
  text-align: center;
  margin-bottom: 3rem;
  box-shadow: 0 10px 30px rgba(255, 122, 45, 0.3);
  position: relative;
  overflow: hidden;
}

.countdown-section::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  right: -50%;
  bottom: -50%;
  background: radial-gradient(circle at center, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
  animation: pulse 4s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { transform: scale(1); opacity: 0.5; }
  50% { transform: scale(1.05); opacity: 0.8; }
}

.countdown-badge {
  display: inline-block;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  padding: 0.5rem 1.5rem;
  border-radius: 50px;
  font-weight: 600;
  margin-bottom: 1rem;
  font-size: 0.875rem;
}

.countdown-title {
  font-size: 2.5rem;
  font-weight: 800;
  margin-bottom: 0.5rem;
  letter-spacing: -0.5px;
}

.countdown-subtitle {
  font-size: 1.125rem;
  opacity: 0.9;
  margin-bottom: 2rem;
}

.countdown-timer {
  max-width: 600px;
  margin: 0 auto;
}

.timer-label {
  font-size: 1rem;
  margin-bottom: 1rem;
  opacity: 0.9;
}

.timer-display {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1rem;
  margin-bottom: 2rem;
}

.timer-unit {
  display: flex;
  flex-direction: column;
  align-items: center;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 15px;
  padding: 1rem;
  min-width: 80px;
}

.timer-number {
  font-size: 2.5rem;
  font-weight: 800;
  line-height: 1;
}

.timer-label-small {
  font-size: 0.875rem;
  opacity: 0.9;
  margin-top: 0.25rem;
}

.timer-colon {
  font-size: 2rem;
  font-weight: 700;
  margin-top: -1rem;
}

.sold-count {
  max-width: 400px;
  margin: 0 auto;
}

.sold-progress {
  height: 10px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 5px;
  overflow: hidden;
  margin-bottom: 0.5rem;
}

.progress-bar {
  height: 100%;
  background: linear-gradient(90deg, #FFD700, #FF9E5C);
  border-radius: 5px;
  transition: width 0.5s ease;
}

.sold-text {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 0.875rem;
}

.sold-number {
  font-weight: 700;
  font-size: 1.25rem;
}

/* 特权选项区域 */
.privilege-options {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
  margin-bottom: 4rem;
}

.privilege-card {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  position: relative;
  border: 2px solid transparent;
  cursor: pointer;
}

.privilege-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
}

.privilege-card.featured {
  border-color: #FF7A2D;
  transform: scale(1.05);
}

.privilege-card.featured:hover {
  transform: scale(1.05) translateY(-10px);
}

.privilege-badge {
  position: absolute;
  top: -12px;
  left: 50%;
  transform: translateX(-50%);
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  padding: 0.5rem 1.5rem;
  border-radius: 50px;
  font-size: 0.875rem;
  font-weight: 600;
  white-space: nowrap;
}

.privilege-header {
  text-align: center;
  margin-bottom: 2rem;
  padding-top: 1rem;
}

.privilege-title {
  font-size: 1.75rem;
  font-weight: 800;
  color: #222;
  margin-bottom: 1rem;
}

.privilege-price {
  display: flex;
  align-items: baseline;
  justify-content: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.original-price {
  text-decoration: line-through;
  color: #999;
  font-size: 1rem;
}

.current-price {
  font-size: 2.5rem;
  font-weight: 800;
  color: #FF7A2D;
  line-height: 1;
}

.price-note {
  color: #666;
  font-size: 0.875rem;
}

.privilege-description {
  color: #666;
  font-size: 0.875rem;
  line-height: 1.5;
}

.privilege-features {
  margin-bottom: 2rem;
}

.feature-item {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  margin-bottom: 1.25rem;
  padding-bottom: 1.25rem;
  border-bottom: 1px solid #f0f0f0;
}

.feature-item:last-child {
  border-bottom: none;
  margin-bottom: 0;
  padding-bottom: 0;
}

.feature-icon {
  font-size: 1.5rem;
  flex-shrink: 0;
  width: 40px;
  height: 40px;
  background: #f8f8f8;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.feature-content {
  flex: 1;
}

.feature-title {
  font-weight: 700;
  color: #222;
  display: block;
  margin-bottom: 0.25rem;
}

.feature-desc {
  font-size: 0.875rem;
  color: #666;
  display: block;
}

.privilege-stats {
  display: flex;
  justify-content: space-around;
  background: #f8f8f8;
  border-radius: 15px;
  padding: 1rem;
  margin-bottom: 2rem;
}

.stat {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.stat-value {
  font-size: 1.5rem;
  font-weight: 800;
  color: #FF7A2D;
  line-height: 1;
}

.stat-label {
  font-size: 0.75rem;
  color: #666;
  margin-top: 0.25rem;
}

.privilege-action {
  width: 100%;
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  border: none;
  padding: 1rem;
  border-radius: 50px;
  font-size: 1.125rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.privilege-action:hover:not(:disabled) {
  transform: translateY(-3px);
  box-shadow: 0 10px 20px rgba(255, 122, 45, 0.3);
}

.privilege-action.active {
  background: linear-gradient(135deg, #34D399, #60A5FA);
}

.privilege-action:disabled {
  background: #ccc;
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
}

/* 特权对比表格 */
.privilege-comparison {
  margin-bottom: 4rem;
}

.comparison-title {
  font-size: 1.75rem;
  font-weight: 700;
  color: #222;
  text-align: center;
  margin-bottom: 2rem;
}

.comparison-table {
  background: white;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
}

.comparison-table table {
  width: 100%;
  border-collapse: collapse;
}

.comparison-table th {
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  padding: 1.25rem;
  text-align: center;
  font-weight: 600;
}

.comparison-table th:first-child {
  background: #222;
  text-align: left;
}

.comparison-table td {
  padding: 1rem 1.25rem;
  text-align: center;
  border-bottom: 1px solid #f0f0f0;
}

.comparison-table td:first-child {
  text-align: left;
  font-weight: 600;
  color: #222;
}

.comparison-table tr:last-child td {
  border-bottom: none;
}

.comparison-table td.highlight {
  background: #fff9f0;
  color: #FF7A2D;
  font-weight: 700;
}

/* 成功案例区域 */
.success-cases {
  margin-bottom: 4rem;
}

.cases-title {
  font-size: 1.75rem;
  font-weight: 700;
  color: #222;
  text-align: center;
  margin-bottom: 2rem;
}

.cases-container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1.5rem;
}

.case-card {
  background: white;
  border-radius: 15px;
  padding: 1.5rem;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.case-header {
  display: flex;
  align-items: center;
  margin-bottom: 1rem;
}

.case-avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 700;
  font-size: 1.25rem;
  margin-right: 1rem;
}

.case-user {
  flex: 1;
}

.case-name {
  font-weight: 700;
  color: #222;
  margin-bottom: 0.25rem;
}

.case-role {
  font-size: 0.875rem;
  color: #FF7A2D;
  font-weight: 600;
}

.case-time {
  font-size: 0.875rem;
  color: #999;
}

.case-content {
  padding-top: 1rem;
  border-top: 1px solid #f0f0f0;
}

.case-text {
  color: #555;
  line-height: 1.6;
  margin-bottom: 1rem;
  font-style: italic;
}

.case-stats {
  display: flex;
  gap: 1.5rem;
}

.case-stat {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.stat-icon {
  font-size: 1.25rem;
}

.stat-text {
  font-size: 0.875rem;
  color: #666;
  font-weight: 600;
}

/* 返回1元锁定区域的提示 */
.back-to-lock {
  background: linear-gradient(135deg, #fff9f0, #fff0f5);
  border-radius: 15px;
  padding: 2rem;
  text-align: center;
  margin-top: 3rem;
  border: 2px dashed #FF7A2D;
}

.lock-reminder {
  font-size: 1.125rem;
  color: #222;
  margin-bottom: 1.5rem;
}

.back-to-lock-btn {
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  border: none;
  padding: 1rem 2rem;
  border-radius: 50px;
  font-size: 1.125rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.back-to-lock-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 10px 20px rgba(255, 122, 45, 0.3);
}

/* 1元锁定弹窗样式 */
.lock-modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2000;
  backdrop-filter: blur(5px);
}

.lock-modal .modal-content {
  background: white;
  border-radius: 25px;
  max-width: 500px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
  position: relative;
  box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
  animation: modalAppear 0.3s ease-out;
}

@keyframes modalAppear {
  from { opacity: 0; transform: scale(0.9); }
  to { opacity: 1; transform: scale(1); }
}

.modal-close-btn {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: none;
  border: none;
  font-size: 2rem;
  color: #999;
  cursor: pointer;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  transition: all 0.3s;
}

.modal-close-btn:hover {
  background: #f5f5f5;
  color: #333;
}

.modal-header {
  text-align: center;
  padding: 3rem 2rem 2rem;
  border-bottom: 1px solid #f0f0f0;
}

.modal-icon {
  font-size: 3.5rem;
  margin-bottom: 1rem;
}

.modal-title {
  font-size: 1.75rem;
  font-weight: 800;
  color: #222;
  margin-bottom: 0.5rem;
}

.modal-subtitle {
  color: #666;
  font-size: 1rem;
}

.modal-privilege {
  padding: 2rem;
  background: #f9f9f9;
  margin: 0 2rem;
  border-radius: 15px;
  position: relative;
  top: -1rem;
}

.privilege-summary {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}

.privilege-name {
  font-size: 1.25rem;
  font-weight: 700;
  color: #222;
}

.privilege-price {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
}

.original-price {
  text-decoration: line-through;
  color: #999;
  font-size: 0.875rem;
}

.current-price {
  font-size: 1.5rem;
  font-weight: 800;
  color: #FF7A2D;
}

.price-amount {
  font-size: 2rem;
}

.privilege-features-list {
  margin-top: 1rem;
}

.modal-feature {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 0.75rem;
  color: #555;
}

.modal-feature:last-child {
  margin-bottom: 0;
}

.modal-form {
  padding: 2rem;
}

.modal-form .form-group {
  margin-bottom: 1.25rem;
}

.modal-form label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 600;
  color: #555;
}

.modal-form input,
.modal-form select {
  width: 100%;
  padding: 0.75rem 1rem;
  border: 2px solid #e5e5e5;
  border-radius: 10px;
  font-size: 1rem;
  transition: border-color 0.3s;
}

.modal-form input:focus,
.modal-form select:focus {
  outline: none;
  border-color: #FF7A2D;
}

.modal-actions {
  display: flex;
  gap: 1rem;
  margin-top: 2rem;
}

.modal-cancel,
.modal-confirm {
  flex: 1;
  padding: 1rem;
  border-radius: 50px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.modal-cancel {
  background: #f5f5f5;
  color: #666;
  border: 2px solid #e5e5e5;
}

.modal-cancel:hover {
  background: #e5e5e5;
}

.modal-confirm {
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  border: none;
}

.modal-confirm:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(255, 122, 45, 0.3);
}

.modal-confirm:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.modal-note {
  margin-top: 1.5rem;
  font-size: 0.875rem;
  color: #666;
  text-align: center;
  line-height: 1.5;
}

/* 锁定成功弹窗样式 */
.success-modal .modal-content {
  background: white;
  padding: 3rem;
  border-radius: 25px;
  max-width: 500px;
  width: 90%;
  text-align: center;
  box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
}

.success-details {
  background: #f9f9f9;
  border-radius: 15px;
  padding: 1.5rem;
  margin: 1.5rem 0;
  text-align: left;
}

.detail-item {
  display: flex;
  justify-content: space-between;
  margin-bottom: 0.75rem;
  padding-bottom: 0.75rem;
  border-bottom: 1px solid #eee;
}

.detail-item:last-child {
  margin-bottom: 0;
  padding-bottom: 0;
  border-bottom: none;
}

.detail-label {
  color: #666;
}

.detail-value {
  font-weight: 600;
  color: #222;
}

.success-actions {
  display: flex;
  gap: 1rem;
  margin-top: 1.5rem;
}

.success-actions button {
  flex: 1;
  padding: 0.75rem;
  border-radius: 50px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.modal-close {
  background: #f5f5f5;
  color: #666;
  border: 2px solid #e5e5e5;
}

.modal-close:hover {
  background: #e5e5e5;
}

.modal-contact {
  background: linear-gradient(135deg, #34D399, #60A5FA);
  color: white;
  border: none;
}

.modal-contact:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(52, 211, 153, 0.3);
}

/* 服务项目样式 */
.petto-services {
  background-color: #fafafa;
}

.services-container {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 2rem;
}

.service-card {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
  transition: transform 0.3s, box-shadow 0.3s;
  display: flex;
  flex-direction: column;
}

.service-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
}

.service-icon {
  width: 60px;
  height: 60px;
  border-radius: 15px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.75rem;
  margin-bottom: 1.5rem;
}

.service-title {
  font-size: 1.5rem;
  font-weight: 700;
  color: #222;
  margin-bottom: 1rem;
}

.service-description {
  color: #666;
  margin-bottom: 1.5rem;
  flex-grow: 1;
}

.service-features {
  margin-bottom: 1.5rem;
}

.service-feature {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.5rem;
  color: #555;
}

.feature-icon {
  color: #34D399;
  font-weight: bold;
}

.service-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: auto;
}

.service-price {
  font-size: 1.5rem;
  font-weight: 700;
  color: #FF7A2D;
}

.service-book {
  background: transparent;
  color: #FF7A2D;
  border: 2px solid #FF7A2D;
  padding: 0.5rem 1.25rem;
  border-radius: 50px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.service-book:hover {
  background-color: #FF7A2D;
  color: white;
}

/* 核心优势样式 */
.features-container {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.feature-item {
  display: flex;
  gap: 1.5rem;
  align-items: flex-start;
}

.feature-visual {
  flex-shrink: 0;
}

.feature-number {
  width: 50px;
  height: 50px;
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.5rem;
  font-weight: 700;
}

.feature-title {
  font-size: 1.25rem;
  font-weight: 700;
  color: #222;
  margin-bottom: 0.5rem;
}

.feature-description {
  color: #666;
  line-height: 1.6;
}

/* 用户评价样式 */
.petto-testimonials {
  background-color: #f0f9ff;
}

.testimonials-container {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.testimonial-card {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.testimonial-header {
  display: flex;
  align-items: center;
  margin-bottom: 1.5rem;
}

.user-avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.25rem;
  font-weight: 700;
  color: white;
  margin-right: 1rem;
}

.user-info {
  flex-grow: 1;
}

.user-name {
  font-weight: 700;
  color: #222;
  margin-bottom: 0.25rem;
}

.user-pet {
  font-size: 0.875rem;
  color: #666;
}

.rating {
  color: #FFD700;
  font-size: 1.25rem;
}

.testimonial-text {
  color: #555;
  line-height: 1.7;
  margin-bottom: 1.5rem;
  font-style: italic;
}

.testimonial-service {
  display: flex;
  justify-content: flex-end;
}

.service-tag {
  background-color: #f0f9ff;
  color: #60A5FA;
  padding: 0.25rem 0.75rem;
  border-radius: 50px;
  font-size: 0.875rem;
  font-weight: 600;
}

/* 价格方案样式 */
.pricing-container {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.pricing-card {
  background: white;
  border-radius: 20px;
  padding: 2.5rem 2rem;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
  position: relative;
  transition: transform 0.3s;
  display: flex;
  flex-direction: column;
}

.pricing-card:hover {
  transform: translateY(-10px);
}

.pricing-card.featured {
  border: 2px solid #FF7A2D;
  transform: scale(1.05);
}

.pricing-card.featured:hover {
  transform: scale(1.05) translateY(-10px);
}

.popular-badge {
  position: absolute;
  top: -12px;
  left: 50%;
  transform: translateX(-50%);
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  padding: 0.5rem 1.5rem;
  border-radius: 50px;
  font-size: 0.875rem;
  font-weight: 600;
}

.pricing-header {
  text-align: center;
  margin-bottom: 2rem;
}

.plan-name {
  font-size: 1.5rem;
  font-weight: 700;
  color: #222;
  margin-bottom: 1rem;
}

.plan-price {
  margin-bottom: 1rem;
}

.price-currency {
  font-size: 1.5rem;
  font-weight: 600;
  color: #666;
  vertical-align: top;
}

.price-amount {
  font-size: 3rem;
  font-weight: 800;
  color: #222;
}

.price-period {
  font-size: 1rem;
  color: #666;
}

.plan-description {
  color: #666;
  font-size: 0.875rem;
}

.plan-features {
  margin-bottom: 2rem;
  flex-grow: 1;
}

.plan-feature {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
  color: #555;
}

.plan-select {
  background: #f5f5f5;
  color: #333;
  border: none;
  padding: 1rem;
  border-radius: 50px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.plan-select:hover {
  background-color: #e5e5e5;
}

.featured-btn {
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
}

.featured-btn:hover {
  background: linear-gradient(135deg, #FF6A1D, #FF8E4C);
}

/* 预约区域样式 */
.petto-booking {
  background: linear-gradient(135deg, #fef7f0 0%, #f0f9ff 100%);
}

.booking-container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  gap: 4rem;
}

.booking-visual {
  flex: 1;
}

.booking-illustration {
  width: 100%;
  height: 400px;
  background: linear-gradient(135deg, #34D399, #60A5FA);
  border-radius: 20px;
  position: relative;
  overflow: hidden;
}

.booking-illustration::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: radial-gradient(circle at 30% 30%, rgba(255, 255, 255, 0.2) 0%, transparent 50%);
}

.booking-form {
  flex: 1;
  background: white;
  padding: 2.5rem;
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.booking-title {
  font-size: 2rem;
  font-weight: 700;
  color: #222;
  margin-bottom: 0.5rem;
}

.booking-subtitle {
  color: #666;
  margin-bottom: 2rem;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-row {
  display: flex;
  gap: 1rem;
}

.form-row .form-group {
  flex: 1;
}

label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 600;
  color: #555;
}

input, select, textarea {
  width: 100%;
  padding: 0.75rem 1rem;
  border: 2px solid #e5e5e5;
  border-radius: 10px;
  font-size: 1rem;
  transition: border-color 0.3s;
}

input:focus, select:focus, textarea:focus {
  outline: none;
  border-color: #FF7A2D;
}

textarea {
  resize: vertical;
  font-family: inherit;
}

.form-submit {
  margin-top: 2rem;
}

.submit-btn {
  width: 100%;
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  border: none;
  padding: 1rem;
  border-radius: 50px;
  font-size: 1.125rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.submit-btn:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(255, 122, 45, 0.3);
}

.submit-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.form-note {
  font-size: 0.875rem;
  color: #666;
  text-align: center;
  margin-top: 1rem;
}

/* 页脚样式 */
.petto-footer {
  background-color: #222;
  color: #ddd;
  padding: 4rem 2rem 2rem;
}

.footer-container {
  max-width: 1200px;
  margin: 0 auto;
}

.footer-main {
  display: flex;
  justify-content: space-between;
  margin-bottom: 3rem;
  flex-wrap: wrap;
  gap: 2rem;
}

.footer-brand {
  flex: 1;
  min-width: 250px;
}

.footer-logo {
  font-size: 1.75rem;
  font-weight: 700;
  color: white;
  margin-bottom: 0.25rem;
}

.footer-sub {
  font-size: 1rem;
  color: #FF7A2D;
  letter-spacing: 2px;
  margin-bottom: 1rem;
}

.footer-mission {
  color: #aaa;
  max-width: 300px;
}

.footer-links {
  display: flex;
  gap: 3rem;
  flex-wrap: wrap;
}

.link-group {
  min-width: 150px;
}

.link-title {
  color: white;
  font-size: 1.125rem;
  font-weight: 600;
  margin-bottom: 1rem;
}

.footer-link {
  display: block;
  color: #aaa;
  text-decoration: none;
  margin-bottom: 0.5rem;
  transition: color 0.3s;
}

.footer-link:hover {
  color: #FF7A2D;
}

.footer-contact {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 2rem 0;
  border-top: 1px solid #444;
  border-bottom: 1px solid #444;
  margin-bottom: 2rem;
  flex-wrap: wrap;
  gap: 1.5rem;
}

.contact-info {
  display: flex;
  gap: 2rem;
  flex-wrap: wrap;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.contact-icon {
  font-size: 1.25rem;
}

.footer-social {
  display: flex;
  gap: 1.5rem;
}

.social-link {
  color: #ddd;
  text-decoration: none;
  transition: color 0.3s;
}

.social-link:hover {
  color: #FF7A2D;
}

.footer-bottom {
  text-align: center;
  padding-top: 2rem;
}

.copyright {
  color: #aaa;
  margin-bottom: 0.5rem;
}

.footer-note {
  color: #666;
  font-size: 0.875rem;
}

/* 返回顶部按钮 */
.scroll-top-btn {
  position: fixed;
  bottom: 2rem;
  right: 2rem;
  width: 50px;
  height: 50px;
  background: linear-gradient(135deg, #FF7A2D, #FF9E5C);
  color: white;
  border: none;
  border-radius: 50%;
  font-size: 1.25rem;
  cursor: pointer;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s, opacity 0.3s;
  z-index: 100;
}

.scroll-top-btn:hover {
  transform: translateY(-5px);
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .hero-container {
    flex-direction: column;
    text-align: center;
    gap: 2.5rem;
  }
  
  .hero-stats {
    justify-content: center;
  }
  
  .hero-visual {
    width: 100%;
    max-width: 500px;
    margin: 0 auto;
  }
  
  .nav-links {
    gap: 1.2rem;
  }
  
  .booking-container {
    flex-direction: column;
  }
  
  .privilege-options {
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  }
  
  .privilege-card.featured {
    transform: scale(1);
  }
  
  .privilege-card.featured:hover {
    transform: translateY(-10px);
  }
}

@media (max-width: 768px) {
  .petto-hero {
    padding: 100px 1rem 60px;
  }
  
  .hero-title {
    font-size: 2.2rem;
  }
  
  .hero-subtitle {
    font-size: 1.1rem;
  }
  
  .hero-description {
    font-size: 1rem;
  }
  
  .hero-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .hero-cta-primary,
  .hero-cta-secondary {
    width: 100%;
    max-width: 280px;
  }
  
  .hero-stats {
    flex-direction: column;
    gap: 1.5rem;
    align-items: center;
  }
  
  .nav-links {
    display: none;
  }
  
  .nav-mobile-toggle {
    display: flex;
  }
  
  .mobile-menu {
    display: flex;
  }
  
  .cat-illustration {
    width: 250px;
    height: 250px;
  }
  
  .service-badge {
    padding: 0.5rem 0.9rem;
    font-size: 0.85rem;
  }
  
  .service-badge.badge-1 {
    top: 10%;
    right: 3%;
  }
  
  .service-badge.badge-2 {
    bottom: 30%;
    left: 3%;
  }
  
  .service-badge.badge-3 {
    bottom: 10%;
    right: 5%;
  }
  
  .petto-early-bird {
    padding: 80px 1rem 60px;
  }
  
  .countdown-section {
    padding: 2rem 1rem;
  }
  
  .countdown-title {
    font-size: 2rem;
  }
  
  .timer-unit {
    min-width: 60px;
    padding: 0.75rem;
  }
  
  .timer-number {
    font-size: 2rem;
  }
  
  .privilege-options {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .cases-container {
    grid-template-columns: 1fr;
  }
  
  .comparison-table {
    overflow-x: auto;
  }
  
  .comparison-table table {
    min-width: 600px;
  }
  
  .footer-main {
    flex-direction: column;
  }
  
  .footer-links {
    justify-content: space-between;
  }
  
  .footer-contact {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .contact-info {
    flex-direction: column;
    gap: 1rem;
  }
}

@media (max-width: 480px) {
  .petto-hero {
    padding: 90px 0.8rem 50px;
  }
  
  .hero-title {
    font-size: 1.8rem;
  }
  
  .hero-subtitle {
    font-size: 1rem;
  }
  
  .cat-illustration {
    width: 200px;
    height: 200px;
  }
  
  .visual-container {
    height: 300px;
  }
  
  .nav-container {
    padding: 0 1rem;
  }
  
  .logo-text {
    font-size: 1.2rem;
  }
  
  .logo-sub {
    font-size: 0.7rem;
  }
  
  .countdown-title {
    font-size: 1.75rem;
  }
  
  .timer-display {
    gap: 0.5rem;
  }
  
  .timer-unit {
    min-width: 50px;
    padding: 0.5rem;
  }
  
  .timer-number {
    font-size: 1.75rem;
  }
  
  .timer-colon {
    font-size: 1.5rem;
  }
  
  .lock-modal .modal-content {
    width: 95%;
  }
  
  .modal-privilege {
    margin: 0 1rem;
  }
  
  .modal-form {
    padding: 1.5rem;
  }
  
  .petto-hero, section {
    padding-left: 1rem;
    padding-right: 1rem;
  }
  
  .services-container,
  .testimonials-container,
  .pricing-container {
    grid-template-columns: 1fr;
  }
  
  .feature-item {
    flex-direction: column;
    text-align: center;
    align-items: center;
  }
}

/* 确保所有box-sizing一致 */
* {
  box-sizing: border-box;
}

/* 修复滚动行为 */
html {
  scroll-behavior: smooth;
}
</style>