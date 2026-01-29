<template>
  <div 
    class="metric-card" 
    :class="`metric-${color}`"
    @click="$emit('click')"
  >
    <div class="metric-header">
      <span class="metric-icon">{{ icon }}</span>
      <span class="metric-title">{{ title }}</span>
    </div>
    <div class="metric-value">
      <span class="value">{{ value }}</span>
      <span class="unit">{{ unit }}</span>
    </div>
    <div class="metric-trend" :class="`trend-${trend}`">
      <span class="trend-icon">{{ trendIcon }}</span>
      <span class="trend-label">{{ trendLabel }}</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  title: string
  value: number
  unit: string
  trend: string
  color: string
  icon: string
}>()

defineEmits(['click'])

const trendIcon = computed(() => {
  switch (props.trend) {
    case 'up': return '↗'
    case 'down': return '↘'
    case 'stable': return '→'
    default: return '➡'
  }
})

const trendLabel = computed(() => {
  switch (props.trend) {
    case 'up': return '上升中'
    case 'down': return '下降中'
    case 'stable': return '稳定'
    default: return '—'
  }
})
</script>

<style scoped>
.metric-card {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  padding: 1.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.metric-card:hover {
  transform: translateY(-4px);
  background: rgba(255, 255, 255, 0.08);
  border-color: currentColor;
}

.metric-green:hover { border-color: #4CAF50; }
.metric-blue:hover { border-color: #2196F3; }
.metric-purple:hover { border-color: #9C27B0; }
.metric-orange:hover { border-color: #FF9800; }
.metric-teal:hover { border-color: #00BCD4; }

.metric-header {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.metric-icon {
  font-size: 1.5rem;
}

.metric-title {
  font-size: 0.875rem;
  color: #a0a0a0;
}

.metric-value {
  margin-bottom: 0.5rem;
}

.value {
  font-size: 2rem;
  font-weight: bold;
  color: white;
}

.unit {
  font-size: 1rem;
  color: #a0a0a0;
  margin-left: 0.25rem;
}

.metric-trend {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.875rem;
  padding: 0.25rem 0.75rem;
  border-radius: 1rem;
  display: inline-flex;
}

.trend-up {
  background: rgba(76, 175, 80, 0.2);
  color: #4CAF50;
}

.trend-down {
  background: rgba(244, 67, 54, 0.2);
  color: #F44336;
}

.trend-stable {
  background: rgba(255, 193, 7, 0.2);
  color: #FFC107;
}
</style>