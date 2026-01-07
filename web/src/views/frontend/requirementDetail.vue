<template>
    <div class="page">
        <nav>
            <div class="logo-group" @click="goHome">
                <img class="logo-img" src="/@/assets/indieclub-icon.png" alt="Logo" />
                <div class="logo-text">创乐坊 <span>AI WORKS</span></div>
            </div>
            <div>
                <span class="user-class">REQUIREMENT</span>
            </div>
        </nav>

        <section class="content">
            <div class="card">
                <h1 class="title">需求提交结果</h1>

                <div v-if="loading" class="muted">加载中...</div>
                <div v-else-if="error" class="error">{{ error }}</div>
                <div v-else class="info">
                    <div class="row"><span class="k">需求ID</span><span class="v">{{ detail.id }}</span></div>
                    <div class="row"><span class="k">支付状态</span><span class="v">{{ detail.pay_status === 1 ? '已支付' : '未支付/待确认' }}</span></div>
                    <div class="row"><span class="k">支付金额</span><span class="v">￥{{ detail.payment_amount ?? '-' }}</span></div>
                    <div class="row"><span class="k">支付方式</span><span class="v">{{ detail.payment_method || '-' }}</span></div>
                    <div class="row"><span class="k">需求类型</span><span class="v">{{ detail.requirement_type || '-' }}</span></div>
                    <div class="row"><span class="k">联系方式</span><span class="v">{{ detail.contact_info }}</span></div>
                    <div class="row"><span class="k">需求详细</span><span class="v pre">{{ detail.requirement_content }}</span></div>

                    <div class="actions">
                        <button class="btn" @click="goHome">返回首页</button>
                        <button class="btn primary" @click="goProduct">继续提交需求</button>
                    </div>
                </div>
            </div>
        </section>

        <footer>
            <p>Copyright © 2023 Chuang Le Fang Co-Lab. All Rights Reserved.</p>
        </footer>
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getRequirementDetail } from '/@/api/frontend/requirement'

const route = useRoute()
const router = useRouter()

const loading = ref(true)
const error = ref('')
const detail = ref<any>({})

const goHome = () => router.push('/')
const goProduct = () => router.push('/product')

onMounted(async () => {
    const id = String(route.params.id || '')
    if (!id) {
        error.value = '缺少需求ID'
        loading.value = false
        return
    }

    try {
        const res = await getRequirementDetail(id)
        detail.value = res.data
    } catch (e: any) {
        error.value = e?.message || '加载失败'
    } finally {
        loading.value = false
    }
})
</script>

<style scoped>
:root {
    --neon-cyan: #00f3ff;
    --gold: #ffd700;
    --bg-dark: #050505;
    --card-bg: rgba(20, 20, 30, 0.85);
}

.page {
    background-color: var(--bg-dark);
    color: #fff;
    min-height: 100vh;
    background-image: url('https://images.unsplash.com/photo-1511512578047-dfb367046420?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
}

nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 5%;
    background: rgba(5, 5, 10, 0.9);
    border-bottom: 2px solid var(--neon-cyan);
    position: fixed;
    width: 100%;
    z-index: 1000;
    backdrop-filter: blur(10px);
}

.logo-group {
    display: flex;
    align-items: center;
    gap: 15px;
    cursor: pointer;
}

.logo-img {
    width: 28px;
    height: 28px;
    border-radius: 4px;
    object-fit: contain;
}

.logo-text {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.5rem;
    font-weight: 800;
    letter-spacing: 2px;
    color: #fff;
    text-transform: uppercase;
}

.logo-text span {
    color: var(--neon-cyan);
}

.user-class {
    font-size: 0.8rem;
    color: var(--gold);
    border: 1px solid var(--gold);
    padding: 2px 8px;
    border-radius: 4px;
    background: rgba(255, 215, 0, 0.1);
}

.content {
    padding: 120px 20px 40px;
    display: flex;
    justify-content: center;
}

.card {
    width: min(920px, 96vw);
    background: var(--card-bg);
    border: 1px solid rgba(0, 243, 255, 0.3);
    box-shadow: 0 0 15px rgba(0, 243, 255, 0.15);
    padding: 24px;
}

.title {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.8rem;
    margin-bottom: 16px;
}

.info {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.row {
    display: grid;
    grid-template-columns: 120px 1fr;
    gap: 16px;
    padding: 10px 0;
    border-bottom: 1px dashed rgba(255, 255, 255, 0.15);
}

.k {
    color: #cbd5e1;
}

.v {
    color: #fff;
    word-break: break-word;
}

.pre {
    white-space: pre-wrap;
}

.muted {
    color: #cbd5e1;
}

.error {
    color: #ff6b6b;
}

.actions {
    display: flex;
    gap: 12px;
    margin-top: 18px;
}

.btn {
    padding: 10px 14px;
    background: rgba(255, 255, 255, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.2);
    color: #fff;
    cursor: pointer;
}

.btn.primary {
    background: linear-gradient(90deg, var(--neon-cyan), #00a8ff);
    border: none;
    color: #000;
    font-weight: 700;
}

footer {
    opacity: 0.7;
    text-align: center;
    padding: 30px 10px;
}
</style>
