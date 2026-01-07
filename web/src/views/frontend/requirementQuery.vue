<template>
    <div class="page">
        <nav>
            <div class="logo-group" @click="goHome">
                <img class="logo-img" src="/@/assets/indieclub-icon.png" alt="Logo" />
                <div class="logo-text">创乐坊 <span>AI WORKS</span></div>
            </div>
            <div>
                <span class="user-class">QUERY</span>
            </div>
        </nav>

        <section class="content">
            <div class="card">
                <h1 class="title">查询我的需求</h1>
                <div class="desc">请输入提交需求时填写的联系方式（微信号/手机/邮箱），用于查询最新一条需求。</div>

                <div class="form">
                    <input v-model.trim="contact" class="input" placeholder="联系方式" />
                    <button class="btn primary" :disabled="loading" @click="onSearch">查询</button>
                </div>

                <div v-if="error" class="error">{{ error }}</div>
            </div>
        </section>

        <footer>
            <p>Copyright © 2023 Chuang Le Fang Co-Lab. All Rights Reserved.</p>
        </footer>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { findRequirementByContact } from '/@/api/frontend/requirement'

const router = useRouter()
const contact = ref('')
const loading = ref(false)
const error = ref('')

const goHome = () => router.push('/')

const onSearch = async () => {
    error.value = ''
    if (!contact.value) {
        error.value = '请填写联系方式'
        return
    }

    loading.value = true
    try {
        const res = await findRequirementByContact(contact.value)
        const id = res.data?.id
        if (!id) {
            error.value = '未找到相关需求'
            return
        }
        router.push(`/requirement/${id}`)
    } catch (e: any) {
        error.value = e?.message || '查询失败，请稍后再试'
    } finally {
        loading.value = false
    }
}
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
    width: min(820px, 96vw);
    background: var(--card-bg);
    border: 1px solid rgba(0, 243, 255, 0.3);
    box-shadow: 0 0 15px rgba(0, 243, 255, 0.15);
    padding: 24px;
}

.title {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.8rem;
    margin-bottom: 10px;
}

.desc {
    color: #cbd5e1;
    margin-bottom: 18px;
    line-height: 1.6;
}

.form {
    display: flex;
    gap: 12px;
}

.input {
    flex: 1;
    padding: 10px 12px;
    background: rgba(255, 255, 255, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.25);
    color: #fff;
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

.error {
    margin-top: 14px;
    color: #ff6b6b;
}

footer {
    opacity: 0.7;
    text-align: center;
    padding: 30px 10px;
}
</style>
