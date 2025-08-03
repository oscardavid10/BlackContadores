<template id="ca">
  <v-main class="px-4" style="padding: 0px; padding-top: 84px; height: 100%">
    <RegistroDiarioAlert
      :dialog.sync="dialog"
      :title="titulo"
      :accion="accion"
      :folioID="folioID"
      :folio="folio"
      @getregistries="getregistries"
    />

    <Loading :overlay="overlay" />

    <!-- mostrar pantalla alerta para mensajes -->
    <AlertDialog
      titulo="Black Administrativo - [ Problemas con el servicio ]"
      :mensaje="mensaje"
      :esCancelar="esCancelar"
      :esAceptar="esAceptar"
      :vToolBarColor="vToolBarColor"
      :dialog.sync="dialogAlert"
    />

    <v-dialog v-model="eliminar" persistent max-width="490">
      <v-card>
        <v-card-title class="text-h5">
          ¿Eliminar el registro seleccionado con el numero de folio
          {{ folio }} ?
        </v-card-title>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="red darken-1" text @click="eliminar = false">
            Cancelar
          </v-btn>
          <v-btn color="green darken-1" text @click="DeleteRegistry">
            Aceptar
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <base-material-card color="blue pa-0">
      <template v-slot:heading>
        <div class="text-left text-h5" style="height: 50px">
          BANCOS |
          <span class="text-subtitle-1" id="textDescription"
            >Estos son los saldos de tus diversas cuentas bancarias a la fecha de hoy.</span
          >
          <div class="float-right text-left text-h5 mb-2" v-if="reportes > 0">
            <download-excel
              :data="items"
              :fields="json_fields"
              worksheet="Registros"
              name="Registro_Diario"
            >
              <v-tooltip bottom>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    class="float-right"
                    @click="GenerarReporte"
                    color="green"
                    rounded
                    v-bind="attrs"
                    v-on="on"
                  >
                    <v-icon>mdi-file-excel</v-icon>
                    Exportar a Excel
                  </v-btn>
                </template>
                <span> Generar Reporte</span>
              </v-tooltip>
            </download-excel>
          </div>
          <div class="float-right text-left text-h5" v-if="reportes <= 0">
            <v-btn
              class="float-right"
              v-bind="attrs"
              v-on="on"
              @click="GenerarReporte"
              color="green"
              rounded
            >
              <v-icon>mdi-file-excel</v-icon>
              Exportar a Excel
            </v-btn>
          </div>
        </div>
      </template>

    </base-material-card>
  </v-main>
</template>

<script>
import RegistroDiarioAlert from "../components/RegistroDiarioAlert";
import CompanyServices from "../network/services/CompanyService";
import Utils from "../util/utils";
import Vue from "vue";
import Loading from "../components/Loading";
import AlertDialog from "../components/AlertDialog";
import JsonExcel from "vue-json-excel";

Vue.component("downloadExcel", JsonExcel);

export default {
  components: {
    RegistroDiarioAlert,
    Loading,
    AlertDialog,
  },
  data: () => ({
   items: [],
   total: 0,
   abono: 0,
   saldo: 0,
   overlay: true,
   formatter: new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "USD",
    }),
  }),
  computed: {
    sumOfTotal() {
        return this.items.reduce((sum, transaction) => {
            return this.total += transaction.Total;
        }, 0);
    },
    sumOfAbono() {
        return this.items.reduce((sum, transaction) => {
            return this.abono += transaction.Abono;
        }, 0);
    },
    sumOfSaldo() {
        return this.items.reduce((sum, transaction) => {
            return this.saldo += transaction.Saldo;
        }, 0);
    }
  },
  created() {
   this.CompanyServices = new CompanyServices();
    this.Utils = new Utils();
    this.getInitCxc();
  },
  methods: {
   async getInitCxc() {
      let params = {
        EmpresaTransID: this.Utils.GetValue("EmpresaTransID"),
        TipoCuentaID: 4,
      };

      var response = await this.CompanyServices.GetCollections(params);

      if (response.data.success !== false) {
        this.items = response.data.response;
      } else {
        this.messageCreateAccountResponse(
          response.data.message,
          false,
          true,
          "red"
        );
      }
      this.overlay = false;
    },
  },
};
</script>


<style scope>
#sheetStyle {
  color: white;
  font-family: "Gill Sans", "Gill Sans MT", Calibri, "Trebuchet MS", sans-serif;
  font-size: 24px;
  padding-left: 10px;
  padding-top: 10px;
  padding-bottom: 1px;
}
#textDescription {
  color: white;
  font-family: "Gill Sans", "Gill Sans MT", Calibri, "Trebuchet MS", sans-serif;
  font-size: 18px;
}
.headerTitle {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-size: 50px;
}
</style>