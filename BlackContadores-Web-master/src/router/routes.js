import Vue from 'vue';
import Router from 'vue-router';
Vue.use(Router);

const routes = new Router({
  routes: [
    {
      path: '/',
      name: 'login',
      component: () => import('../views/Login')
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: () => import('../views/Dashboard'),
      children: [
        {
          path: '/usuarios',
          name: 'usuarios',
          component: () => import('../components/Usuarios')
        },
        {
          path: '/subclasificaciones',
          name: 'subclasificaciones',
          component: () => import('../components/Subclasificaciones')
        },
        {
          path: '/cuentas',
          name: 'cuentas',
          component: () => import('../components/Cuentas')
        },
        {
          path: '/registro-diario',
          name: 'registro-diario',
          component: () => import('../components/RegistroDiario')
        },
        {
          path: '/estado-resultados',
          name: 'estado-resultados',
          component: () => import('../components/EstadoResultados')
        },
        {
          path: '/balance-general',
          name: 'balance-general',
          component: () => import('../components/BalanceGeneral')
        },
        {
          path: '/saldos-iniciales',
          name: 'saldos-iniciales',
          component: () => import('../components/SaldosIniciales')
        },
        {
          path: '/configuracion',
          name: 'configuracion',
          component: () => import('../components/Configuracion')
        }
        ,
        {
          path: '/perfil',
          name: 'perfil',
          component: () => import('../components/Perfil')
        },
        {
          path: '/cobranza-cxc',
          name: 'cobranza-cxc',
          component: () => import('../components/CuentasCobrar')
        },
        {
          path: '/cobranza-cxp',
          name: 'cobranza-cxp',
          component: () => import('../components/CuentasPagar')
        },
        {
          path: '/saldos-bancos',
          name: 'saldos-bancos',
          component: () => import('../components/SaldoBancos')
        },
      ]
    },
  ],
  mode: 'history',
});

routes.beforeEach((to, from, next) => {
  if (to.name !== 'login' && !localStorage.getItem('authToken')) next({ name: 'login' })
  else next()
})

export default routes;