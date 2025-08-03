export const URL_BASE = 'https://api.blacksystem.mx/'

export const headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'access-token': localStorage.getItem('authToken'),
}

//Membresias
export const getmembershiplist = 'memberships/getmembershiplist'

//Usuarios
export const createaccount = 'user/createaccount'
export const login = 'user/login'
export const profile = 'profile/'
export const users = 'users/'
export const adduser = 'users/user/add/'
export const user = 'users/user/'

//Pagos Membresias
export const payment = 'payment/'

//Empresa Info
export const bankaccounts = 'company/bankaccounts'
export const clasifications = 'company/clasifications'
export const addregistry = 'company/addregistry'
export const updateregistry = 'company/updateregistry'
export const getregistries = 'company/registries/'
export const registry = 'company/registry/'
export const deleteregistry = 'company/deleteregistry/'
export const addaccount = 'company/bankaccounts/addbankaccount'
export const updateaccount = 'company/bankaccounts/'
export const bankaccount = 'company/bankaccount/'
export const subclasifications = 'company/subclasifications'
export const subclasification = 'company/subclasification/'
export const collection = 'company/collections'
export const collections = 'company/collection/payment'
export const collectionByDate = 'company/collections/bydate'
