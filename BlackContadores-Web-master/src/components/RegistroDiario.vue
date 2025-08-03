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
          REGISTRO DIARIO |
          <span class="text-subtitle-1" id="textDescription"
            >Registra tus movimientos diarios, como ingresos, gastos y
            compras.</span
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
      <v-card-text style="padding: 0px">
        <v-container class="pb-0 px-0 mx-0" style="max-width: 100% !important">
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
            <v-col cols="10" sm="2">
              <v-select
                required
                outlined
                :value="cuentaID"
                ref="cuentas"
                :items="itemsCuentas"
                item-value="CuentaID"
                item-text="Descripcion"
                no-data-text="Sin cuentas disponibles"
                item-key="itemsCuentas"
                return-object
                @change="cuentaSeleccionada"
                style="padding-left: 1px"
              ></v-select>
            </v-col>
            <v-col cols="12" sm="2">
              <v-btn
                dark
                class="mt-1 mb-2"
                color="indigo"
                x-large
                block
                @click="getRegistriesOfDay"
              >
                Filtrar
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
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
                    text-left text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  FECHA
                </th>
                <th
                  class="
                    text-left text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  REFERENCA
                </th>
                <th
                  class="
                    text-left text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  CLASIFICACION
                </th>
                <th
                  class="
                    text-center text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  IMPORTE
                </th>
                <th
                  class="
                    text-left text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  CUENTA
                </th>
                <th
                  class="
                    text-left text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                ></th>
                <th
                  class="
                    text-left text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                ></th>
                <th
                  class="
                    text-left text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                ></th>
              </tr>
            </thead>
            <tbody v-if="items.length > 0">
              <tr v-for="item in items" :key="item.FolioID">
                <td style="width: 30px; text-align: center">
                  {{ item.Folio }}
                </td>
                <td style="width: 300px">{{ item.DescripcionMovimiento }}</td>
                <td style="width: 30px; text-align: left">
                  {{ item.FechaRegistro }}
                </td>
                <td style="width: 150px">{{ item.Referencia }}</td>
                <td style="width: 300px">{{ item.Clasificacion }}</td>
                <td style="width: 120px; text-align: right">
                  <v-chip
                    :color="getColorClasification(item.ClasificacionID)"
                    dark
                    >{{ item.Importe | formatoMoneda }}</v-chip
                  >
                </td>
                <td style="width: 200px">{{ item.Descripcion }}</td>
                <td style="width: 10px">
                  <v-icon
                    v-show="item.ClasificacionID != 4"
                    @click="
                      mostrarRegistroAlert(
                        2,
                        'Editar movimiento',
                        item.FolioID,
                        item.Folio
                      )
                    "
                  >
                    mdi-pencil
                  </v-icon>
                </td>
                <td style="width: 10px">
                  <v-icon
                    @click="
                      mostrarRegistroAlert(
                        3,
                        'Consultar movimiento',
                        item.FolioID,
                        item.Folio
                      )
                    "
                  >
                    mdi-file-search
                  </v-icon>
                </td>
                <td style="width: 10px">
                  <v-icon @click="onDelete(item.FolioID, item.Folio)">
                    mdi-delete
                  </v-icon>
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
        <v-btn
          @click="mostrarRegistroAlert(0, 'Agregar nuevo movimiento', 0, 0)"
          color="blue"
          dark
          absolute
          bottom
          right
          class="mb-10 mr-4 rounded-circle"
          height="60"
        >
          <v-icon>mdi-plus</v-icon>
        </v-btn>
        <h2 class="pt-3 pl-4">Registros del día: {{ items.length }}</h2>
      </v-card-text>
    </base-material-card>
  </v-main>
</template>

<script>
import RegistroDiarioAlert from "../components/RegistroDiarioAlert";
import CompanyServices from "../network/services/CompanyService";
import ReportService from "../network/services/ReportService";
import Utils from "../util/utils";
import Vue from "vue";
import Constants from "../util/constants";
import Loading from "../components/Loading";
import AlertDialog from "../components/AlertDialog";
import JsonExcel from "vue-json-excel";
import moment from "moment";

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
    json_fields: {
      FOLIO: "Folio",
      DESCRIPCIÓN: "DescripcionMovimiento",
      FECHA: "FechaRegistro",
      REFERENCIA: "Referencia",
      CLASIFICACIÓN: "Clasificacion",
      IMPORTE: "Importe",
      CUENTA: "Descripcion",
    },
    itemsCuentas: [],
    cuentaID: 0,
    menu2: false,
    menu: false,
    eliminar: false,
    value: null,
    items: [],
    dialog: false,
    dialogAlert: false,
    esCancelar: false,
    titulo: "",
    accion: 0,
    esAceptar: false,
    folio: 0,
    mensaje: "",
    folioID: 0,
    overlay: false,
    vToolBarColor: "",
    str_no_data: Constants.str_no_data,
    reportes: 0,
  }),
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
  created() {
    this.CompanyServices = new CompanyServices();
    this.ReportService = new ReportService();
    this.moment = new moment();
    this.Utils = new Utils();
    this.getRegistriesOfDay();
    this.validarGenerarReporte();
    this.getbankaccount();
  },
  methods: {
    async getbankaccount() {
      let data = {
        empresaTransID: this.Utils.GetValue("EmpresaTransID"),
        mostrarInactivos: 0,
      };

      const rs_itemscuentas = await this.CompanyServices.GetBankaccounts(data);

      if (rs_itemscuentas.status === 200) {
        this.itemsCuentas = rs_itemscuentas.data.response;
      }

      this.itemsCuentas.push({
        CuentaID: 0,
        Descripcion: "Todas",
      });
    },
    cuentaSeleccionada(value) {
      this.cuentaID = value.CuentaID;
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
              this.messageCreateAccountResponse(
                "Reporte generado de manera exitosa",
                false,
                true,
                "green"
              );
            }
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
          "No cuentas con reportes disponibles para la descarga. Favor de mejorar tu membresía.",
          false,
          true,
          "red"
        );
      }
      this.overlay = false;
      this.eliminar = false;
    },
    async DeleteRegistry() {
      this.overlay = true;

      let params = {
        folioID: this.folioID,
      };

      const rs_registriesitems =
        await this.CompanyServices.PostDeleteRegistryTransaction(params);

      if (rs_registriesitems.status === 0 || rs_registriesitems.status === 500)
        this.messageCreateAccountResponse(
          rs_registriesitems.message,
          false,
          true,
          "red"
        );
      else if (rs_registriesitems.data.success) {
        this.getRegistriesOfDay();
      }
      this.getRegistriesOfDay();
      this.$root.$refs.Dashboard.collectionOpeningBalances();
      this.overlay = false;
      this.eliminar = false;
    },
    onDelete(folioID, folio) {
      this.folioID = folioID;
      this.folio = folio;
      this.eliminar = true;
    },
    getColorClasification(clasificacionID) {
      if (clasificacionID == 2) return "red";
      else if (clasificacionID == 1) return "green";
      else return "orange";
    },
    mostrarRegistroAlert(accion, titulo, folioID, folio) {
      this.titulo = titulo;
      this.accion = accion;
      this.folioID = folioID;
      this.folio = folio;
      this.dialog = true;
    },
    currentDate() {
      const current = new Date();
      const date = `${
        current.getDate() < 10 ? "0" + current.getDate() : current.getDate()
      }/${
        current.getMonth() + 1 < 10
          ? "0" + (current.getMonth() + 1)
          : current.getMonth() + 1
      }/${current.getFullYear()}`;
      return date;
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
    Dateformat(date) {
      date = new Date(date);
      date = `${date.getDate()}/${
        date.getMonth() + 1 < 10
          ? "0" + (date.getMonth() + 1)
          : date.getMonth() + 1
      }/${date.getFullYear()}`;
      return date;
    },
    async getRegistriesOfDay() {
      this.overlay = true;
      let params = {
        EmpresaTransID: this.Utils.GetValue("EmpresaTransID"),
        FechaInicio: this.formatDate(this.FechaInicio),
        FechaFin: Vue.filter("formatoFecha")(
          new Date(this.FechaFin).toISOString().substr(0, 10)
        ),
        CuentaID: this.cuentaID,
      };

      const rs_registriesitems =
        await this.CompanyServices.GetRegistriesTransaction(params);

      if (rs_registriesitems.status === 0 || rs_registriesitems.status === 500)
        this.messageCreateAccountResponse(
          rs_registriesitems.message,
          false,
          true,
          "red"
        );
      else if (rs_registriesitems.data.success) {
        this.items = rs_registriesitems.data.response;
      }

      this.overlay = false;
    },
    getregistries() {
      this.getRegistriesOfDay();
    },

    messageCreateAccountResponse(message, esCancelar, esAceptar, color) {
      this.mensaje = message;
      this.esCancelar = esCancelar;
      this.esAceptar = esAceptar;
      this.vToolBarColor = color;
      this.dialogAlert = true;

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