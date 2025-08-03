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
          CUENTAS POR COBRAR |
          <span class="text-subtitle-1" id="textDescription"
            >Estos son los registros de tus cuentas por cobrar a la fecha. </span
          >
          <div class="float-right text-left text-h5 mb-2" v-if="reportes > 0">
            <download-excel
              :data="items"
              :fields="json_fields"
              worksheet="CuentasPorCobrar"
              name="Cuentas_Por_Cobrar"
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

      <v-card-text style="padding: 0px">
        <v-container class="pb-0 px-0 mx-0">
          <v-row dense>
            <v-col cols="12" sm="2">
              <v-menu
                v-model="menu2"
                :close-on-content-click="false"
                :nudge-right="40"
                transition="scale-transition"
                offset-y
                min-width="auto"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    class="mx-3"
                    filled
                    v-model="dateFormatted"
                    label="Fecha Inicio"
                    prepend-icon="mdi-calendar"
                    readonly
                    v-bind="attrs"
                    v-on="on"
                    @blur="date = parseDate(dateFormatted)"
                  ></v-text-field>
                </template>
                <v-date-picker
                  locale="es-mx"
                  v-model="FechaInicio"
                  @input="menu2 = false"
                ></v-date-picker>
              </v-menu>
            </v-col>
            <v-col cols="12" sm="2">
              <v-menu
                v-model="menu"
                :close-on-content-click="false"
                :nudge-right="40"
                transition="scale-transition"
                offset-y
                min-width="auto"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    class="mx-3"
                    filled
                    v-model="dateFormatted2"
                    label="Fecha Fin"
                    prepend-icon="mdi-calendar"
                    readonly
                    v-bind="attrs"
                    v-on="on"
                    @blur="date = parseDate(dateFormatted2)"
                  ></v-text-field>
                </template>
                <v-date-picker
                locale="es-mx"
                  v-model="FechaFin"
                  @input="menu = false"
                ></v-date-picker>
              </v-menu>
            </v-col>
            <v-col cols="12" sm="2">
              <v-btn
                dark
                class="mt-1 mb-2"
                color="indigo"
                x-large
                block
                @click="getRegistriesbyDay"
              >
                Filtrar
              </v-btn>
            </v-col>

            <v-col cols="12" sm="1">
              <v-btn
                dark
                class="mt-1 mb-2"
                color="indigo"
                x-large
                block
                @click="getInitCxc"
              >
                Restablecer
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
      
      <v-card-text style="padding: 0px">
        <v-simple-table fixed-header height="660px" class="grey lighten-3">
          <template v-slot:default>
            <thead>
              <tr id="headerTitle">
                <th
                  class="
                    text-center text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  FOLIO
                </th>
                <th
                  class="
                    text-left text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  DESCRIPCION
                </th>
                <th
                  class="
                    text-right text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  TOTAL
                </th>

                <th
                  class="
                    text-right text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  ABONO
                </th>

                <th
                  class="
                    text-right text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  SALDO
                </th>

                <th
                  class="
                    text-center text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  FECHA REGISTRO
                </th>

                <th
                  class="
                    text-center text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  DIAS (atraso)
                </th>

              </tr>
            </thead>
            
            <tbody v-if="items.length > 0">
              <tr v-for="item in items" :key="item.RegistroID">
                <td style="text-align: center">
                  {{ item.Folio }}
                </td>
                <td style="text-align: left">
                  {{ item.Descripcion }}
                </td>
                <td style="text-align: right; font-weight: bold;">
                  {{ formatter.format(item.Total) }}
                </td>
                <td style="width: 120px; text-align: right">
                  <v-chip
                    color="green"
                    dark
                    >{{ item.Abono | formatoMoneda }}</v-chip
                  >
                </td>
               <td style="width: 120px; text-align: right">
                  <v-chip
                    color="red"
                    dark
                    >{{ item.Saldo | formatoMoneda }}</v-chip
                  >
                </td>
                <td style="text-align: center">
                  {{ item.FechaRegistro }}
                </td>
                <td style="text-align: center">
                  {{ item.diasAtraso }}
                </td>
              </tr>
            </tbody>

            <tr style="height: 200px" v-else>
              <td colspan="9" style="text-align: center; font-size: 20px">
                {{ str_no_data }}
              </td>
            </tr>
          </template>
        </v-simple-table>
        
         <div class="text-left text-h5 pt-5" style="height: 50px">

            <div class="float-right text-left text-h5 mb-2" >
              <v-card :elevation="6" class="px-4 pt-5 pb-0 black">
                  <v-text-field
                    dark
                    readonly
                    label="SALDO"
                    :value="sumOfSaldo | formatoMoneda"
                    outlined
                    rounded
                    dense
                    class="right-input"
                  ></v-text-field>
                </v-card>
            </div>

            <div class="float-right text-left text-h5 mb-2 pr-1">
              <v-card :elevation="6" class="px-4 pt-5 pb-0 black">
                  <v-text-field
                    dark
                    readonly
                    label="ABONO"
                    :value="sumOfAbono | formatoMoneda"
                    outlined
                    rounded
                    dense
                    class="right-input"
                  ></v-text-field>
                </v-card>
            </div>

            <div class="float-right text-left text-h5 mb-2 pr-1">
              <v-card :elevation="6" class="px-4 pt-5 pb-0 black">
                  <v-text-field
                    dark
                    readonly
                    label="TOTAL"
                    :value="sumOfTotal | formatoMoneda"
                    outlined
                    rounded
                    dense
                    class="right-input"
                  ></v-text-field>
                </v-card>
            </div>
        </div>
      </v-card-text>
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
import ReportService from "../network/services/ReportService";

Vue.component("downloadExcel", JsonExcel);

export default {
  components: {
    RegistroDiarioAlert,
    Loading,
    AlertDialog,
  },
  data: (vm) => ({
    dateFormatted: vm.formatDate(
      new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10)
    ),
    dateFormatted2: vm.formatDate(
      new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10)
    ),
    FechaInicio: new Date(
      new Date().getTime() - new Date().getTimezoneOffset() * 60000
    )
      .toISOString()
      .substr(0, 10),
    FechaFin: new Date(
      new Date().getTime() - new Date().getTimezoneOffset() * 60000
    )
      .toISOString()
      .substr(0, 10),
   items: [],
   total: 0,
   abono: 0,
   saldo: 0,
   reportes: 0,
   descontarReporte: true,
   dialogAlert: false,
   esCancelar: false,
   esAceptar: false,
   vToolBarColor: "",
   mensaje: "",
   json_fields: {
      FOLIO: "Folio",
      DESCRIPCIÓN: "Descripcion",
      TOTAL: "Total",
      ABONO: "Abono",
      SALDO: "Saldo",
      FECHAREGISTRO: "FechaRegistro",
      ATRASO: "diasAtraso",
    },
   overlay: true,
   formatter: new Intl.NumberFormat("es-MX", {
      style: "currency",
      currency: "MXN",
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
    },
    computedDateFormatted() {
      return this.formatDate(this.date);
    },
  },
  created() {
    this.ReportService = new ReportService();
   this.CompanyServices = new CompanyServices();
    this.Utils = new Utils();
    this.getInitCxc();
    this.validarGenerarReporte();
  },
  watch: {
    FechaInicio() {
      var datefin = new Date(this.FechaFin);
      var date = new Date(this.FechaInicio);
      if (date > datefin) {
        this.dateFormatted = this.formatDate(this.FechaFin);
        this.FechaInicio = this.FechaFin;
      } else this.dateFormatted = this.formatDate(this.FechaInicio);
      this.dateFormatted2 = this.formatDate(this.FechaFin);
    },
    FechaFin() {
      var datefin = new Date(this.FechaFin);
      var date = new Date(this.FechaInicio);
      if (date > datefin) {
        this.dateFormatted = this.formatDate(this.FechaFin);
        this.FechaInicio = this.FechaFin;
      } else this.dateFormatted = this.formatDate(this.FechaInicio);
      this.dateFormatted2 = this.formatDate(this.FechaFin);
    },
  },
  methods: {
   async getInitCxc() {
      let params = {
        EmpresaTransID: this.Utils.GetValue("EmpresaTransID"),
        TipoCuentaID: 3,
      };

      var response = await this.CompanyServices.GetCollections(params);

      if (response.data.success !== false) {
        this.total = 0
        this.abono = 0
        this.saldo = 0
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
    async validarGenerarReporte() {
      this.overlay = true;

      const response = await this.ReportService.GetNumberReports(
        this.Utils.GetValue("EmpresaTransID")
      );

      if (response.status === 0 || response.status === 500)
        this.messageCreateAccountResponse(response.message, false, true, "red");
      else if (response.data.success) {
        this.reportes = response.data.response[0].NoReportes;
      }

      this.overlay = false;
      this.eliminar = false;
    },
    async GenerarReporte() {
      if (this.items.length > 0) {
        if (this.reportes > 0) {
          this.overlay = true;
          if (this.descontarReporte) {
              const response = await this.ReportService.UpdateNumberReports(
              this.Utils.GetValue("EmpresaTransID")
            );

            if (response.status === 0 || response.status === 500)
              this.messageCreateAccountResponse(
                response.message,
                false,
                true,
                "red"
              );
            else {
              if (response.data.success) {
                this.reportes--;
                this.descontarReporte = false;
                this.messageCreateAccountResponse(
                  "Reporte generado de manera exitosa",
                  false,
                  true,
                  "green"
                );
              }
            }
          } else {
            this.messageCreateAccountResponse(
              "Reporte generado de manera exitosa",
              false,
              true,
              "green"
            );
          }
        } else
          this.messageCreateAccountResponse(
            "No cuentas con reportes disponibles para la descarga. Favor de mejorar tu membresía.",
            false,
            true,
            "red"
          );
      } else {
        this.messageCreateAccountResponse(
          "No existen registros para generar un reporte.",
          false,
          true,
          "red"
        );
      }
      this.overlay = false;
      this.eliminar = false;
    },
    messageCreateAccountResponse(message, esCancelar, esAceptar, color) {
      this.mensaje = message;
      this.esCancelar = esCancelar;
      this.esAceptar = esAceptar;
      this.vToolBarColor = color;
      this.dialogAlert = true;

      this.overlay = false;
    },
    formatDate(date) {
      if (!date) return null;

      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },
    parseDate(date) {
      if (!date) return null;

      const [month, day, year] = date.split("/");
      return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
    },
    onChangeFechaInicio(value) {
      console.log(value);
    },
    fechaSeleccionada(fecha) {
      this.FechaInicio = fecha;
    },
    Dateformat(date) {
      date = new Date(date);
      date = `${date.getDate()}/${
        date.getMonth() + 1 < 10
          ? "0" + (date.getMonth() + 1)
          : date.getMonth() + 1
      }/${date.getFullYear()}`;
      return date;
    },
    async getRegistriesbyDay() {
      this.overlay = true;

      let empresaTransID = this.Utils.GetValue("EmpresaTransID");
      let params = {
        EmpresaTransID: empresaTransID,
        TipoCuentaID: 3,
        FechaInicio: this.formatDate(this.FechaInicio),
        FechaFin: Vue.filter("formatoFecha")(
          new Date(this.FechaFin).toISOString().substr(0, 10)
        ),
      };

      const rs_registriesitems =
        await this.CompanyServices.GetCollectionsByDate(params);

      if (rs_registriesitems.status === 0 || rs_registriesitems.status === 500)
        this.messageCreateAccountResponse(
          rs_registriesitems.message,
          false,
          true,
          "red"
        );
      else if (rs_registriesitems.data.success) {
        this.total = 0
        this.abono = 0
        this.saldo = 0
        this.registros = rs_registriesitems.data.response;
        this.items = rs_registriesitems.data.response;
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