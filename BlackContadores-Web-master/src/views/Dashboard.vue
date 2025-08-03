<template>
  <!-- App.vue -->
  <div id="app">
    <v-app id="inspire">
      <!-- mostrar pantalla alerta para mensajes -->
      <AlertDialog
        titulo="Black Administrativo - [ Configuración de Perfil ]"
        :mensaje="mensaje"
        :esCancelar="false"
        :esAceptar="true"
        vToolBarColor="blue"
        :dialog.sync="dialogAlert"
      />
      <!-- -->
      <v-navigation-drawer v-model="drawer" sm="absolute" left app>
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title id="navigationTitle">
              {{ str_title_name_app }}
            </v-list-item-title>
            <v-list-item-subtitle>
              {{ str_slogan }}
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>

        <v-divider style="margin-bottom: 20px"></v-divider>

        <v-list dense nav>
          <v-list-item-group color="blue">
            <v-list-item
              :to="item.path"
              v-for="item in menu"
              :key="item.title"
              link
              id="btnLnk"
              :disabled="!activa || cxcinicial > 0 || cxcinicial > 0"
            >
              <v-list-item-icon>
                <v-icon>{{ item.icon }}</v-icon>
              </v-list-item-icon>

              <v-list-item-content>
                <v-list-item-title
                  class="text-subtitle-1 font-weight-regular"
                  >{{ item.title }}</v-list-item-title
                >
              </v-list-item-content>
            </v-list-item>
          </v-list-item-group>
        </v-list>
        <template v-slot:append>
          <v-btn
            block
            color="blue"
            dark
            href="/"
            style="height: 60px"
            :class="$vuetify.breakpoint.xs ? 'mb-10' : '70'"
          >
            <v-icon left> mdi-logout </v-icon>
            Cerrar Sesión
          </v-btn>
        </template>
        <br />
      </v-navigation-drawer>

      <v-app-bar
        dark
        id="appBarStyle"
        class="pa-2"
        app
        :height="$vuetify.breakpoint.xs ? 200 : 70"
      >
        <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
        <v-container class="mx-0 pt-0" dense>
          <v-row dense>
            <v-col cols="12" sm="6" md="6" lg="6" class="pt-0">
              <span id="spanTitle" class="pa-0"
                >BUEN DÍA {{ str_legal_name }}
                <span id="spanSubtitle">{{ str_company_name }}</span></span
              >
            </v-col>
            <v-col cols="12" sm="6" md="6" lg="6" class="pt-0">
              <div v-on:click="details($event)" style="cursor: pointer">
                <v-subheader class="px-0 pb-3">{{
                  mensajePorcentaje
                }}</v-subheader>
                <v-progress-linear
                  height="10"
                  color="cyan"
                  buffer-value="1"
                  :value="value"
                  stream
                ></v-progress-linear>
              </div>
            </v-col>
          </v-row>
        </v-container>
      </v-app-bar>
      <v-main>
        <router-view />
      </v-main>
      <v-footer app>
        <ContentFooter />
      </v-footer>
    </v-app>
  </div>
</template>

<script>
import ContentFooter from "../components/ContentFooter";
import Constants from "../util/constants";
import Utils from "../util/utils";
import AlertDialog from "../components/AlertDialog";
import CompanyServices from "../network/services/CompanyService";

export default {
  components: {
    ContentFooter,
    AlertDialog,
  },

  data: () => ({
    mensajePorcentaje: "",
    drawer: true,
    str_title_name_app: Constants.str_title_name_app,
    str_slogan: Constants.str_slogan,
    str_legal_name: "",
    str_company_name: "",
    activa: true,
    value: 0,
    cxcinicial: 0,
    cxpinicial: 0,
    dialogAlert: false,
    mensaje:
             "* Registra subclasificaciones para tus registros diarios\n* Asigna un giro comercial y actividad a tu empresa\n* Ingresa saldos iniciales (bancos, efectivo, deudas, cobranza, pagos, etc)",
    menu: [
      {
        title: Constants.str_registro_diario,
        icon: "mdi-book-open-variant",
        id: 1,
        path: "registro-diario",
      },
      {
        title: Constants.str_cuentas_cobrar,
        icon: "mdi-hand-coin",
        id: 7,
        path: "cobranza-cxc",
      },
      {
        title: Constants.str_cuentas_pagar,
        icon: "mdi-hand-coin-outline",
        id: 8,
        path: "cobranza-cxp",
      },
      {
        title: Constants.str_edo_resultados,
        icon: "mdi-file-document-multiple",
        id: 2,
        path: "estado-resultados",
      },
      {
        title: Constants.str_balance_general,
        icon: "mdi-format-columns",
        id: 3,
        path: "balance-general",
      },
      {
        title: Constants.str_configuracion,
        icon: "mdi-folder-cog-outline",
        id: 5,
        path: "configuracion",
      },
      {
        title: Constants.str_perfil,
        icon: "mdi-account",
        id: 6,
        path: "perfil",
      },
    ],
    model: 0,
  }),

  created() {
    this.str_legal_name = new Utils().GetValue("legal_name");
    this.str_company_name = new Utils().GetValue("company_name");
    this.activa = /true/i.test(new Utils().GetValue("EmpresaActiva"));
    this.CompanyServices = new CompanyServices();
    this.$root.$refs.Dashboard = this;
  },
  mounted() {
    this.percentagecompletion();
    this.collectionOpeningBalances();
  },
  methods: {
    async collectionOpeningBalances() {
      await this.CompanyServices.GetCollectionOpeningBalance(
        new Utils().GetValue("EmpresaTransID")
      ).then((response) => {
        this.cxcinicial = response.data.response[0].cxcinicial;
        this.cxpinicial = response.data.response[0].cxpinicial;
        if (
          (this.cxcinicial != 0 || this.cxpinicial != 0) &&
          this.$route.name != "saldos-iniciales"
        )
          this.$router.push("/saldos-iniciales");
      });
    },
    async percentagecompletion() {
      this.mensaje =
        "* Registra subclasificaciones para tus registros diarios\n* Asigna un giro comercial y actividad a tu empresa\n* Ingresa saldos iniciales (bancos, efectivo, deudas, cobranza, pagos, etc)";
      await this.CompanyServices.GetPercentageCompletion(
        new Utils().GetValue("EmpresaTransID")
      ).then((response) => {
        this.mensaje = response.data.message + "\n\n" + this.mensaje;
        this.value = response.data.perce;
        if (this.value < 100)
          this.mensajePorcentaje =
            "Tu perfil se encuentra configurado al " +
            this.value +
            "%  (click para ver tips)";
        else this.mensajePorcentaje = "Tu perfil se ha completado al 100%";
      });
    },
    details() {
      this.dialogAlert = true;
    },
    cerrarSesion() {},
  },
};
</script>


<style >
#appBarStyle {
  background-color: black;
}

#spanTitle {
  color: white;
  font-size: 20px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  padding: 10px;
}

#spanSubtitle {
  color: white;
  font-size: 16px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  display: block;
  width: 450px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}

#navigationTitle {
  color: black;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-size: 18px;
  font-weight: 500;
}

#navigationStyle {
  background-color: lightgrey;
}

#btnLnk {
  /*font-family: "Franklin Gothic Medium", "Arial Narrow", Arial, sans-serif;*/
  font-size: 0.98rem !important;
}
</style>