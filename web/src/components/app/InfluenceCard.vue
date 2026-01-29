<template>
  <div class="influence-card" :class="`influence-${color}`">
    <div class="influence-header">
      <span class="influence-icon">{{ icon }}</span>
      <h4>{{ title }}</h4>
    </div>
    <div class="influence-score">
      <span class="score">{{ score }}</span>
      <span class="score-label">影响力评分</span>
    </div>
    <div class="influence-metrics">
      <div 
        v-for="metric in metrics" 
        :key="metric.label"
        class="metric-item"
      >
        <span class="metric-label">{{ metric.label }}</span>
        <span class="metric-value">{{ metric.value.toLocaleString() }}</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  title: string
  score: number
  metrics: Array<{ label: string; value: number }>
  color: string
  icon: string
}>()
</script>

<style scoped>
.influence-card {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  padding: 1.5rem;
  transition: all 0.3s ease;
}

.influence-card:hover {
  transform: translateY(-4px);
  background: rgba(255, 255, 255, 0.08);
}

.influence-blue { border-left: 4px solid #2196F3; }
.influence-green { border-left: 4px solid #4CAF50; }
.influence-orange { border-left: 4px solid #FF9800; }
.influence-purple { border-left: 4px solid #9C27B0; }

.influence-header {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 1rem;
}

.influence-icon {
  font-size: 1.5rem;
}

.influence-header h4 {
  margin: 0;
  font-size: 1.125rem;
  color: white;
}

.influence-score {
  margin-bottom: 1rem;
}

.score {
  font-size: 2.5rem;
  font-weight: bold;
  color: white;
  display: block;
  line-height: 1;
}

.score-label {
  font-size: 0.875rem;
  color: #a0a0a0;
}

.influence-metrics {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.metric-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.5rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 6px;
}

.metric-label {
  font-size: 0.875rem;
  color: #a0a0a0;
}

.metric-value {
  font-weight: 500;
  color: white;
}
</style>