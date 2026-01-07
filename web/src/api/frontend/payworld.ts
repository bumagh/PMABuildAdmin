import createAxios from '/@/utils/axios'

export const payworldUrl = '/api/payworld/'

export function payTest(data?: {
    money?: string | number
    type?: 'alipay' | 'wxpay' | 'qqpay' | 'bank'
    name?: string
    param?: string
}) {
    return createAxios({
        url: payworldUrl + 'payTest',
        method: 'POST',
        data: {
            money: data?.money ?? 1,
            type: data?.type ?? 'alipay',
            name: data?.name ?? '支付测试(1元)',
            param: data?.param ?? '',
        },
    })
}
