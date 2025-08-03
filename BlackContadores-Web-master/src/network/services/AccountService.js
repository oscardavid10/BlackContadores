import axios from 'axios'
import Vue from 'vue'
import VueAxios from 'vue-axios'
import { URL_BASE, createaccount, login, profile } from '../api'
import handlererroapi from '../handlererroapi'

Vue.use(VueAxios, axios)

export default class AccountService {
    constructor() {
        axios.defaults.headers.common['access-token'] = localStorage.getItem('authToken');
    }

    //Recuperar contraseña
    PostRecoveryPassword (data) {
        return axios.post(URL_BASE + "user/recoverypassword", data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    //crear el usuario inicial para la empresa
    PostCreateAccount(data) {
        return axios.post(URL_BASE + createaccount, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    //Iniciar sesión
    PostLogin(data) {

        return axios.post(URL_BASE + login, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    //Recuperar datos del perfil
    GetProfile(data) {

        return axios.post(URL_BASE + profile + data.EmpresaTransID, data)
            .catch(error => {
                return handlererroapi(error)
            });

    }

    //Recuperar datos del perfil
    PostUpdateProfile(data) {

        return axios.put(URL_BASE + profile + data.companyTransID, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }
}