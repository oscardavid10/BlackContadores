import axios from 'axios'
import Vue from 'vue'
import VueAxios from 'vue-axios'
import { URL_BASE, users, adduser, user } from '../api'
import handlererroapi from '../handlererroapi'

Vue.use(VueAxios, axios)

export default class UserService {

    constructor() {
        axios.defaults.headers.common['access-token'] = localStorage.getItem('authToken');
    }

    GetUsers(data) {

        return axios.get(URL_BASE + users + data.EmpresaTransID)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    GetUser(data) {

        return axios.get(URL_BASE + user + data.usuarioID, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    PostUser(data) {

        return axios.post(URL_BASE + adduser, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }

    PostUpdateUser(data) {

        return axios.put(URL_BASE + user + data.usuarioID, data)
            .catch(error => {
                return handlererroapi(error)
            });
    }
}