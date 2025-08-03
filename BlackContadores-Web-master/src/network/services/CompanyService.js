import axios from 'axios'
import Vue from 'vue'
import VueAxios from 'vue-axios'
import { URL_BASE, bankaccounts, bankaccount, clasifications, addregistry, 
        getregistries, registry, updateregistry, deleteregistry, addaccount, 
        updateaccount, subclasifications, subclasification, collection, collections, collectionByDate } from '../api'
import handlererroapi from '../handlererroapi'

Vue.use(VueAxios, axios)

export default class CompanyService {

    constructor() {
        axios.defaults.headers.common['access-token'] = localStorage.getItem('authToken');
    }
    //Porcentaje de perfil

    GetPercentageCompletion(empresaTransID)
    {
        return axios.get(URL_BASE + 'company/percentagecompletion/' + empresaTransID)
        .catch(error => {
            return handlererroapi(error)
        });
    }

    //Balance General
    GetGeneralBalance(empresaTransID)
    {
        return axios.get(URL_BASE + 'company/balancegeneral/' + empresaTransID)
        .catch(error => {
            return handlererroapi(error)
        });
    }

    //Saldos Iniciales

    GetAccountsOpeningBalance(empresaTransID, EsCxC)
    {
        return axios.get(URL_BASE + 'company/initcxc/' + empresaTransID + '/' + EsCxC)
        .catch(error => {
            return handlererroapi(error)
        });
    }

    DeleteAccountsOpeningBalance(registroID)
    {
        return axios.delete(URL_BASE + 'company/initcxc/' + registroID)
        .catch(error => {
            return handlererroapi(error)
        });
    }

    PostAccountsOpeningBalance(registroID, total)
    {
        return axios.put(URL_BASE + 'company/initcxc/' + registroID + '/' + total)
        .catch(error => {
            return handlererroapi(error)
        });
    }

    GetCollectionOpeningBalance(empresaTransID)
    {
        return axios.get(URL_BASE + 'company/openingbalance/collection/' + empresaTransID)
        .catch(error => {
            return handlererroapi(error)
        });
    }

    PostUpdateOpeningBalances(data)
    {
        return axios.put(URL_BASE + 'company/openingbalances', data)
        .catch(error => {
            return handlererroapi(error)
        });
    }

    GetOpeningBalance(empresaTransID)
    {
        return axios.get(URL_BASE + 'company/openingbalances/' + empresaTransID)
        .catch(error => {
            return handlererroapi(error)
        });
    }

    //Tipos de Cuentas
    GetTypeAccount()
    {
        return axios.get(URL_BASE + 'company/typeofaccount')
        .catch(error => {
            return handlererroapi(error)
        });
    }

    //Cxc and Cxp
    GetCollections(data) {
        return axios.post(URL_BASE + collection, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    //cxc and cxp
    GetCollectionsByDate(data) {
        return axios.post(URL_BASE + collectionByDate, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    PostCollection(data) {

        return axios.post(URL_BASE + collections, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }
    
    //SubClasificaciones
    GetSubclasifications(data) {

        return axios.post(URL_BASE + subclasifications, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    PostSubclasifications(data) {

        return axios.post(URL_BASE + subclasification, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    PostUpdateSubclasifications(data) {

        return axios.put(URL_BASE + subclasification, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    PostDeleteSubclasifications(data) {
        return axios.delete(URL_BASE + subclasification + data.EmpresaTransID + "/" + data.SubClasificacionID)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    //Cuentas
    GetBankaccounts(data) {

        return axios.post(URL_BASE + bankaccounts, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    PostCuenta(data) {

        return axios.post(URL_BASE + addaccount, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    PostUpdateCuenta(data) {
        return axios.put(URL_BASE + updateaccount + data.cuentaID, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    PostDeleteCuenta(data) {
        return axios.delete(URL_BASE + bankaccount + data.EmpresaTransID + "/" + data.CuentaID)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    //Registros
    PostUpdateRegistryTransaction(data) {
        return axios.put(URL_BASE + updateregistry, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    PostRegistryTransaction(data) {

        return axios.post(URL_BASE + addregistry, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    PostDeleteRegistryTransaction(data) {

        return axios.put(URL_BASE + deleteregistry, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    GetBankaccount(data) {
        return axios.get(URL_BASE + bankaccount + data.cuentaID)
            .catch(error => {
                return handlererroapi(error)
            });
    }
    
    GetRegistriesTransaction(data) {
        return axios.post(URL_BASE + getregistries, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    GetRegistryTransaction(data) {
        return axios.get(URL_BASE + registry + data.folioID)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    GetClasifications() {

        return axios.get(URL_BASE + clasifications)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    GetRegistriesTransactionResults(data) {
 
        return axios.post(URL_BASE + getregistries + data.empresaTransID, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }
}