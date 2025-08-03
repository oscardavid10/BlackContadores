import axios from 'axios'
import Vue from 'vue'
import VueAxios from 'vue-axios'
import { URL_BASE, payment } from '../api'
import handlererroapi from '../handlererroapi'

Vue.use(VueAxios, axios)

export default class PaymentService {
    constructor() {
        axios.defaults.headers.common['access-token'] = localStorage.getItem('authToken');
    }

    //Pago de membresia
    PostPayment(data) {
        return axios.post(URL_BASE + payment, data)
            .catch(error => {
                console.log(error)
                return handlererroapi(error)
            });
    }
}