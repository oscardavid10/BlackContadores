import axios from 'axios'
import Vue from 'vue'
import VueAxios from 'vue-axios'
import { URL_BASE, } from '../api'
import handlererroapi from '../handlererroapi'

Vue.use(VueAxios, axios)

export default class ReportService {

    constructor() {
        axios.defaults.headers.common['access-token'] = localStorage.getItem('authToken');
    }

    GetNumberReports(EmpresaTransID)
    {
        return axios.get(URL_BASE + 'company/reports/' + EmpresaTransID)
        .catch(error => {
            return handlererroapi(error)
        });
    }

    UpdateNumberReports(EmpresaTransID)
    {
        return axios.put(URL_BASE + 'company/reports', {EmpresaTransID: EmpresaTransID})
        .catch(error => {
            return handlererroapi(error)
        });
    }
}