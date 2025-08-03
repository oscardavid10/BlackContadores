import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import VueRouter from "vue-router";

import routes from "./router/routes"
import "./util/filters"
import './plugins/base'

// configure router
const router = routes;

Vue.use(VueRouter);

Vue.config.productionTip = false

new Vue({
  vuetify,
  router,
  render: h => h(App)
}).$mount('#app')
