import createAxios from '/@/utils/axios'

export const requirementUrl = '/api/requirement/'

export function getRequirementDetail(id: number | string) {
    return createAxios({
        url: requirementUrl + 'detail',
        method: 'GET',
        params: { id },
    })
}

export function findRequirementByContact(contact: string) {
    return createAxios({
        url: requirementUrl + 'findByContact',
        method: 'GET',
        params: { contact },
    })
}
