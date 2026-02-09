<template>
  <div class="flash-store-simulator">
    <!-- 视角切换器 -->
    <div class="view-switcher">
      <h2>🏪 闪仓商业模拟器</h2>
      <div class="view-tabs">
        <button 
          v-for="view in viewOptions" 
          :key="view.value"
          @click="currentView = view.value"
          :class="['view-tab', { active: currentView === view.value }]"
        >
          <span class="icon">{{ view.icon }}</span>
          <span class="label">{{ view.label }}</span>
        </button>
      </div>
    </div>

    <!-- 平台视角 -->
    <div v-if="currentView === 'platform'" class="platform-view">
      <!-- 顶部控制面板 -->
      <div class="control-panel">
        <div class="panel-section">
          <h3>⚙️ 模拟参数配置</h3>
          <div class="param-group">
            <div class="param">
              <label>模拟速度：</label>
              <select v-model="simulationSpeed">
                <option v-for="speed in deliveryTypes" :key="speed.value" :value="speed.value">
                  {{ speed.label }}
                </option>
              </select>
            </div>
            <div class="param">
              <label>骑手数量：</label>
              <input type="range" v-model.number="riderCount" min="1" max="20" />
              <span>{{ riderCount }}人</span>
            </div>
            <div class="param">
              <label>订单生成率：</label>
              <input type="range" v-model.number="orderRate" min="1" max="20" />
              <span>{{ orderRate }}单/分钟</span>
            </div>
            <button @click="toggleSimulation" :class="isRunning ? 'stop' : 'start'">
              {{ isRunning ? '⏹️ 停止模拟' : '▶️ 开始模拟' }}
            </button>
            <button @click="resetSimulation" class="reset">🔄 重置</button>
          </div>
        </div>
      </div>

    <!-- 主仪表板 -->
    <div class="dashboard">
      <!-- 左侧：业务数据 -->
      <div class="business-data">
        <div class="data-card total">
          <h4>📊 实时数据概览</h4>
          <div class="stats">
            <div class="stat">
              <span class="label">今日订单：</span>
              <span class="value">{{ stats.totalOrders }}</span>
            </div>
            <div class="stat">
              <span class="label">完成率：</span>
              <span class="value">{{ stats.completionRate }}%</span>
            </div>
            <div class="stat">
              <span class="label">平均送达时间：</span>
              <span class="value">{{ stats.avgDeliveryTime }}分钟</span>
            </div>
            <div class="stat">
              <span class="label">采购成本：</span>
              <span class="value">¥{{ formatCurrency(stats.purchaseCost) }}</span>
            </div>
            <div class="stat">
              <span class="label">项目总投入：</span>
              <span class="value">¥{{ formatCurrency(stats.totalInvestment) }}</span>
            </div>
            <div class="stat">
              <span class="label">总收益：</span>
              <span class="value" :style="{ color: stats.totalProfit >= 0 ? '#48bb78' : '#f56565' }">
                ¥{{ formatCurrency(stats.totalProfit) }}
              </span>
            </div>
            <div class="stat">
              <span class="label">总收入：</span>
              <span class="value">¥{{ formatCurrency(stats.totalRevenue) }}</span>
            </div>
          </div>
        </div>

        <div class="data-card profit">
          <h4>💰 收益分布</h4>
          <div class="profit-distribution">
            <div class="profit-item platform">
              <span>平台收入：</span>
              <span>¥{{ formatCurrency(stats.platformRevenue) }}</span>
              <div class="bar" :style="{ width: platformProfitPercentage + '%' }"></div>
            </div>
            <div class="profit-item rider">
              <span>骑手收入：</span>
              <span>¥{{ formatCurrency(stats.riderRevenue) }}</span>
              <div class="bar" :style="{ width: riderProfitPercentage + '%' }"></div>
            </div>
            <div class="profit-item supplier">
              <span>供应商收入：</span>
              <span>¥{{ formatCurrency(stats.supplierRevenue) }}</span>
              <div class="bar" :style="{ width: supplierProfitPercentage + '%' }"></div>
            </div>
          </div>
        </div>
      </div>

      <!-- 中间：订单流程 -->
      <div class="order-flow">
        <h3>📦 实时订单流程</h3>
        <div class="flow-stages">
          <div class="stage pending" :class="{ active: activeOrders.pending.length > 0 }">
            <span class="stage-name">待接单</span>
            <span class="count">{{ activeOrders.pending.length }}</span>
          </div>
          <div class="stage-icon">→</div>
          <div class="stage accepted" :class="{ active: activeOrders.accepted.length > 0 }">
            <span class="stage-name">已接单</span>
            <span class="count">{{ activeOrders.accepted.length }}</span>
          </div>
          <div class="stage-icon">→</div>
          <div class="stage picking" :class="{ active: activeOrders.picking.length > 0 }">
            <span class="stage-name">备货中</span>
            <span class="count">{{ activeOrders.picking.length }}</span>
          </div>
          <div class="stage-icon">→</div>
          <div class="stage delivering" :class="{ active: activeOrders.delivering.length > 0 }">
            <span class="stage-name">配送中</span>
            <span class="count">{{ activeOrders.delivering.length }}</span>
          </div>
          <div class="stage-icon">→</div>
          <div class="stage completed" :class="{ active: activeOrders.completed.length > 0 }">
            <span class="stage-name">已完成</span>
            <span class="count">{{ activeOrders.completed.length }}</span>
          </div>
        </div>

        <div class="order-list">
          <div class="order-item" v-for="order in visibleOrders" :key="order.id" :class="order.status">
            <div class="order-header">
              <span class="order-id">#{{ order.id }}</span>
              <span class="order-time">{{ order.createdAt }}</span>
              <span class="order-status">{{ getStatusText(order.status) }}</span>
            </div>
            <div class="order-details">
              <span class="customer">👤 {{ order.customerName }}</span>
              <span class="rider">🏍️ {{ order.riderName || '待分配' }}</span>
              <span class="amount">¥{{ order.totalAmount }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧：角色面板 -->
      <div class="role-panel">
        <div class="role-card users">
          <h4>👥 用户端</h4>
          <div class="user-stats">
            <div>活跃用户：{{ userStats.activeUsers }}</div>
            <div>平均订单额：¥{{ userStats.avgOrderValue }}</div>
            <div>复购率：{{ userStats.repurchaseRate }}%</div>
          </div>
          <div class="user-actions">
            <button @click="generateOrder" :disabled="!isRunning">生成新订单</button>
            <div class="order-types">
              <label v-for="type in orderTypeOptions" :key="type.value">
                <input type="radio" v-model="newOrderType" :value="type.value" />
                {{ type.label }}
              </label>
            </div>
          </div>
        </div>

        <div class="role-card riders">
          <h4>🏍️ 骑手端</h4>
          <div class="rider-list">
            <div class="rider-item" v-for="rider in activeRiders" :key="rider.id">
              <div class="rider-info">
                <span class="name">{{ rider.name }}</span>
                <span class="status" :class="rider.status">{{ getRiderStatus(rider.status) }}</span>
              </div>
              <div class="rider-stats">
                <span>今日单量：{{ rider.todayOrders }}</span>
                <span>收入：¥{{ rider.todayIncome }}</span>
              </div>
            </div>
          </div>
          <div class="rider-actions">
            <button @click="addRider">+ 添加骑手</button>
            <button @click="removeRider" :disabled="activeRiders.length <= 1">- 减少骑手</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 商品管理面板 -->
    <div class="product-panel">
      <h3>🛒 商品管理与定价</h3>
      <div class="products">
        <div class="product-item" v-for="product in products" :key="product.id">
          <div class="product-info">
            <span class="name">{{ product.name }}</span>
            <span class="category">{{ product.category }}</span>
          </div>
          <div class="product-pricing">
            <div class="price-input">
              <label>进货价：</label>
              <input type="number" v-model.number="product.purchasePrice" min="1" />
            </div>
            <div class="price-input">
              <label>零售价：</label>
              <input type="number" v-model.number="product.salePrice" :min="product.purchasePrice + 1" />
            </div>
            <div class="margin">
              毛利率：{{ calculateMargin(product) }}%
            </div>
          </div>
          <div class="product-stock">
            <label>库存：</label>
            <input type="number" v-model.number="product.stock" min="0" />
            <button @click="restockProduct(product.id)" class="restock">补货</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 历史数据图表 -->
    <div class="charts">
      <div class="chart-container">
        <h4>📈 收入趋势</h4>
        <div class="chart-placeholder">
          <!-- 这里可以用图表库如Chart.js或ECharts -->
          <div class="mock-chart">
            <div class="chart-bar" v-for="(hour, index) in hourlyRevenue" :key="index"
                 :style="{ height: hour.revenue / 100 + 'px' }">
              <span class="tooltip">¥{{ hour.revenue }}</span>
            </div>
          </div>
        </div>
      </div>
      <div class="chart-container">
        <h4>📊 订单分布</h4>
        <div class="chart-placeholder">
          <div class="pie-chart">
            <div class="pie-segment" :style="{
              '--percentage': (orderDistribution.delivery * 100) / totalDistribution,
              '--color': '#4CAF50'
            }"></div>
            <div class="pie-segment" :style="{
              '--percentage': (orderDistribution.pickup * 100) / totalDistribution,
              '--color': '#2196F3'
            }"></div>
            <div class="pie-label">
              <div><span class="dot delivery"></span> 配送 {{ orderDistribution.delivery }}单</div>
              <div><span class="dot pickup"></span> 自提 {{ orderDistribution.pickup }}单</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 数据导入导出面板 -->
    <div class="data-io-panel">
      <h3>📊 数据管理</h3>
      <div class="io-sections">
        <div class="io-section export">
          <h4>导出数据</h4>
          <div class="export-buttons">
            <button @click="exportOrders" class="export-btn">📋 导出订单数据</button>
            <button @click="exportProducts" class="export-btn">🛒 导出商品数据</button>
            <button @click="exportStats" class="export-btn">📈 导出收益统计</button>
            <button @click="exportAll" class="export-btn primary">📦 导出全部数据</button>
          </div>
        </div>
        
        <div class="io-section import">
          <h4>导入数据</h4>
          <div class="import-controls">
            <div class="file-input">
              <label for="csvFile">选择CSV文件：</label>
              <input type="file" id="csvFile" @change="handleFileUpload" accept=".csv" />
            </div>
            <div class="import-options">
              <label>
                <input type="radio" v-model="importType" value="products" />
                商品数据
              </label>
              <label>
                <input type="radio" v-model="importType" value="config" />
                配置数据
              </label>
            </div>
            <button @click="importData" class="import-btn" :disabled="!csvFile">📥 导入数据</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 高级配置面板 -->
    <div class="advanced-config">
      <h3>⚙️ 高级配置</h3>
      
      <!-- 配置错误提示 -->
      <div v-if="configErrors.length > 0" class="config-errors">
        <h4>⚠️ 配置错误</h4>
        <ul>
          <li v-for="error in configErrors" :key="error">{{ error }}</li>
        </ul>
      </div>
      
      <!-- 配置预览 -->
      <div class="config-preview">
        <h4>📊 成本预览</h4>
        <div class="preview-items">
          <div class="preview-item">
            <span class="label">每日箱体成本：</span>
            <span class="value">¥{{ formatCurrency(configPreview.dailyBoxCost) }}</span>
          </div>
          <div class="preview-item">
            <span class="label">每日奖励成本：</span>
            <span class="value">¥{{ formatCurrency(configPreview.dailyRewardCost) }}</span>
          </div>
          <div class="preview-item">
            <span class="label">营销预算：</span>
            <span class="value">¥{{ formatCurrency(configPreview.marketingBudget) }}</span>
          </div>
          <div class="preview-item total">
            <span class="label">每日总成本：</span>
            <span class="value">¥{{ formatCurrency(configPreview.totalDailyCost) }}</span>
          </div>
        </div>
      </div>
      
      <div class="config-sections">
        <div class="config-section box-pricing">
          <h4>📦 闪仓箱体价格控制</h4>
          <div class="config-items">
            <div class="config-item" :class="{ error: advancedConfig.boxCost < 0 }">
              <label>箱体成本（元/天）：</label>
              <input type="number" v-model.number="advancedConfig.boxCost" min="0" step="0.1" />
            </div>
            <div class="config-item" :class="{ error: advancedConfig.boxCapacity < 10 || advancedConfig.boxCapacity > 200 }">
              <label>箱体容量（件）：</label>
              <input type="number" v-model.number="advancedConfig.boxCapacity" min="10" max="200" />
            </div>
            <div class="config-item" :class="{ error: advancedConfig.fullLoadThreshold < 50 || advancedConfig.fullLoadThreshold > 95 }">
              <label>满载率阈值（%）：</label>
              <input type="number" v-model.number="advancedConfig.fullLoadThreshold" min="50" max="95" />
            </div>
            <div class="config-item" :class="{ error: advancedConfig.dynamicPricingFactor < 0.8 || advancedConfig.dynamicPricingFactor > 1.5 }">
              <label>动态定价系数：</label>
              <input type="number" v-model.number="advancedConfig.dynamicPricingFactor" min="0.8" max="1.5" step="0.1" />
            </div>
          </div>
        </div>
        
        <div class="config-section rewards">
          <h4>🎁 前期奖励成本</h4>
          <div class="config-items">
            <div class="config-item">
              <label>用户首单奖励（元）：</label>
              <input type="number" v-model.number="advancedConfig.firstOrderReward" min="0" step="1" />
            </div>
            <div class="config-item">
              <label>骑手接单奖励（元/单）：</label>
              <input type="number" v-model.number="advancedConfig.riderOrderReward" min="0" step="0.5" />
            </div>
            <div class="config-item">
              <label>推荐奖励（元/人）：</label>
              <input type="number" v-model.number="advancedConfig.referralReward" min="0" step="1" />
            </div>
            <div class="config-item" :class="{ error: advancedConfig.marketingBudgetRatio < 1 || advancedConfig.marketingBudgetRatio > 20 }">
              <label>营销预算比例（%）：</label>
              <input type="number" v-model.number="advancedConfig.marketingBudgetRatio" min="1" max="20" />
            </div>
          </div>
        </div>
        
        <div class="config-section compliance">
          <h4>🛡️ 合规监控</h4>
          <div class="config-items">
            <div class="config-item">
              <label>合规检查间隔（分钟）：</label>
              <input type="number" v-model.number="advancedConfig.complianceCheckInterval" min="5" max="60" />
            </div>
            <div class="config-item">
              <label>违规处罚金额（元）：</label>
              <input type="number" v-model.number="advancedConfig.violationPenalty" min="50" step="10" />
            </div>
            <div class="config-item" :class="{ error: advancedConfig.complianceTarget < 80 || advancedConfig.complianceTarget > 100 }">
              <label>合规率目标（%）：</label>
              <input type="number" v-model.number="advancedConfig.complianceTarget" min="80" max="100" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 骑手视角 -->
  <div v-if="currentView === 'rider'" class="rider-view">
    <div class="rider-dashboard">
      <h3>🏍️ 骑手工作台</h3>
      
      <div class="rider-registration" v-if="!currentRiderProfile">
        <h4>📝 骑手注册</h4>
        <div class="registration-form">
          <div class="form-group">
            <label>姓名：</label>
            <input type="text" v-model="riderForm.name" placeholder="请输入姓名" />
          </div>
          <div class="form-group">
            <label>手机号：</label>
            <input type="tel" v-model="riderForm.phone" placeholder="请输入手机号" />
          </div>
          <div class="form-group">
            <label>身份证号：</label>
            <input type="text" v-model="riderForm.idCard" placeholder="请输入身份证号" />
          </div>
          <button @click="registerRider" class="register-btn">📋 提交注册</button>
        </div>
      </div>
  
      <div v-else class="rider-workspace">
        <!-- 个人信息 -->
        <div class="rider-profile">
          <h4>👤 个人信息</h4>
          <div class="profile-info">
            <div class="info-item">
              <span class="label">姓名：</span>
              <span class="value">{{ currentRiderProfile.name }}</span>
            </div>
            <div class="info-item">
              <span class="label">状态：</span>
              <span class="value" :class="currentRiderProfile.status">
                {{ getRiderStatus(currentRiderProfile.status) }}
              </span>
            </div>
            <div class="info-item">
              <span class="label">今日订单：</span>
              <span class="value">{{ currentRiderProfile.todayOrders }}单</span>
            </div>
            <div class="info-item">
              <span class="label">今日收入：</span>
              <span class="value">¥{{ currentRiderProfile.todayIncome }}</span>
            </div>
            <div class="info-item">
              <span class="label">效率评分：</span>
              <span class="value">{{ currentRiderProfile.efficiency }}/10</span>
            </div>
          </div>
        </div>

        <!-- 箱体管理 -->
        <div class="box-management">
          <h4>📦 闪仓箱体管理</h4>
          <div class="box-info" v-if="currentRiderProfile.box">
            <div class="box-details">
              <div class="detail-item">
                <span class="label">箱体ID：</span>
                <span class="value">#{{ currentRiderProfile.box.id }}</span>
              </div>
              <div class="detail-item">
                <span class="label">容量：</span>
                <span class="value">{{ currentRiderProfile.box.capacity }}件</span>
              </div>
              <div class="detail-item">
                <span class="label">当前装载：</span>
                <span class="value">{{ currentRiderProfile.box.currentLoad }}件</span>
              </div>
              <div class="detail-item">
                <span class="label">日租金：</span>
                <span class="value">¥{{ currentRiderProfile.box.dailyCost }}</span>
              </div>
            </div>
            <div class="box-actions">
              <button @click="restockBox" class="restock-btn">📦 补货</button>
              <button @click="returnBox" class="return-btn">🔄 归还箱体</button>
            </div>
          </div>
          <div v-else class="no-box">
            <p>您还没有租用闪仓箱体</p>
            <button @click="rentBox" class="rent-btn">📦 租用箱体</button>
          </div>
        </div>

        <!-- 订单管理 -->
        <div class="order-management">
          <h4>📋 订单管理</h4>
          <div class="order-list">
            <div class="order-item" v-for="order in myOrders" :key="order.id" :class="order.status">
              <div class="order-header">
                <span class="order-id">#{{ order.id }}</span>
                <span class="order-status">{{ getStatusText(order.status) }}</span>
                <span class="order-amount">¥{{ order.totalAmount }}</span>
              </div>
              <div class="order-details">
                <span class="customer">👤 {{ order.customerName }}</span>
                <span class="time">⏰ {{ order.createdAt }}</span>
              </div>
              <div class="order-actions">
                <button v-if="order.status === 'pending'" @click="acceptOrder(order.id)" class="accept-btn">✅ 接单</button>
                <button v-if="order.status === 'accepted'" @click="startPicking(order.id)" class="pickup-btn">📦 开始备货</button>
                <button v-if="order.status === 'picking'" @click="startDelivery(order.id)" class="delivery-btn">🏍️ 开始配送</button>
                <button v-if="order.status === 'delivering'" @click="completeOrder(order.id)" class="complete-btn">✅ 完成订单</button>
              </div>
            </div>
          </div>
        </div>

        <!-- 收益统计 -->
        <div class="earnings-stats">
          <h4>� 收益统计</h4>
          <div class="stats-grid">
            <div class="stat-card"><span class="label">今日收入</span><span class="value">¥{{ currentRiderProfile.todayIncome }}</span></div>
            <div class="stat-card"><span class="label">本周收入</span><span class="value">¥{{ weeklyEarnings }}</span></div>
            <div class="stat-card"><span class="label">本月收入</span><span class="value">¥{{ monthlyEarnings }}</span></div>
            <div class="stat-card"><span class="label">平均每单</span><span class="value">¥{{ averageEarning }}</span></div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 供应商视角 -->
  <div v-if="currentView === 'supplier'" class="supplier-view">
    <div class="supplier-dashboard">
      <h3>📦 供应商管理后台</h3>
      <div class="product-management">
        <h4>🛒 商品管理</h4>
        <div class="products-grid">
          <div class="product-card" v-for="product in products" :key="product.id">
            <div class="product-header">
              <h5>{{ product.name }}</h5>
              <span class="category">{{ product.category }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 客户视角 -->
  <div v-if="currentView === 'customer'" class="customer-view">
    <div class="customer-dashboard">
      <h3>👤 客户管理后台</h3>
      <div class="info-cards">
        <div class="info-card">
          <span class="label">用户名：</span>
          <span class="value">{{ currentUser.name }}</span>
        </div>
        <div class="info-card">
          <span class="label">会员等级：</span>
          <span class="value" :class="currentUser.level">{{ getUserLevelText(currentUser.level) }}</span>
        </div>
        <div class="info-card">
          <span class="label">积分：</span>
          <span class="value">{{ currentUser.points }}</span>
        </div>
        <div class="info-card">
          <span class="label">优惠券：</span>
          <span class="value">{{ currentUser.coupons.length }}张</span>
        </div>
      </div>
    </div>
  </div>

  <!-- 模拟控制台 -->
  <div class="console">
    <h4>📝 模拟日志</h4>
    <div class="log-list">
      <div class="log-item" v-for="(log, index) in simulationLogs.slice().reverse()" :key="index">
        <span class="log-time">{{ log.time }}</span>
        <span class="log-message">{{ log.message }}</span>
      </div>
    </div>
  </div>
</div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted, watch } from 'vue'

// ========== 类型定义 ==========
interface Product {
  id: number
  name: string
  category: string
  purchasePrice: number
  salePrice: number
  stock: number
  popularity: number // 1-10，影响购买概率
}

interface Order {
  id: number
  customerName: string
  riderId: number | null
  riderName: string | null
  items: OrderItem[]
  totalAmount: number
  deliveryType: 'delivery' | 'pickup'
  status: 'pending' | 'accepted' | 'picking' | 'delivering' | 'completed' | 'cancelled'
  createdAt: string
  completedAt: string | null
  deliveryFee: number
  platformFee: number
}

interface OrderItem {
  productId: number
  productName: string
  quantity: number
  unitPrice: number
  totalPrice: number
}

interface Rider {
  id: number
  name: string
  status: 'idle' | 'busy' | 'offline'
  todayOrders: number
  todayIncome: number
  efficiency: number // 1-10，影响配送速度
  box?: {
    id: number
    capacity: number
    currentLoad: number
    dailyCost: number
  }
}

interface CartItem {
  id: number
  name: string
  price: number
  quantity: number
}

interface SimulationStats {
  totalOrders: number
  completedOrders: number
  cancelledOrders: number
  totalRevenue: number
  platformRevenue: number
  riderRevenue: number
  supplierRevenue: number
  purchaseCost: number
  totalInvestment: number
  totalProfit: number
  avgDeliveryTime: number
  completionRate: number
}

interface LogEntry {
  time: string
  message: string
}

interface AdvancedConfig {
  boxCost: number
  boxCapacity: number
  fullLoadThreshold: number
  dynamicPricingFactor: number
  firstOrderReward: number
  riderOrderReward: number
  referralReward: number
  marketingBudgetRatio: number
  complianceCheckInterval: number
  violationPenalty: number
  complianceTarget: number
}

// ========== 响应式数据 ==========
const currentView = ref<'platform' | 'rider' | 'supplier' | 'customer'>('platform')
const simulationSpeed = ref<'day' | 'week' | 'month' | 'slow' | 'normal' | 'fast' | 'instant'>('normal')
const riderCount = ref(5)
const orderRate = ref(8)
const isRunning = ref(false)
const newOrderType = ref<'delivery' | 'pickup'>('delivery')

// 视角选项
const viewOptions = [
  { value: 'platform' as const, label: '平台管理', icon: '🏢' },
  { value: 'rider' as const, label: '骑手端', icon: '🏍️' },
  { value: 'supplier' as const, label: '供应商', icon: '📦' },
  { value: 'customer' as const, label: '客户', icon: '👤' }
]

// 骑手视角数据
const currentRiderProfile = ref<Rider | null>(null)
const riderForm = ref({
  name: '',
  phone: '',
  idCard: ''
})

// 供应商视角数据
const showAddProductModal = ref(false)

// 客户视角数据
const currentUser = ref({
  name: '张三',
  level: 'gold' as 'bronze' | 'silver' | 'gold' | 'platinum',
  points: 1250,
  coupons: [
    { id: 1, type: 'discount', value: 10, description: '满50减10' },
    { id: 2, type: 'freedelivery', value: 0, description: '免配送费' }
  ]
})

const searchQuery = ref('')
const selectedCategory = ref('')
const cartItems = ref<CartItem[]>([])
const deliveryType = ref<'delivery' | 'pickup'>('delivery')

// 计算分类列表
const categories = computed(() => {
  const cats = [...new Set(products.value.map(p => p.category))]
  return cats
})

// 过滤商品
const filteredProducts = computed(() => {
  return products.value.filter(product => {
    const matchesSearch = product.name.toLowerCase().includes(searchQuery.value.toLowerCase())
    const matchesCategory = !selectedCategory.value || product.category === selectedCategory.value
    return matchesSearch && matchesCategory
  })
})

// 购物车统计
const cartTotal = computed(() => {
  return cartItems.value.reduce((total, item) => total + (item.price * item.quantity), 0)
})

const deliveryFee = computed(() => {
  return deliveryType.value === 'delivery' ? 3 : 0
})

// 计算属性
const myOrders = computed(() => {
  return orders.value.filter(order => order.riderId === currentRiderProfile.value?.id)
})

const weeklyEarnings = computed(() => {
  return (currentRiderProfile.value?.todayIncome || 0) * 7
})

const monthlyEarnings = computed(() => {
  return (currentRiderProfile.value?.todayIncome || 0) * 30
})

const averageEarning = computed(() => {
  const orders = myOrders.value.filter(o => o.status === 'completed')
  if (orders.length === 0) return 0
  const totalIncome = orders.reduce((sum, order) => sum + order.deliveryFee, 0)
  return Math.round(totalIncome / orders.length)
})

const supplierProfit = computed(() => {
  return stats.value.supplierRevenue - stats.value.purchaseCost
})

const supplierProfitMargin = computed(() => {
  if (stats.value.supplierRevenue === 0) return 0
  return Math.round((supplierProfit.value / stats.value.supplierRevenue) * 100)
})

const supplierSalesData = computed(() => {
  // 模拟销售数据
  return Array.from({ length: 7 }, (_, i) => ({
    day: i + 1,
    amount: Math.floor(Math.random() * 1000) + 200
  }))
})

const averageOrderValue = computed(() => {
  const completedOrders = orders.value.filter(o => o.status === 'completed')
  if (completedOrders.length === 0) return 0
  return Math.round(completedOrders.reduce((sum, order) => sum + order.totalAmount, 0) / completedOrders.length)
})

const bestSellingProduct = computed(() => {
  const productSales: Record<number, number> = {}
  orders.value.forEach(order => {
    if (order.status === 'completed') {
      order.items.forEach(item => {
        productSales[item.productId] = (productSales[item.productId] || 0) + item.quantity
      })
    }
  })
  
  let maxSales = 0
  let bestProductId = 0
  
  Object.entries(productSales).forEach(([productId, sales]) => {
    if (sales > maxSales) {
      maxSales = sales
      bestProductId = parseInt(productId)
    }
  })
  
  return products.value.find(p => p.id === bestProductId)
})

const customerOrders = computed(() => {
  return orders.value.filter(order => order.customerName === currentUser.value.name)
})

// 数据导入导出相关
const importType = ref<'products' | 'config'>('products')
const csvFile = ref<File | null>(null)

// 高级配置
const advancedConfig = ref<AdvancedConfig>({
  boxCost: 5.0,
  boxCapacity: 100,
  fullLoadThreshold: 80,
  dynamicPricingFactor: 1.0,
  firstOrderReward: 10,
  riderOrderReward: 2,
  referralReward: 15,
  marketingBudgetRatio: 5,
  complianceCheckInterval: 15,
  violationPenalty: 100,
  complianceTarget: 95
})

// 模拟数据
const products = ref<Product[]>([
  { id: 1, name: '冰镇可乐', category: '饮料', purchasePrice: 2.5, salePrice: 5, stock: 100, popularity: 9 },
  { id: 2, name: '薯片', category: '零食', purchasePrice: 3, salePrice: 6, stock: 80, popularity: 8 },
  { id: 3, name: '方便面', category: '速食', purchasePrice: 4, salePrice: 8, stock: 60, popularity: 7 },
  { id: 4, name: '矿泉水', category: '饮料', purchasePrice: 1, salePrice: 2, stock: 150, popularity: 10 },
  { id: 5, name: '巧克力', category: '零食', purchasePrice: 5, salePrice: 10, stock: 50, popularity: 6 },
  { id: 6, name: '纸巾', category: '日用品', purchasePrice: 2, salePrice: 4, stock: 120, popularity: 7 },
  { id: 7, name: '电池', category: '日用品', purchasePrice: 3, salePrice: 6, stock: 40, popularity: 5 },
  { id: 8, name: '面包', category: '食品', purchasePrice: 3.5, salePrice: 7, stock: 70, popularity: 8 },
])

const orders = ref<Order[]>([])
const riders = ref<Rider[]>([])
const simulationLogs = ref<LogEntry[]>([])

// 定时器变量
let simulationInterval: NodeJS.Timeout | null = null

// 配置验证和预览
const configErrors = ref<string[]>([])

// 计算属性
const stats = computed<SimulationStats>(() => {
  const totalOrders = orders.value.length
  const completedOrders = orders.value.filter(o => o.status === 'completed').length
  const cancelledOrders = orders.value.filter(o => o.status === 'cancelled').length
  
  const totalRevenue = orders.value
    .filter(o => o.status === 'completed')
    .reduce((sum, order) => sum + order.totalAmount, 0)
  
  const platformRevenue = orders.value
    .filter(o => o.status === 'completed')
    .reduce((sum, order) => sum + order.platformFee, 0)
  
  const riderRevenue = orders.value
    .filter(o => o.status === 'completed')
    .reduce((sum, order) => sum + order.deliveryFee, 0)
  
  const supplierRevenue = orders.value
    .filter(o => o.status === 'completed')
    .reduce((sum, order) => {
      const itemsCost = order.items.reduce((cost, item) => {
        const product = products.value.find(p => p.id === item.productId)
        return cost + (product?.purchasePrice || 0) * item.quantity
      }, 0)
      const profit = order.totalAmount - order.deliveryFee - order.platformFee - itemsCost
      return sum + itemsCost + profit
    }, 0)
  
  const purchaseCost = orders.value
    .filter(o => o.status === 'completed')
    .reduce((sum, order) => {
      const itemsCost = order.items.reduce((cost, item) => {
        const product = products.value.find(p => p.id === item.productId)
        return cost + (product?.purchasePrice || 0) * item.quantity
      }, 0)
      return sum + itemsCost
    }, 0)
  
  const totalInvestment = purchaseCost + platformRevenue + riderRevenue
  
  const totalProfit = totalRevenue - totalInvestment
  
  const completedOrderTimes = orders.value
    .filter(o => o.status === 'completed' && o.completedAt)
    .map(o => {
      const created = new Date(o.createdAt).getTime()
      const completed = new Date(o.completedAt!).getTime()
      return (completed - created) / (1000 * 60) // 转换为分钟
    })
  
  const avgDeliveryTime = completedOrderTimes.length > 0
    ? Math.round(completedOrderTimes.reduce((a, b) => a + b, 0) / completedOrderTimes.length)
    : 0
  
  const completionRate = totalOrders > 0
    ? Math.round((completedOrders / totalOrders) * 100)
    : 0

  return {
    totalOrders,
    completedOrders,
    cancelledOrders,
    totalRevenue,
    platformRevenue,
    riderRevenue,
    supplierRevenue,
    purchaseCost,
    totalInvestment,
    totalProfit,
    avgDeliveryTime,
    completionRate
  }
})

const configPreview = computed(() => {
  const dailyBoxCost = advancedConfig.value.boxCost * Math.ceil(stats.value.totalOrders / advancedConfig.value.boxCapacity)
  const dailyRewardCost = stats.value.totalOrders * advancedConfig.value.riderOrderReward
  const marketingBudget = stats.value.totalRevenue * (advancedConfig.value.marketingBudgetRatio / 100)
  
  return {
    dailyBoxCost,
    dailyRewardCost,
    marketingBudget,
    totalDailyCost: dailyBoxCost + dailyRewardCost + marketingBudget
  }
})

const platformProfitPercentage = computed(() => {
  const total = stats.value.platformRevenue + stats.value.riderRevenue + stats.value.supplierRevenue
  return total > 0 ? Math.round((stats.value.platformRevenue / total) * 100) : 0
})

const riderProfitPercentage = computed(() => {
  const total = stats.value.platformRevenue + stats.value.riderRevenue + stats.value.supplierRevenue
  return total > 0 ? Math.round((stats.value.riderRevenue / total) * 100) : 0
})

const supplierProfitPercentage = computed(() => {
  const total = stats.value.platformRevenue + stats.value.riderRevenue + stats.value.supplierRevenue
  return total > 0 ? Math.round((stats.value.supplierRevenue / total) * 100) : 0
})

const activeOrders = computed(() => ({
  pending: orders.value.filter(o => o.status === 'pending'),
  accepted: orders.value.filter(o => o.status === 'accepted'),
  picking: orders.value.filter(o => o.status === 'picking'),
  delivering: orders.value.filter(o => o.status === 'delivering'),
  completed: orders.value.filter(o => o.status === 'completed')
}))

const visibleOrders = computed(() => {
  return [...orders.value]
    .sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime())
    .slice(0, 10)
})

const activeRiders = computed(() => riders.value.slice(0, riderCount.value))

const userStats = computed(() => {
  const customerNames = [...new Set(orders.value.map(o => o.customerName))]
  const completedOrders = orders.value.filter(o => o.status === 'completed')
  const avgOrderValue = completedOrders.length > 0
    ? Math.round(completedOrders.reduce((sum, o) => sum + o.totalAmount, 0) / completedOrders.length)
    : 0
  
  // 计算复购率（简化版）
  const repeatCustomers = customerNames.filter(name => {
    const customerOrders = orders.value.filter(o => o.customerName === name)
    return customerOrders.length > 1
  }).length
  
  const repurchaseRate = customerNames.length > 0
    ? Math.round((repeatCustomers / customerNames.length) * 100)
    : 0

  return {
    activeUsers: customerNames.length,
    avgOrderValue,
    repurchaseRate
  }
})

const deliveryTypes = ref([
  { value: 'day', label: '按天模拟' },
  { value: 'week', label: '按周模拟' },
  { value: 'month', label: '按月模拟' },
  { value: 'slow', label: '慢速 (10秒/订单)' },
  { value: 'normal', label: '正常 (5秒/订单)' },
  { value: 'fast', label: '快速 (2秒/订单)' },
  { value: 'instant', label: '即时 (0.5秒/订单)' }
])

const orderTypeOptions = ref([
  { value: 'delivery', label: '配送 (15分钟达)' },
  { value: 'pickup', label: '自提' }
])

const hourlyRevenue = computed(() => {
  const hours = Array.from({ length: 24 }, (_, i) => ({
    hour: i,
    revenue: Math.floor(Math.random() * 500) + 100
  }))
  return hours
})

const orderDistribution = computed(() => {
  const deliveryOrders = orders.value.filter(o => o.deliveryType === 'delivery').length
  const pickupOrders = orders.value.filter(o => o.deliveryType === 'pickup').length
  return { delivery: deliveryOrders, pickup: pickupOrders }
})

const totalDistribution = computed(() => {
  return orderDistribution.value.delivery + orderDistribution.value.pickup
})

// ========== 方法 ==========
const formatCurrency = (amount: number) => {
  return amount.toFixed(2)
}

const getStatusText = (status: Order['status']) => {
  const statusMap = {
    pending: '待接单',
    accepted: '已接单',
    picking: '备货中',
    delivering: '配送中',
    completed: '已完成',
    cancelled: '已取消'
  }
  return statusMap[status]
}

const getRiderStatus = (status: Rider['status']) => {
  const statusMap = {
    idle: '空闲',
    busy: '忙碌',
    offline: '离线'
  }
  return statusMap[status]
}

const calculateMargin = (product: Product) => {
  return Math.round(((product.salePrice - product.purchasePrice) / product.purchasePrice) * 100)
}

const generateOrder = () => {
  if (!isRunning.value) return

  const customerNames = [
    '张先生', '李女士', '王同学', '赵阿姨', '刘先生',
    '陈小姐', '杨师傅', '周老板', '吴同学', '郑女士'
  ]
  
  const customerName = customerNames[Math.floor(Math.random() * customerNames.length)]
  
  // 随机选择1-3个商品
  const itemCount = Math.floor(Math.random() * 3) + 1
  const selectedProducts: Product[] = []
  
  for (let i = 0; i < itemCount; i++) {
    const availableProducts = products.value.filter(p => p.stock > 0)
    if (availableProducts.length === 0) break
    
    // 根据受欢迎程度加权随机选择
    const totalPopularity = availableProducts.reduce((sum, p) => sum + p.popularity, 0)
    let random = Math.random() * totalPopularity
    
    for (const product of availableProducts) {
      random -= product.popularity
      if (random <= 0) {
        selectedProducts.push(product)
        break
      }
    }
  }
  
  if (selectedProducts.length === 0) return
  
  const orderItems: OrderItem[] = selectedProducts.map(product => {
    const quantity = Math.floor(Math.random() * 3) + 1
    return {
      productId: product.id,
      productName: product.name,
      quantity,
      unitPrice: product.salePrice,
      totalPrice: product.salePrice * quantity
    }
  })
  
  const itemsTotal = orderItems.reduce((sum, item) => sum + item.totalPrice, 0)
  const deliveryFee = newOrderType.value === 'delivery' ? 3 : 0
  const platformFee = itemsTotal * 0.15 // 15%平台佣金
  const totalAmount = itemsTotal + deliveryFee
  
  const order: Order = {
    id: orders.value.length + 1,
    customerName,
    riderId: null,
    riderName: null,
    items: orderItems,
    totalAmount,
    deliveryType: newOrderType.value,
    status: 'pending',
    createdAt: new Date().toLocaleTimeString(),
    completedAt: null,
    deliveryFee,
    platformFee
  }
  
  orders.value.unshift(order)
  addLog(`新订单 #${order.id} 来自 ${customerName}，金额 ¥${totalAmount}`)
  
  // 自动接单逻辑
  setTimeout(() => {
    autoAcceptOrder(order.id)
  }, 1000)
}

const autoAcceptOrder = (orderId: number) => {
  const orderIndex = orders.value.findIndex(o => o.id === orderId)
  if (orderIndex === -1 || orders.value[orderIndex].status !== 'pending') return
  
  // 寻找空闲骑手
  const idleRider = activeRiders.value.find(r => r.status === 'idle')
  if (!idleRider) return
  
  orders.value[orderIndex].status = 'accepted'
  orders.value[orderIndex].riderId = idleRider.id
  orders.value[orderIndex].riderName = idleRider.name
  
  // 更新骑手状态
  const riderIndex = riders.value.findIndex(r => r.id === idleRider.id)
  if (riderIndex !== -1) {
    riders.value[riderIndex].status = 'busy'
  }
  
  addLog(`骑手 ${idleRider.name} 接单 #${orderId}`)
  
  // 开始备货
  setTimeout(() => {
    startPicking(orderId)
  }, getSpeedDelay() * 2)
}

const startPicking = (orderId: number) => {
  const orderIndex = orders.value.findIndex(o => o.id === orderId)
  if (orderIndex === -1 || orders.value[orderIndex].status !== 'accepted') return
  
  orders.value[orderIndex].status = 'picking'
  addLog(`订单 #${orderId} 开始备货`)
  
  // 开始配送
  setTimeout(() => {
    startDelivery(orderId)
  }, getSpeedDelay() * 3)
}

const startDelivery = (orderId: number) => {
  const orderIndex = orders.value.findIndex(o => o.id === orderId)
  if (orderIndex === -1 || orders.value[orderIndex].status !== 'picking') return
  
  orders.value[orderIndex].status = 'delivering'
  addLog(`订单 #${orderId} 开始配送`)
  
  // 完成订单
  setTimeout(() => {
    completeOrder(orderId)
  }, getSpeedDelay() * 5)
}

const completeOrder = (orderId: number) => {
  const orderIndex = orders.value.findIndex(o => o.id === orderId)
  if (orderIndex === -1 || orders.value[orderIndex].status !== 'delivering') return
  
  const order = orders.value[orderIndex]
  order.status = 'completed'
  order.completedAt = new Date().toLocaleTimeString()
  
  // 更新骑手数据
  const riderIndex = riders.value.findIndex(r => r.id === order.riderId)
  if (riderIndex !== -1) {
    riders.value[riderIndex].todayOrders++
    riders.value[riderIndex].todayIncome += order.deliveryFee
    riders.value[riderIndex].status = 'idle'
  }
  
  // 减少库存
  order.items.forEach(item => {
    const productIndex = products.value.findIndex(p => p.id === item.productId)
    if (productIndex !== -1) {
      products.value[productIndex].stock = Math.max(0, products.value[productIndex].stock - item.quantity)
    }
  })
  
  addLog(`订单 #${orderId} 完成，收入 ¥${order.totalAmount}`)
}

const getSpeedDelay = () => {
  switch (simulationSpeed.value) {
    case 'day': return 60000 // 1分钟模拟1天
    case 'week': return 10000 // 10秒模拟1周
    case 'month': return 5000 // 5秒模拟1月
    case 'slow': return 10000
    case 'normal': return 5000
    case 'fast': return 2000
    case 'instant': return 500
    default: return 5000
  }
}

const addRider = () => {
  if (riders.value.length >= 20) return
  
  const newRider: Rider = {
    id: riders.value.length + 1,
    name: `骑手${String.fromCharCode(65 + riders.value.length % 26)}`,
    status: 'idle',
    todayOrders: 0,
    todayIncome: 0,
    efficiency: Math.floor(Math.random() * 5) + 6 // 6-10效率
  }
  
  riders.value.push(newRider)
  addLog(`新增骑手：${newRider.name}`)
}

const removeRider = () => {
  if (riders.value.length <= 1) return
  
  const removedRider = riders.value.pop()
  if (removedRider) {
    addLog(`移除骑手：${removedRider.name}`)
  }
}

const restockProduct = (productId: number) => {
  const productIndex = products.value.findIndex(p => p.id === productId)
  if (productIndex !== -1) {
    products.value[productIndex].stock += 50
    addLog(`为 ${products.value[productIndex].name} 补货 50 件`)
  }
}

const addLog = (message: string) => {
  simulationLogs.value.push({
    time: new Date().toLocaleTimeString(),
    message
  })
  
  // 只保留最近50条日志
  if (simulationLogs.value.length > 50) {
    simulationLogs.value = simulationLogs.value.slice(-50)
  }
}

// 实时数据可视化
const maxDataPoints = 50 // 最多保留50个数据点
const realtimeData = ref({
  revenue: [] as { time: string, value: number }[],
  orders: [] as { time: string, value: number }[],
  profit: [] as { time: string, value: number }[]
})

const updateRealtimeData = (currentStats: SimulationStats) => {
  const now = new Date().toLocaleTimeString()
  
  // 更新收入数据
  realtimeData.value.revenue.push({
    time: now,
    value: currentStats.totalRevenue
  })
  
  // 更新订单数据
  realtimeData.value.orders.push({
    time: now,
    value: currentStats.totalOrders
  })
  
  // 更新收益数据
  realtimeData.value.profit.push({
    time: now,
    value: currentStats.totalProfit
  })
  
  // 限制数据点数量
  const keys: (keyof typeof realtimeData.value)[] = ['revenue', 'orders', 'profit']
  keys.forEach(key => {
    if (realtimeData.value[key].length > maxDataPoints) {
      realtimeData.value[key] = realtimeData.value[key].slice(-maxDataPoints)
    }
  })
}

// 图表配置
const chartOptions = {
  revenue: {
    color: '#4299e1',
    label: '收入趋势',
    unit: '¥'
  },
  orders: {
    color: '#48bb78',
    label: '订单数量',
    unit: '单'
  },
  profit: {
    color: '#ed8936',
    label: '收益趋势',
    unit: '¥'
  }
}

const getChartData = (type: 'revenue' | 'orders' | 'profit') => {
  const data = realtimeData.value[type]
  if (data.length === 0) return []
  
  const maxValue = Math.max(...data.map(d => d.value))
  const minValue = Math.min(...data.map(d => d.value))
  const range = maxValue - minValue || 1
  
  return data.map((point, index) => ({
    x: index,
    y: ((point.value - minValue) / range) * 100, // 归一化到0-100
    value: point.value,
    time: point.time
  }))
}

// 监听统计数据变化，更新实时数据
watch(stats, (currentStats) => {
  if (isRunning.value) {
    updateRealtimeData(currentStats)
  }
}, { deep: true })

// 配置验证方法
const validateConfig = () => {
  const errors: string[] = []
  
  if (advancedConfig.value.boxCost < 0) {
    errors.push('箱体成本不能为负数')
  }
  
  if (advancedConfig.value.boxCapacity < 10 || advancedConfig.value.boxCapacity > 200) {
    errors.push('箱体容量应在10-200之间')
  }
  
  if (advancedConfig.value.fullLoadThreshold < 50 || advancedConfig.value.fullLoadThreshold > 95) {
    errors.push('满载率阈值应在50%-95%之间')
  }
  
  if (advancedConfig.value.dynamicPricingFactor < 0.8 || advancedConfig.value.dynamicPricingFactor > 1.5) {
    errors.push('动态定价系数应在0.8-1.5之间')
  }
  
  if (advancedConfig.value.marketingBudgetRatio < 1 || advancedConfig.value.marketingBudgetRatio > 20) {
    errors.push('营销预算比例应在1%-20%之间')
  }
  
  if (advancedConfig.value.complianceTarget < 80 || advancedConfig.value.complianceTarget > 100) {
    errors.push('合规率目标应在80%-100%之间')
  }
  
  configErrors.value = errors
  return errors.length === 0
}

// 监听配置变化
watch(advancedConfig, () => {
  validateConfig()
}, { deep: true })
const handleFileUpload = (event: Event) => {
  const target = event.target as HTMLInputElement
  if (target.files && target.files[0]) {
    csvFile.value = target.files[0]
  }
}

const exportOrders = () => {
  const csvContent = [
    ['订单ID', '客户姓名', '骑手姓名', '订单金额', '配送费', '平台费', '配送类型', '状态', '创建时间', '完成时间'],
    ...orders.value.map(order => [
      order.id,
      order.customerName,
      order.riderName || '',
      order.totalAmount,
      order.deliveryFee,
      order.platformFee,
      order.deliveryType,
      getStatusText(order.status),
      order.createdAt,
      order.completedAt || ''
    ])
  ].map(row => row.join(',')).join('\n')
  
  downloadCSV(csvContent, 'orders.csv')
  addLog('导出订单数据成功')
}

const exportProducts = () => {
  const csvContent = [
    ['商品ID', '商品名称', '分类', '进货价', '零售价', '库存', '受欢迎程度'],
    ...products.value.map(product => [
      product.id,
      product.name,
      product.category,
      product.purchasePrice,
      product.salePrice,
      product.stock,
      product.popularity
    ])
  ].map(row => row.join(',')).join('\n')
  
  downloadCSV(csvContent, 'products.csv')
  addLog('导出商品数据成功')
}

const exportStats = () => {
  const csvContent = [
    ['指标', '数值'],
    ['总订单数', stats.value.totalOrders],
    ['完成订单数', stats.value.completedOrders],
    ['取消订单数', stats.value.cancelledOrders],
    ['完成率', stats.value.completionRate + '%'],
    ['平均送达时间', stats.value.avgDeliveryTime + '分钟'],
    ['总收入', stats.value.totalRevenue],
    ['采购成本', stats.value.purchaseCost],
    ['项目总投入', stats.value.totalInvestment],
    ['总收益', stats.value.totalProfit],
    ['平台收入', stats.value.platformRevenue],
    ['骑手收入', stats.value.riderRevenue],
    ['供应商收入', stats.value.supplierRevenue],
    ['活跃用户数', userStats.value.activeUsers],
    ['平均订单额', userStats.value.avgOrderValue],
    ['复购率', userStats.value.repurchaseRate + '%']
  ].map(row => row.join(',')).join('\n')
  
  downloadCSV(csvContent, 'stats.csv')
  addLog('导出统计数据成功')
}

const exportAll = () => {
  exportOrders()
  setTimeout(() => exportProducts(), 100)
  setTimeout(() => exportStats(), 200)
  addLog('导出全部数据成功')
}

const downloadCSV = (content: string, filename: string) => {
  const blob = new Blob([content], { type: 'text/csv;charset=utf-8;' })
  const link = document.createElement('a')
  const url = URL.createObjectURL(blob)
  link.setAttribute('href', url)
  link.setAttribute('download', filename)
  link.style.visibility = 'hidden'
  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
}

const importData = async () => {
  if (!csvFile.value) return
  
  try {
    const text = await csvFile.value.text()
    const lines = text.split('\n').filter(line => line.trim())
    
    if (importType.value === 'products') {
      importProducts(lines)
    } else if (importType.value === 'config') {
      importConfig(lines)
    }
    
    addLog(`导入${importType.value === 'products' ? '商品' : '配置'}数据成功`)
  } catch (error) {
    addLog(`导入数据失败: ${error}`)
  }
  
  csvFile.value = null
}

const importProducts = (lines: string[]) => {
  const headers = lines[0].split(',')
  const dataLines = lines.slice(1)
  
  dataLines.forEach(line => {
    const values = line.split(',')
    if (values.length >= 7) {
      const product: Product = {
        id: parseInt(values[0]) || products.value.length + 1,
        name: values[1].trim(),
        category: values[2].trim(),
        purchasePrice: parseFloat(values[3]) || 1,
        salePrice: parseFloat(values[4]) || 2,
        stock: parseInt(values[5]) || 0,
        popularity: parseInt(values[6]) || 5
      }
      
      const existingIndex = products.value.findIndex(p => p.id === product.id)
      if (existingIndex >= 0) {
        products.value[existingIndex] = product
      } else {
        products.value.push(product)
      }
    }
  })
}

const importConfig = (lines: string[]) => {
  lines.forEach(line => {
    const [key, value] = line.split(',').map(s => s.trim())
    if (key && value) {
      switch (key) {
        case 'boxCost':
          advancedConfig.value.boxCost = parseFloat(value) || 5.0
          break
        case 'boxCapacity':
          advancedConfig.value.boxCapacity = parseInt(value) || 100
          break
        case 'fullLoadThreshold':
          advancedConfig.value.fullLoadThreshold = parseInt(value) || 80
          break
        case 'dynamicPricingFactor':
          advancedConfig.value.dynamicPricingFactor = parseFloat(value) || 1.0
          break
        case 'firstOrderReward':
          advancedConfig.value.firstOrderReward = parseFloat(value) || 10
          break
        case 'riderOrderReward':
          advancedConfig.value.riderOrderReward = parseFloat(value) || 2
          break
        case 'referralReward':
          advancedConfig.value.referralReward = parseFloat(value) || 15
          break
        case 'marketingBudgetRatio':
          advancedConfig.value.marketingBudgetRatio = parseFloat(value) || 5
          break
        case 'complianceCheckInterval':
          advancedConfig.value.complianceCheckInterval = parseInt(value) || 15
          break
        case 'violationPenalty':
          advancedConfig.value.violationPenalty = parseFloat(value) || 100
          break
        case 'complianceTarget':
          advancedConfig.value.complianceTarget = parseInt(value) || 95
          break
      }
    }
  })
}

// ========== 模拟控制功能 ==========
const startSimulation = () => {
  if (simulationInterval) {
    clearInterval(simulationInterval)
  }
  
  isRunning.value = true
  addLog('模拟开始')
  
  const baseInterval = simulationSpeed.value === 'day' ? 60000 :
                       simulationSpeed.value === 'week' ? 10000 :
                       simulationSpeed.value === 'month' ? 5000 : 1000
  
  simulationInterval = setInterval(() => {
    if (!isRunning.value) return
    
    // 根据模拟速度调整订单生成率
    let multiplier = 1
    if (simulationSpeed.value === 'day') multiplier = 24 // 一天24倍速
    else if (simulationSpeed.value === 'week') multiplier = 7 * 24 // 一周168倍速
    else if (simulationSpeed.value === 'month') multiplier = 30 * 24 // 一月720倍速
    
    const ordersToGenerate = Math.random() < (orderRate.value * multiplier / 60) ? 1 : 0
    if (ordersToGenerate) {
      generateOrder()
    }
  }, baseInterval)
}

const stopSimulation = () => {
  isRunning.value = false
  if (simulationInterval) {
    clearInterval(simulationInterval)
    simulationInterval = null
  }
  addLog('模拟暂停')
}

const toggleSimulation = () => {
  if (isRunning.value) {
    stopSimulation()
  } else {
    startSimulation()
  }
}

const resetSimulation = () => {
  stopSimulation()
  
  // 重置数据
  orders.value = []
  riders.value = Array.from({ length: riderCount.value }, (_, i) => ({
    id: i + 1,
    name: `骑手${String.fromCharCode(65 + i % 26)}`,
    status: 'idle',
    todayOrders: 0,
    todayIncome: 0,
    efficiency: Math.floor(Math.random() * 5) + 6
  }))
  
  simulationLogs.value = []
  
  // 重置商品库存
  products.value.forEach(product => {
    product.stock = product.stock < 50 ? 100 : product.stock
  })
  
  addLog('模拟已重置')
}

// ========== 生命周期 ==========
onMounted(() => {
  // 初始化骑手
  riders.value = Array.from({ length: riderCount.value }, (_, i) => ({
    id: i + 1,
    name: `骑手${String.fromCharCode(65 + i % 26)}`,
    status: 'idle',
    todayOrders: 0,
    todayIncome: 0,
    efficiency: Math.floor(Math.random() * 5) + 6
  }))
  
  addLog('商业模拟器已启动')
})

onUnmounted(() => {
  stopSimulation()
})

// ========== 监听器 ==========
watch(riderCount, (newVal, oldVal) => {
  if (newVal > oldVal) {
    // 增加骑手
    const toAdd = newVal - oldVal
    for (let i = 0; i < toAdd; i++) {
      addRider()
    }
  } else if (newVal < oldVal) {
    // 减少骑手
    const toRemove = oldVal - newVal
    for (let i = 0; i < toRemove; i++) {
      removeRider()
    }
  }
})

// ========== 多视角功能方法 ==========

// 骑手视角方法
const registerRider = () => {
  if (!riderForm.value.name || !riderForm.value.phone || !riderForm.value.idCard) {
    alert('请填写完整的注册信息')
    return
  }
  
  const newRider: Rider = {
    id: riders.value.length + 1,
    name: riderForm.value.name,
    status: 'idle',
    todayOrders: 0,
    todayIncome: 0,
    efficiency: Math.floor(Math.random() * 5) + 6
  }
  
  riders.value.push(newRider)
  currentRiderProfile.value = newRider
  addLog(`骑手 ${newRider.name} 注册成功`)
  
  // 重置表单
  riderForm.value = { name: '', phone: '', idCard: '' }
}

const rentBox = () => {
  if (!currentRiderProfile.value) return
  
  const newBox = {
    id: Date.now(),
    capacity: advancedConfig.value.boxCapacity,
    currentLoad: 0,
    dailyCost: advancedConfig.value.boxCost
  }
  
  currentRiderProfile.value.box = newBox
  addLog(`骑手 ${currentRiderProfile.value.name} 租用箱体 #${newBox.id}`)
}

const restockBox = () => {
  if (!currentRiderProfile.value?.box) return
  
  // 补货逻辑
  currentRiderProfile.value.box.currentLoad = 0
  addLog(`骑手 ${currentRiderProfile.value.name} 补货完成`)
}

const returnBox = () => {
  if (!currentRiderProfile.value?.box) return
  
  const boxId = currentRiderProfile.value.box.id
  currentRiderProfile.value.box = undefined
  addLog(`骑手 ${currentRiderProfile.value.name} 归还箱体 #${boxId}`)
}

const acceptOrder = (orderId: number) => {
  const orderIndex = orders.value.findIndex(o => o.id === orderId)
  if (orderIndex === -1 || orders.value[orderIndex].status !== 'pending') return
  
  orders.value[orderIndex].status = 'accepted'
  orders.value[orderIndex].riderId = currentRiderProfile.value?.id || 0
  orders.value[orderIndex].riderName = currentRiderProfile.value?.name || ''
  
  if (currentRiderProfile.value) {
    currentRiderProfile.value.status = 'busy'
  }
  
  addLog(`骑手 ${currentRiderProfile.value?.name} 接单 #${orderId}`)
  
  setTimeout(() => {
    startPicking(orderId)
  }, getSpeedDelay() * 2)
}

// 供应商视角方法
const editProduct = (productId: number) => {
  const product = products.value.find(p => p.id === productId)
  if (product) {
    // 这里可以打开编辑模态框
    addLog(`编辑商品: ${product.name}`)
  }
}

const removeProduct = (productId: number) => {
  const index = products.value.findIndex(p => p.id === productId)
  if (index !== -1) {
    const productName = products.value[index].name
    products.value.splice(index, 1)
    addLog(`删除商品: ${productName}`)
  }
}

// 客户视角方法
const getUserLevelText = (level: string) => {
  const levelMap = {
    bronze: '青铜会员',
    silver: '白银会员',
    gold: '黄金会员',
    platinum: '铂金会员'
  }
  return levelMap[level as keyof typeof levelMap] || level
}

const getProductImage = (productName: string) => {
  // 返回商品图片URL（这里使用占位符）
  return `/api/products/${productName}.jpg`
}

const addToCart = (product: Product) => {
  const existingItem = cartItems.value.find(item => item.id === product.id)
  
  if (existingItem) {
    existingItem.quantity += 1
  } else {
    cartItems.value.push({
      id: product.id,
      name: product.name,
      price: product.salePrice,
      quantity: 1
    })
  }
  
  addLog(`添加到购物车: ${product.name}`)
}

const viewProductDetail = (productId: number) => {
  const product = products.value.find(p => p.id === productId)
  if (product) {
    // 这里可以打开商品详情模态框
    addLog(`查看商品详情: ${product.name}`)
  }
}

const updateQuantity = (itemId: number, newQuantity: number) => {
  const item = cartItems.value.find(item => item.id === itemId)
  if (item) {
    if (newQuantity <= 0) {
      removeFromCart(itemId)
    } else {
      item.quantity = newQuantity
    }
  }
}

const removeFromCart = (itemId: number) => {
  const index = cartItems.value.findIndex(item => item.id === itemId)
  if (index !== -1) {
    const itemName = cartItems.value[index].name
    cartItems.value.splice(index, 1)
    addLog(`从购物车移除: ${itemName}`)
  }
}

const checkout = () => {
  if (cartItems.value.length === 0) {
    alert('购物车是空的')
    return
  }
  
  const order: Order = {
    id: orders.value.length + 1,
    customerName: currentUser.value.name,
    riderId: null,
    riderName: null,
    items: cartItems.value.map(item => ({
      productId: item.id,
      productName: item.name,
      quantity: item.quantity,
      unitPrice: item.price,
      totalPrice: item.price * item.quantity
    })),
    totalAmount: cartTotal.value + deliveryFee.value,
    deliveryType: deliveryType.value,
    status: 'pending',
    createdAt: new Date().toLocaleTimeString(),
    completedAt: null,
    deliveryFee: deliveryFee.value,
    platformFee: cartTotal.value * 0.15
  }
  
  orders.value.unshift(order)
  cartItems.value = []
  
  addLog(`${currentUser.value.name} 下单 #${order.id}，金额 ¥${order.totalAmount}`)
  
  // 自动接单逻辑
  setTimeout(() => {
    autoAcceptOrder(order.id)
  }, 1000)
}

const confirmReceipt = (orderId: number) => {
  const orderIndex = orders.value.findIndex(o => o.id === orderId)
  if (orderIndex === -1 || orders.value[orderIndex].status !== 'delivering') return
  
  orders.value[orderIndex].status = 'completed'
  orders.value[orderIndex].completedAt = new Date().toLocaleTimeString()
  
  // 更新骑手数据
  const riderIndex = riders.value.findIndex(r => r.id === orders.value[orderIndex].riderId)
  if (riderIndex !== -1) {
    riders.value[riderIndex].todayOrders++
    riders.value[riderIndex].todayIncome += orders.value[orderIndex].deliveryFee
    riders.value[riderIndex].status = 'idle'
  }
  
  addLog(`订单 #${orderId} 已确认收货`)
}

const reviewOrder = (orderId: number) => {
  addLog(`订单 #${orderId} 已评价`)
}

const reorder = (orderId: number) => {
  const originalOrder = orders.value.find(o => o.id === orderId)
  if (originalOrder) {
    // 将原订单商品重新加入购物车
    originalOrder.items.forEach(item => {
      const product = products.value.find(p => p.id === item.productId)
      if (product && product.stock > 0) {
        addToCart(product)
      }
    })
    addLog(`重新下单: 订单 #${orderId}`)
  }
}
</script>

<style scoped>
.flash-store-simulator {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  max-width: 1400px;
  margin: 0 auto;
  padding: 20px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  color: #333;
}

/* 视角切换器样式 */
.view-switcher {
  background: white;
  border-radius: 12px;
  padding: 20px;
  margin-bottom: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.view-switcher h2 {
  margin: 0 0 20px 0;
  text-align: center;
  color: #2d3748;
  font-size: 24px;
}

.view-tabs {
  display: flex;
  justify-content: center;
  gap: 10px;
  flex-wrap: wrap;
}

.view-tab {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 20px;
  border: 2px solid #e2e8f0;
  border-radius: 8px;
  background: white;
  cursor: pointer;
  transition: all 0.3s;
  font-weight: 500;
}

.view-tab:hover {
  border-color: #4299e1;
  background: #ebf8ff;
}

.view-tab.active {
  border-color: #4299e1;
  background: #4299e1;
  color: white;
}

.view-tab .icon {
  font-size: 18px;
}

.view-tab .label {
  font-size: 14px;
}

/* 平台视角样式 */
.platform-view {
  display: block;
}

/* 骑手视角样式 */
.rider-view {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.rider-dashboard h3 {
  margin: 0 0 20px 0;
  color: #2d3748;
  font-size: 20px;
  text-align: center;
}

.rider-registration {
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
}

.registration-form {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.form-group label {
  font-weight: 500;
  color: #4a5568;
}

.form-group input {
  padding: 8px 12px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 14px;
}

.register-btn {
  background: #48bb78;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-weight: 500;
}

.register-btn:hover {
  background: #38a169;
}

.rider-workspace {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
}

.rider-profile, .box-management, .order-management, .earnings-stats {
  background: #f7fafc;
  padding: 15px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
}

.rider-profile h4, .box-management h4, .order-management h4, .earnings-stats h4 {
  margin: 0 0 15px 0;
  color: #2d3748;
  font-size: 16px;
}

.profile-info, .box-details {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.info-item, .detail-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 14px;
}

.info-item .label, .detail-item .label {
  color: #4a5568;
}

.info-item .value, .detail-item .value {
  font-weight: 600;
  color: #2d3748;
}

.box-actions {
  display: flex;
  gap: 10px;
  margin-top: 15px;
}

.restock-btn, .return-btn, .rent-btn {
  padding: 8px 16px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-weight: 500;
  font-size: 14px;
}

.restock-btn {
  background: #48bb78;
  color: white;
}

.return-btn {
  background: #f56565;
  color: white;
}

.rent-btn {
  background: #4299e1;
  color: white;
}

.order-list {
  max-height: 300px;
  overflow-y: auto;
}

.order-item {
  background: white;
  padding: 10px;
  border-radius: 6px;
  margin-bottom: 10px;
  border: 1px solid #e2e8f0;
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 5px;
  font-size: 14px;
}

.order-details {
  display: flex;
  gap: 15px;
  margin-bottom: 10px;
  font-size: 12px;
  color: #4a5568;
}

.order-actions {
  display: flex;
  gap: 5px;
}

.accept-btn, .pickup-btn, .delivery-btn, .complete-btn {
  padding: 4px 8px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
}

.accept-btn {
  background: #48bb78;
  color: white;
}

.pickup-btn {
  background: #4299e1;
  color: white;
}

.delivery-btn {
  background: #ed8936;
  color: white;
}

.complete-btn {
  background: #38a169;
  color: white;
}

.stats-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10px;
}

.stat-card {
  background: white;
  padding: 10px;
  border-radius: 6px;
  text-align: center;
  border: 1px solid #e2e8f0;
}

.stat-card .label {
  display: block;
  font-size: 12px;
  color: #4a5568;
  margin-bottom: 5px;
}

.stat-card .value {
  font-size: 16px;
  font-weight: 600;
  color: #2d3748;
}

/* 供应商视角样式 */
.supplier-view {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.supplier-dashboard h3 {
  margin: 0 0 20px 0;
  color: #2d3748;
  font-size: 20px;
  text-align: center;
}

.product-management, .revenue-analysis, .order-statistics {
  margin-bottom: 20px;
  padding: 15px;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
}

.product-management h4, .revenue-analysis h4, .order-statistics h4 {
  margin: 0 0 15px 0;
  color: #2d3748;
  font-size: 16px;
}

.product-actions {
  display: flex;
  gap: 10px;
  margin-bottom: 15px;
}

.add-product-btn, .export-btn {
  padding: 8px 16px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-weight: 500;
}

.add-product-btn {
  background: #48bb78;
  color: white;
}

.export-btn {
  background: #4299e1;
  color: white;
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 15px;
}

.product-card {
  background: #f7fafc;
  padding: 15px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
}

.product-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.product-header h5 {
  margin: 0;
  color: #2d3748;
  font-size: 14px;
}

.product-header .category {
  font-size: 12px;
  color: #4a5568;
  background: #e2e8f0;
  padding: 2px 6px;
  border-radius: 4px;
}

.product-pricing, .product-inventory {
  margin-bottom: 10px;
}

.price-item, .inventory-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 5px;
  font-size: 12px;
}

.price-item .label, .inventory-item .label {
  color: #4a5568;
}

.price-item .value, .inventory-item .value {
  font-weight: 600;
  color: #2d3748;
}

.popularity-bar {
  display: flex;
  align-items: center;
  gap: 5px;
}

.popularity-bar .bar {
  height: 4px;
  background: #48bb78;
  border-radius: 2px;
  min-width: 20px;
}

.product-actions {
  display: flex;
  gap: 5px;
}

.edit-btn, .restock-btn, .remove-btn {
  padding: 4px 8px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
}

.edit-btn {
  background: #4299e1;
  color: white;
}

.restock-btn {
  background: #48bb78;
  color: white;
}

.remove-btn {
  background: #f56565;
  color: white;
}

.revenue-summary {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 10px;
  margin-bottom: 15px;
}

.summary-card {
  background: #f7fafc;
  padding: 10px;
  border-radius: 6px;
  text-align: center;
  border: 1px solid #e2e8f0;
}

.summary-card .label {
  display: block;
  font-size: 12px;
  color: #4a5568;
  margin-bottom: 5px;
}

.summary-card .value {
  font-size: 14px;
  font-weight: 600;
  color: #2d3748;
}

.revenue-chart {
  margin-top: 15px;
}

.revenue-chart h5 {
  margin: 0 0 10px 0;
  color: #2d3748;
  font-size: 14px;
}

.mock-chart {
  display: flex;
  align-items: flex-end;
  height: 100px;
  gap: 5px;
  padding: 10px;
  background: #f7fafc;
  border-radius: 6px;
}

.chart-bar {
  flex: 1;
  background: #4299e1;
  border-radius: 2px 2px 0 0;
  position: relative;
  min-height: 10px;
}

.chart-bar .tooltip {
  position: absolute;
  top: -20px;
  left: 50%;
  transform: translateX(-50%);
  font-size: 10px;
  background: #2d3748;
  color: white;
  padding: 2px 4px;
  border-radius: 2px;
  white-space: nowrap;
  opacity: 0;
  transition: opacity 0.2s;
}

.chart-bar:hover .tooltip {
  opacity: 1;
}

/* 客户视角样式 */
.customer-view {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.customer-dashboard h3 {
  margin: 0 0 20px 0;
  color: #2d3748;
  font-size: 20px;
  text-align: center;
}

.user-info, .product-browsing, .shopping-cart, .order-history {
  margin-bottom: 20px;
  padding: 15px;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
}

.user-info h4, .product-browsing h4, .shopping-cart h4, .order-history h4 {
  margin: 0 0 15px 0;
  color: #2d3748;
  font-size: 16px;
}

.info-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 10px;
}

.info-card {
  background: #f7fafc;
  padding: 10px;
  border-radius: 6px;
  text-align: center;
  border: 1px solid #e2e8f0;
}

.info-card .label {
  display: block;
  font-size: 12px;
  color: #4a5568;
  margin-bottom: 5px;
}

.info-card .value {
  font-size: 14px;
  font-weight: 600;
  color: #2d3748;
}

.info-card .value.gold {
  color: #d69e2e;
}

.search-filter {
  display: flex;
  gap: 10px;
  margin-bottom: 15px;
}

.search-input {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 14px;
}

.category-filter {
  padding: 8px 12px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 14px;
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 15px;
}

.product-item {
  background: #f7fafc;
  padding: 15px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
}

.product-image {
  height: 100px;
  background: #e2e8f0;
  border-radius: 6px;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.product-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.product-info h5 {
  margin: 0 0 5px 0;
  color: #2d3748;
  font-size: 14px;
}

.product-info .category {
  font-size: 12px;
  color: #4a5568;
  background: #e2e8f0;
  padding: 2px 6px;
  border-radius: 4px;
  display: inline-block;
  margin-bottom: 10px;
}

.price {
  margin-bottom: 10px;
}

.current-price {
  font-size: 16px;
  font-weight: 600;
  color: #2d3748;
}

.original-price {
  font-size: 12px;
  color: #718096;
  text-decoration: line-through;
  margin-left: 5px;
}

.stock-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
  font-size: 12px;
  color: #4a5568;
}

.product-actions {
  display: flex;
  gap: 5px;
}

.add-to-cart-btn, .detail-btn {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
}

.add-to-cart-btn {
  background: #48bb78;
  color: white;
  flex: 1;
}

.add-to-cart-btn:disabled {
  background: #cbd5e0;
  cursor: not-allowed;
}

.detail-btn {
  background: #4299e1;
  color: white;
}

.cart-items {
  max-height: 300px;
  overflow-y: auto;
  margin-bottom: 15px;
}

.cart-item {
  background: #f7fafc;
  padding: 10px;
  border-radius: 6px;
  margin-bottom: 10px;
  border: 1px solid #e2e8f0;
}

.item-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 5px;
}

.item-quantity {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 5px;
}

.item-quantity button {
  width: 20px;
  height: 20px;
  border: 1px solid #e2e8f0;
  border-radius: 2px;
  background: white;
  cursor: pointer;
  font-size: 12px;
}

.item-total {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.remove-btn {
  background: #f56565;
  color: white;
  border: none;
  border-radius: 2px;
  cursor: pointer;
  font-size: 10px;
  padding: 2px 4px;
}

.empty-cart {
  text-align: center;
  color: #4a5568;
  padding: 20px;
  background: #f7fafc;
  border-radius: 6px;
}

.cart-summary {
  background: #f7fafc;
  padding: 15px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
}

.summary-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
  font-size: 14px;
}

.summary-item.total {
  border-top: 1px solid #e2e8f0;
  padding-top: 10px;
  font-weight: 600;
  font-size: 16px;
}

.checkout-actions {
  display: flex;
  gap: 10px;
  margin-top: 15px;
}

.delivery-type {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 14px;
}

.checkout-btn {
  background: #48bb78;
  color: white;
  padding: 8px 16px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-weight: 500;
}

.checkout-btn:hover {
  background: #38a169;
}

.order-list {
  max-height: 400px;
  overflow-y: auto;
}

.order-actions {
  display: flex;
  gap: 5px;
  margin-top: 10px;
}

.confirm-btn, .review-btn, .reorder-btn {
  padding: 4px 8px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
}

.confirm-btn {
  background: #48bb78;
  color: white;
}

.review-btn {
  background: #ed8936;
  color: white;
}

.reorder-btn {
  background: #4299e1;
  color: white;
}

.control-panel {
  background: white;
  border-radius: 12px;
  padding: 20px;
  margin-bottom: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.panel-section h3 {
  margin: 0 0 15px 0;
  color: #2d3748;
  font-size: 18px;
}

.param-group {
  display: flex;
  gap: 20px;
  align-items: center;
  flex-wrap: wrap;
}

.param {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
}

.param label {
  font-weight: 500;
  color: #4a5568;
}

select, input[type="range"] {
  padding: 6px 12px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  background: white;
  font-size: 14px;
}

button {
  padding: 8px 16px;
  border: none;
  border-radius: 6px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
  font-size: 14px;
}

button.start {
  background: #48bb78;
  color: white;
}

button.start:hover {
  background: #38a169;
}

button.stop {
  background: #f56565;
  color: white;
}

button.stop:hover {
  background: #e53e3e;
}

button.reset {
  background: #4299e1;
  color: white;
}

button.reset:hover {
  background: #3182ce;
}

.dashboard {
  display: grid;
  grid-template-columns: 1fr 2fr 1fr;
  gap: 20px;
  margin-bottom: 20px;
}

.data-card, .order-flow, .role-card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.data-card h4, .order-flow h3, .role-card h4 {
  margin: 0 0 15px 0;
  color: #2d3748;
  font-size: 16px;
}

.stats {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.stat {
  display: flex;
  justify-content: space-between;
  padding: 10px;
  background: #f7fafc;
  border-radius: 8px;
  font-size: 14px;
}

.stat .label {
  color: #4a5568;
}

.stat .value {
  font-weight: 600;
  color: #2d3748;
}

.profit-distribution {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.profit-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  background: #f7fafc;
  border-radius: 8px;
  position: relative;
  overflow: hidden;
  font-size: 14px;
}

.profit-item .bar {
  position: absolute;
  left: 0;
  top: 0;
  height: 100%;
  opacity: 0.2;
  z-index: 0;
}

.profit-item.platform .bar { background: #4299e1; }
.profit-item.rider .bar { background: #48bb78; }
.profit-item.supplier .bar { background: #ed8936; }

.profit-item span {
  position: relative;
  z-index: 1;
}

.flow-stages {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
  padding: 15px;
  background: #f7fafc;
  border-radius: 8px;
}

.stage {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 10px 20px;
  background: white;
  border: 2px solid #e2e8f0;
  border-radius: 8px;
  min-width: 80px;
  transition: all 0.3s;
}

.stage.active {
  border-color: #4299e1;
  background: #ebf8ff;
  box-shadow: 0 2px 4px rgba(66, 153, 225, 0.3);
}

.stage-name {
  font-size: 12px;
  color: #4a5568;
  margin-bottom: 5px;
}

.stage .count {
  font-size: 20px;
  font-weight: 600;
  color: #2d3748;
}

.stage-icon {
  color: #a0aec0;
  font-size: 24px;
}

.order-list {
  max-height: 400px;
  overflow-y: auto;
}

.order-item {
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  padding: 12px;
  margin-bottom: 10px;
  transition: all 0.2s;
}

.order-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.order-item.pending {
  border-left: 4px solid #e53e3e;
}

.order-item.accepted {
  border-left: 4px solid #4299e1;
}

.order-item.picking {
  border-left: 4px solid #ed8936;
}

.order-item.delivering {
  border-left: 4px solid #d69e2e;
}

.order-item.completed {
  border-left: 4px solid #48bb78;
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
  font-size: 14px;
}

.order-id {
  font-weight: 600;
  color: #2d3748;
}

.order-time {
  color: #718096;
  font-size: 12px;
}

.order-status {
  padding: 2px 8px;
  background: #f7fafc;
  border-radius: 12px;
  font-size: 12px;
}

.order-details {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 14px;
}

.role-card .user-stats,
.role-card .rider-list {
  margin-bottom: 15px;
  font-size: 14px;
}

.rider-item {
  padding: 10px;
  background: #f7fafc;
  border-radius: 8px;
  margin-bottom: 8px;
}

.rider-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 5px;
}

.rider-info .name {
  font-weight: 500;
}

.rider-info .status {
  font-size: 12px;
  padding: 2px 8px;
  border-radius: 12px;
}

.status.idle {
  background: #c6f6d5;
  color: #22543d;
}

.status.busy {
  background: #fed7d7;
  color: #742a2a;
}

.rider-stats {
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color: #4a5568;
}

.user-actions, .rider-actions {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.order-types {
  display: flex;
  gap: 15px;
  margin-top: 10px;
  font-size: 14px;
}

.order-types label {
  display: flex;
  align-items: center;
  gap: 5px;
  cursor: pointer;
}

.product-panel {
  background: white;
  border-radius: 12px;
  padding: 20px;
  margin-bottom: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.products {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 15px;
}

.product-item {
  padding: 15px;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.product-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 14px;
}

.product-info .name {
  font-weight: 500;
}

.product-info .category {
  font-size: 12px;
  color: #718096;
  background: #f7fafc;
  padding: 2px 8px;
  border-radius: 12px;
}

.product-pricing {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 14px;
}

.price-input {
  display: flex;
  align-items: center;
  gap: 5px;
}

.price-input input {
  width: 70px;
  padding: 4px 8px;
  border: 1px solid #e2e8f0;
  border-radius: 4px;
  text-align: right;
}

.margin {
  font-weight: 500;
  color: #48bb78;
}

.product-stock {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 14px;
}

.product-stock input {
  width: 60px;
  padding: 4px 8px;
  border: 1px solid #e2e8f0;
  border-radius: 4px;
}

.restock {
  padding: 4px 8px;
  font-size: 12px;
  background: #4299e1;
  color: white;
}

.charts {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
  margin-bottom: 20px;
}

.chart-container {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.chart-placeholder {
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.mock-chart {
  display: flex;
  align-items: flex-end;
  gap: 10px;
  height: 150px;
  width: 100%;
  padding: 20px 0;
}

.chart-bar {
  flex: 1;
  background: linear-gradient(to top, #4299e1, #667eea);
  border-radius: 4px 4px 0 0;
  position: relative;
  min-height: 20px;
}

.chart-bar .tooltip {
  position: absolute;
  top: -25px;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(0, 0, 0, 0.8);
  color: white;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 10px;
  white-space: nowrap;
  opacity: 0;
  transition: opacity 0.2s;
}

.chart-bar:hover .tooltip {
  opacity: 1;
}

.pie-chart {
  position: relative;
  width: 150px;
  height: 150px;
  border-radius: 50%;
  background: conic-gradient(
    var(--color, #000) 0% calc(var(--percentage, 0) * 1%),
    #e2e8f0 calc(var(--percentage, 0) * 1%) 100%
  );
}

.pie-label {
  position: absolute;
  top: 50%;
  right: -120px;
  transform: translateY(-50%);
  font-size: 14px;
}

.dot {
  display: inline-block;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  margin-right: 5px;
}

.dot.delivery { background: #4CAF50; }
.dot.pickup { background: #2196F3; }

/* 数据导入导出面板样式 */
.data-io-panel {
  background: white;
  border-radius: 12px;
  padding: 20px;
  margin-bottom: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.data-io-panel h3 {
  margin: 0 0 20px 0;
  color: #2d3748;
  font-size: 18px;
}

.io-sections {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 30px;
}

@media (max-width: 768px) {
  .io-sections {
    grid-template-columns: 1fr;
    gap: 20px;
  }
}

.io-section h4 {
  margin: 0 0 15px 0;
  color: #4a5568;
  font-size: 16px;
}

.export-buttons {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10px;
}

@media (max-width: 480px) {
  .export-buttons {
    grid-template-columns: 1fr;
  }
}

.export-btn {
  background: #4299e1;
  color: white;
  padding: 10px 16px;
  font-size: 14px;
}

.export-btn:hover {
  background: #3182ce;
}

.export-btn.primary {
  background: #48bb78;
  grid-column: 1 / -1;
}

.export-btn.primary:hover {
  background: #38a169;
}

.import-controls {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.file-input {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.file-input label {
  font-weight: 500;
  color: #4a5568;
}

.file-input input[type="file"] {
  padding: 8px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 14px;
}

.import-options {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
}

@media (max-width: 480px) {
  .import-options {
    flex-direction: column;
    gap: 10px;
  }
}

.import-options label {
  display: flex;
  align-items: center;
  gap: 5px;
  cursor: pointer;
  font-size: 14px;
}

.import-btn {
  background: #ed8936;
  color: white;
  padding: 10px 16px;
  font-size: 14px;
}

.import-btn:hover:not(:disabled) {
  background: #dd6b20;
}

.import-btn:disabled {
  background: #a0aec0;
  cursor: not-allowed;
}

/* 高级配置面板样式 */
.advanced-config {
  background: white;
  border-radius: 12px;
  padding: 20px;
  margin-bottom: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.advanced-config h3 {
  margin: 0 0 20px 0;
  color: #2d3748;
  font-size: 18px;
}

.config-sections {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 25px;
}

.config-section h4 {
  margin: 0 0 15px 0;
  color: #4a5568;
  font-size: 16px;
  border-bottom: 2px solid #e2e8f0;
  padding-bottom: 8px;
}

.config-items {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.config-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 12px;
  background: #f7fafc;
  border-radius: 6px;
  font-size: 14px;
}

.config-item label {
  min-width: 140px;
}

.config-item input[type="number"] {
  width: 100px;
  padding: 6px 8px;
  border: 1px solid #e2e8f0;
  border-radius: 4px;
  text-align: right;
  font-size: 14px;
}

.config-item.error input[type="number"] {
  border-color: #f56565;
  background-color: #fff5f5;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.config-item.error label {
  color: #f56565;
}

.config-errors {
  background: #fff5f5;
  border: 1px solid #feb2b2;
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 20px;
}

.config-errors h4 {
  margin: 0 0 10px 0;
  color: #c53030;
  font-size: 16px;
}

.config-errors ul {
  margin: 0;
  padding-left: 20px;
  color: #e53e3e;
}

.config-preview {
  background: #f0fff4;
  border: 1px solid #9ae6b4;
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 20px;
}

.config-preview h4 {
  margin: 0 0 15px 0;
  color: #22543d;
  font-size: 16px;
}

.preview-items {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 10px;
}

.preview-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 12px;
  background: white;
  border-radius: 6px;
  font-size: 14px;
}

.preview-item.total {
  background: #e6fffa;
  border: 1px solid #81e6d9;
  font-weight: 600;
}

.preview-item .label {
  color: #4a5568;
}

.preview-item .value {
  font-weight: 500;
  color: #2d3748;
}

.preview-item.total .value {
  color: #00897b;
}

.log-list {
  height: 200px;
  overflow-y: auto;
  background: #1a202c;
  border-radius: 8px;
  padding: 15px;
  font-family: 'Courier New', monospace;
  font-size: 12px;
}

.log-item {
  display: flex;
  gap: 15px;
  margin-bottom: 8px;
  color: #a0aec0;
}

.log-item .log-time {
  color: #48bb78;
  min-width: 80px;
}

.log-item .log-message {
  color: #e2e8f0;
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .dashboard {
    grid-template-columns: 1fr;
  }
  
  .products {
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  }
  
  .charts {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .control-panel {
    padding: 15px;
  }
  
  .param-group {
    flex-direction: column;
    align-items: stretch;
  }
  
  .param {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .flow-stages {
    flex-wrap: wrap;
    gap: 10px;
  }
  
  .stage-icon {
    display: none;
  }
  
  .products {
    grid-template-columns: 1fr;
  }
  
  .pie-label {
    position: static;
    margin-top: 20px;
  }
  
  .pie-chart {
    margin: 0 auto;
  }
}
</style>