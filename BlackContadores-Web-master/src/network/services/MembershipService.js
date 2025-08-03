import axios from 'axios'
import Vue from 'vue'
import VueAxios from 'vue-axios'
import { URL_BASE, getmembershiplist, headers } from '../api'
import handlererroapi from '../handlererroapi'

Vue.use(VueAxios, axios)

export default class MembershipService {
    constructor() {
    }

    GetMembershipList() {
        return axios.get(URL_BASE + getmembershiplist, headers)
            .catch(error => {
                return handlererroapi(error)
            });
    }
}