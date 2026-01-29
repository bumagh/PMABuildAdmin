<template>
  <div class="metric-box" :class="`status-${status}`">
    <div class="metric-name">{{ name }}</div>
    <div class="metric-value">
      <span class="value">{{ value }}</span>
      <span class="unit">{{ unit }}</span>
    </div>
    <div class="metric-trend" v-if="trend">
      <span class="trend-icon">{{ getTrendIcon(trend) }}</span>
    </div>
    <div class="metric-description" v-if="description">{{ description }}</div>
  </div>
</template>

<script setup lang="ts">
interface Props {
  name: string
  value: string | number
  unit: string
  status: string
  trend?: string
  description?: string
}

defineProps<Props>()

const getTrendIcon = (trend: string) => {
  switch (trend) {
    case 'up': return '↗'
    case 'down': return '↘'
    case 'stable': return '→'
    default: return '·'
  }
}
</script>

<style scoped>
.metric-box {
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  border: 2px solid transparent;
  position: relative;
  overflow: hidden;
}

.status-excellent {
  border-color: rgba(76, 175, 80, 0.5);
  background: linear-gradient(135deg, rgba(76, 175, 80, 0.1), transparent);
}

.status-good {
  border-color: rgba(33, 150, 243, 0.5);
  background: linear-gradient(135deg, rgba(33, 150, 243, 0.1), transparent);
}

.status-optimal {
  border-color: rgba(156, 39, 176, 0.5);
  background: linear-gradient(135deg, rgba(156, 39, 176, 0.1), transparent);
}

.metric-name {
  font-size: 0.875rem;
  color: #a0a0a0;
  margin-bottom: 0.5rem;
}

.metric-value {
  display: flex;
  align-items: baseline;
  gap: 0.25rem;
}

.value {
  font-size: 1.5rem;
  font-weight: bold;
  color: white;
}

.unit {
  font-size: 0.875rem;
  color: #a0a0a0;
}

.metric-trend {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.875rem;
}

.status-excellent .metric-trend {
  background: rgba(76, 175, 80, 0.2);
  color: #4CAF50;
}

.status-good .metric-trend {
  background: rgba(33, 150, 243, 0.2);
  color: #2196F3;
}

.status-optimal .metric-trend {
  background: rgba(156, 39, 176, 0.2);
  color: #9C27B0;
}

.metric-description {
  margin-top: 0.5rem;
  font-size: 0.75rem;
  color: #666;
}
</style>