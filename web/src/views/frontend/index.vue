<template>
    <div>
        <Header />
        <el-container class="container">
            <el-main class="main">
                <div class="main-container">
                    <div class="main-left">
                        <div class="main-title">{{ siteConfig.siteName }}</div>
                        <div class="main-content">
                            {{ $t( 'index.Steve Jobs' ) }}
                        </div>

                        <div class="card-container">
                            <div @click="$router.push( '/product' )" class="service-card">
                                <div class="card-title">通用产品介绍</div>
                            </div>
                            <div @click="$router.push( '/marbleking' )" class="service-card">
                                <div class="card-title">校园弹珠游戏</div>
                            </div>
                            <div @click="$router.push( '/value' )" class="service-card">
                                <div class="card-title">瓦路Value去中心化平台</div>
                            </div>
                            <div @click="$router.push( '/miniapp' )" class="service-card">
                                <div class="card-title">小游戏小程序孵化</div>
                            </div>
                            <div @click="$router.push( '/petto' )" class="service-card">
                                <div class="card-title">宠物服务到家</div>
                            </div>
                            <div @click="$router.push( '/flashstock' )" class="service-card">
                                <div class="card-title">闪仓副业</div>
                            </div>
                            <div @click="$router.push( '/requirement' )" class="service-card">
                                <div class="card-title">查询需求</div>
                            </div>
                            <div @click="$router.push( '/workai' )" class="service-card">
                                <div class="card-title">沃客AI</div>
                            </div>
                            <div @click="$router.push( '/quantumboard' )" class="service-card">
                                <div class="card-title">量子板</div>
                            </div>
                            <div @click="$router.push( '/dreamxai' )" class="service-card">
                                <div class="card-title">创梦AI</div>
                            </div>
                            <div @click="$router.push( '/decisionai' )" class="service-card">
                                <div class="card-title">决策AI</div>
                            </div>
                            <div v-if=" memberCenter.state.open " @click="$router.push( memberCenterBaseRoutePath )" class="service-card">
                                <div class="card-title">{{ $t( 'Member Center' ) }}</div>
                            </div>
                        </div>

                        <!-- <el-button
                            @click="onPayTest"
                            class="container-button"
                            color="#ffffff"
                            size="large"
                            :loading="payTesting"
                        >
                            1元支付测试
                        </el-button> -->
                    </div>
                    <div class="main-right">
                        <img :src=" indexCover " alt="" />
                    </div>
                </div>
            </el-main>
        </el-container>
        <Footer />
    </div>
</template>

<script setup lang="ts">
import indexCover from '/@/assets/index/index-cover.svg'
import { useSiteConfig } from '/@/stores/siteConfig'
import { useMemberCenter } from '/@/stores/memberCenter'
import Header from '/@/layouts/frontend/components/header.vue'
import Footer from '/@/layouts/frontend/components/footer.vue'
import { memberCenterBaseRoutePath } from '/@/router/static/memberCenterBase'
import { payTest } from '/@/api/frontend/payworld'
import { ref } from 'vue'

const siteConfig = useSiteConfig()
const memberCenter = useMemberCenter()

const payTesting = ref( false )

function submitForm ( url: string, params: Record<string, any> )
{
    const form = document.createElement( 'form' )
    form.method = 'POST'
    form.action = url
    form.style.display = 'none'

    Object.keys( params || {} ).forEach( ( key ) =>
    {
        const input = document.createElement( 'input' )
        input.type = 'hidden'
        input.name = key
        input.value = String( ( params as any )[ key ] ?? '' )
        form.appendChild( input )
    } )

    document.body.appendChild( form )
    form.submit()
    document.body.removeChild( form )
}

const onPayTest = async () =>
{
    payTesting.value = true
    try
    {
        const res = await payTest( { money: 1, type: 'wxpay', name: '支付测试(1元)' } )
        // res.data: { method, url, params }
        submitForm( res.data.url, res.data.params )
    } finally
    {
        payTesting.value = false
    }
}
</script>

<style scoped lang="scss">
.card-container {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    margin-top: 20px;
}

.service-card {
    background: rgba(255, 255, 255, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 8px;
    padding: 20px 15px;
    min-width: 160px;
    flex: 1 1 calc(33.333% - 10px);
    cursor: pointer;
    transition: all 0.3s ease;
    text-align: center;
    backdrop-filter: blur(10px);
    
    &:hover {
        background: rgba(255, 255, 255, 0.2);
        border-color: rgba(255, 255, 255, 0.4);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }
    
    .card-title {
        color: var(--el-color-white);
        font-size: 14px;
        font-weight: 500;
        line-height: 1.4;
    }
}

.container {
    width: 100vw;
    height: 100vh;
    background: url(/@/assets/bg.jpg) repeat;
    color: var(--el-color-white);

    .main {
        height: calc(100vh - 120px);
        padding: 0;

        .main-container {
            display: flex;
            height: 100%;
            width: 66%;
            margin: 0 auto;
            align-items: center;
            justify-content: space-between;

            .main-left {
                padding-right: 50px;

                .main-title {
                    font-size: 45px;
                }

                .main-content {
                    padding-top: 20px;
                    padding-bottom: 40px;
                    font-size: var(--el-font-size-large);
                }
            }

            .main-right {
                img {
                    width: 380px;
                }
            }
        }
    }
}

.header {
    background-color: transparent !important;
    box-shadow: none !important;
    position: fixed;
    width: 100%;

    :deep(.header-logo) {
        span {
            padding-left: 4px;
            color: var(--el-color-white);
        }
    }

    :deep(.frontend-header-menu) {
        background: transparent;

        .el-menu-item,
        .el-sub-menu .el-sub-menu__title {
            color: var(--el-color-white);

            &.is-active {
                color: var(--el-color-white) !important;
            }

            &:hover {
                background-color: transparent !important;
                color: var(--el-menu-hover-text-color);
            }
        }
    }
}

.footer {
    color: var(--el-text-color-secondary);
    background-color: transparent !important;
    position: fixed;
    bottom: 0;
}

@media screen and (max-width: 1024px) {
    .container {
        .main {
            height: unset;
        }
    }

    .main-container {
        width: 90% !important;
        flex-wrap: wrap;
        align-content: center;
        justify-content: center !important;

        .main-right {
            padding-top: 50px;
        }
    }
    
    .service-card {
        flex: 1 1 calc(50% - 10px);
        min-width: 140px;
    }
}

@media screen and (max-width: 768px) {
    .service-card {
        flex: 1 1 100%;
        min-width: unset;
    }
}

@media screen and (max-width: 375px) {
    .main-right img {
        width: 300px !important;
    }
}

@media screen and (max-height: 650px) {
    .main-right img {
        display: none;
    }
}

@at-root html.dark {
    .container {
        background: url(/@/assets/bg-dark.jpg) repeat;
    }
}
</style>
