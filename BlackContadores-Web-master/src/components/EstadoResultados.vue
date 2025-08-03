<template id="ca">
  <v-main class="px-4" style="padding: 0px; padding-top: 60px; height: 100%">
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
    <!-- -->

    <base-material-card color="blue">
      <template v-slot:heading>
        <div class="text-left text-h5" style="height: 50px">
          ESTADO DE RESULTADOS |
          <span class="text-subtitle-1" id="textDescription"
            >Consulta los resultados de tus estados.</span
          >
          <div class="float-right text-left text-h5 mb-2" v-if="reportes > 0">
            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">
                <download-excel
                  :data="registros"
                  :fields="json_fields"
                  worksheet="Registros"
                  name="Estado_Resultados"
                  :before-generate="formarReporte"
                >
                  <v-btn
                    v-bind="attrs"
                    v-on="on"
                    class="float-right"
                    @click="GenerarReporte"
                    color="green"
                    rounded
                  >
                    <v-icon>mdi-file-excel</v-icon>
                    Exportar a Excel
                  </v-btn>
                </download-excel>
              </template>
              <span> Generar Reporte</span>
            </v-tooltip>
          </div>
          <div class="float-right text-left text-h5" v-if="reportes <= 0">
            <v-btn
              class="float-right"
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
            <v-col cols="12" sm="3">
              <v-select
                class="mx-3"
                :value="clasificacionID"
                ref="clasificaciones"
                filled
                label="Clasificación (*)"
                required
                :items="itemsClasificacion"
                item-text="Clasificacion"
                item-value="ClasificacionID"
                item-key="itemsClasificacion"
                return-object
                @change="clasificacionSeleccionada"
              ></v-select>
            </v-col>
            <v-col cols="12" sm="3">
              <v-select
                v-model="subclasificacionID"
                class="mx-3"
                :value="subclasificacionID"
                ref="subclasificaciones"
                filled
                label="Subclasificación (*)"
                required
                :items="itemsSubClasificacion"
                item-text="Concepto"
                item-value="ConceptoID"
                item-key="itemsSubClasificacion"
                return-object
                @change="subclasificacionSeleccionada"
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
      </v-card-text>
      <v-card-text
        style="padding-top: 0px; padding-left: 0px; padding-right: 0px"
      >
        <v-container class="pt-0 px-0 mx-0" style="max-width: 100% !important">
          <v-row no-gutters>
            <v-col cols="12" sm="10" class="pr-sm-7">
              <v-simple-table
                fixed-header
                height="610px"
                class="grey lighten-3"
              >
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
                    </tr>
                  </thead>
                  <tbody v-if="items.length > 0">
                    <tr v-for="item in items" :key="item.FolioID">
                      <td style="width: 30px; text-align: center">
                        {{ item.Folio }}
                      </td>
                      <td style="width: 300px">
                        {{ item.DescripcionMovimiento }}
                      </td>
                      <td style="width: 30px; text-align: left">
                        {{ item.FechaRegistro }}
                      </td>
                      <td style="width: 150px">{{ item.Referencia }}</td>
                      <td style="width: 100px">{{ item.Clasificacion }}</td>
                      <td style="width: 120px; text-align: right">
                        <v-chip
                          :color="getColorClasification(item.ClasificacionID)"
                          dark
                          >{{ item.Importe | formatoMoneda }}</v-chip
                        >
                      </td>
                      <td style="width: 200px">{{ item.Descripcion }}</td>
                    </tr>
                  </tbody>
                  <tr style="height: 200px" v-else>
                    <td colspan="9" style="text-align: center; font-size: 20px">
                      {{
                        "Sin registro de movimientos en las fechas seleccionadas"
                      }}
                    </td>
                  </tr>
                </template>
              </v-simple-table>
            </v-col>
            <v-col cols="12" sm="2" style="height: 100%">
              <v-card :elevation="6" class="px-4 pt-5 pb-0 black">
                <h3 class="text-center white--text">Totales</h3>
                <br />
                <v-text-field
                  dark
                  readonly
                  :label="
                    filtroClasificacionID == 0 ? 'Total Ingresos' : 'Total'
                  "
                  :value="totalIngresos | formatoMoneda"
                  outlined
                  rounded
                  dense
                  class="right-input"
                ></v-text-field>
                <v-text-field
                  dark
                  readonly
                  label="Total Compras"
                  :value="totalCompras | formatoMoneda"
                  outlined
                  rounded
                  dense
                  v-if="filtroClasificacionID == 0"
                  class="right-input"
                ></v-text-field>
                <v-text-field
                  dark
                  readonly
                  label="Utilidad / Perdida Bruta"
                  :value="(totalIngresos - totalCompras) | formatoMoneda"
                  outlined
                  rounded
                  dense
                  v-if="filtroClasificacionID == 0"
                  class="right-input"
                ></v-text-field>
                <v-text-field
                  dark
                  readonly
                  label="Total Gastos"
                  :value="totalGastos | formatoMoneda"
                  outlined
                  rounded
                  dense
                  v-if="filtroClasificacionID == 0"
                  class="right-input"
                ></v-text-field>
                <v-text-field
                  dark
                  readonly
                  label="Utilidad / Perdida Neta"
                  :value="utilidadNeta | formatoMoneda"
                  outlined
                  rounded
                  dense
                  v-if="filtroClasificacionID == 0"
                  class="right-input"
                ></v-text-field>
                <v-divider />
                <br />
                <h3
                  class="text-center white--text"
                  v-if="filtroClasificacionID == 0"
                >
                  Margenes de Utilidad
                </h3>
                <br />
                <v-text-field
                  dark
                  readonly
                  label="Utilidad Costos"
                  :value="utilidadCostos | formatoPorcentaje"
                  outlined
                  rounded
                  dense
                  v-if="filtroClasificacionID == 0"
                  class="right-input"
                ></v-text-field>
                <v-text-field
                  dark
                  readonly
                  label="Utilidad Gastos"
                  :value="utilidadGastos | formatoPorcentaje"
                  outlined
                  rounded
                  dense
                  v-if="filtroClasificacionID == 0"
                  class="right-input"
                ></v-text-field>
                <br />
              </v-card>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </base-material-card>
  </v-main>
</template>

<script>
import CompanyServices from "../network/services/CompanyService";
import Constants from "../util/constants";
import Loading from "../components/Loading";
import AlertDialog from "../components/AlertDialog";
import Vue from "vue";
import Utils from "../util/utils";
import JsonExcel from "vue-json-excel";
import ReportService from "../network/services/ReportService";
Vue.component("downloadExcel", JsonExcel);

export default {
  components: {
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
    menu2: false,
    menu: false,
    totalIngresos: 0,
    totalGastos: 0,
    totalCompras: 0,
    utilidadCostos: 0,
    utilidadGastos: 0,
    utilidadNeta: 0,
    clasificacionID: 0,
    filtroClasificacionID: 0,
    mensaje: "",
    items: [],
    registros: [],
    dialog: false,
    dialogAlert: false,
    esCancelar: false,
    esAceptar: false,
    overlay: false,
    vToolBarColor: "",
    itemsClasificacion: [],
    subclasificacionID: 0,
    itemsSubClasificacion: [],
    str_no_data: Constants.str_no_data,
    SubClasificaciones: [],
    descontarReporte: true,
    reportes: 0,
    json_fields: {
      FOLIO: "Folio",
      DESCRIPCIÓN: "DescripcionMovimiento",
      FECHA: "FechaRegistro",
      REFERENCIA: "Referencia",
      CLASIFICACIÓN: "Clasificacion",
      IMPORTE: "Importe",
      CUENTA: "Descripcion",
    },
  }),

  created() {
    this.ReportService = new ReportService();
    this.CompanyServices = new CompanyServices();
    this.Utils = new Utils();
    this.getRegistriesOfDay();
    this.getclasifications();
    this.getsubclasifications();
    this.validarGenerarReporte();
    this.clasificacionID = 0;
    this.subClasificacionID = 0;
  },
  computed: {
    computedDateFormatted() {
      return this.formatDate(this.date);
    },
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
    formarReporte() {
      this.registros = JSON.parse(JSON.stringify(this.items));
      if (this.clasificacionID == 0) {
        this.registros.push(
          {
            Folio: "",
            DescripcionMovimiento: "",
          },
          {
            Folio: "Total Ingresos",
            DescripcionMovimiento: this.totalIngresos,
          },
          {
            Folio: "Total Compras",
            DescripcionMovimiento: this.totalCompras,
          },
          {
            Folio: "Utilidad Bruta",
            DescripcionMovimiento: this.totalIngresos - this.totalCompras,
          },
          {
            Folio: "Total Gastos",
            DescripcionMovimiento: this.totalGastos,
          },
          {
            Folio: "Utilidad Neta",
            DescripcionMovimiento: this.utilidadNeta,
          },
          {
            Folio: "Utilidad Costos",
            DescripcionMovimiento: this.utilidadCostos | this.formatoPorcentaje,
          },
          {
            Folio: "Utilidad Gastos",
            DescripcionMovimiento: this.utilidadGastos | this.formatoPorcentaje,
          }
        );
      } else {
        this.registros.push(
          {
            Folio: "",
            DescripcionMovimiento: "",
          },
          {
            Folio: "Total",
            DescripcionMovimiento: this.totalIngresos,
          }
        );
      }
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
    async getsubclasifications() {
      let data = {
        EmpresaTransID: this.Utils.GetValue("EmpresaTransID"),
        mostrarInactivos: 0,
      };
      const response = await this.CompanyServices.GetSubclasifications(data);

      if (response.status === 200)
        this.itemsSubClasificacion = response.data.response;
      this.SubClasificaciones = response.data.response;
      this.itemsSubClasificacion.push({
        ConceptoID: 0,
        Concepto: "Todas",
      });
      this.SubClasificaciones.push({
        ConceptoID: 0,
        Concepto: "Todas",
      });
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
    subclasificacionSeleccionada(value) {
      this.subclasificacionID = value.ConceptoID;
    },
    clasificacionSeleccionada(value) {
      this.clasificacionID = value.ClasificacionID;
      this.itemsSubClasificacion = this.SubClasificaciones.filter(
        (Subclasificacion) =>
          Subclasificacion.ClasificacionID == value.ClasificacionID ||
          Subclasificacion.ConceptoID == 0
      );
    },
    async getclasifications() {
      const rs_itemsclasificacion =
        await this.CompanyServices.GetClasifications();

      if (rs_itemsclasificacion.status === 200) {
        this.itemsClasificacion = rs_itemsclasificacion.data.response;
        this.itemsClasificacion.splice(3, 1);
        this.itemsClasificacion.push({
          ClasificacionID: 0,
          Clasificacion: "Todas",
        });
      }
    },
    fechaSeleccionada(fecha) {
      this.FechaInicio = fecha;
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

      this.filtroClasificacionID = this.clasificacionID;
      let empresaTransID = this.Utils.GetValue("EmpresaTransID");

      let params = {
        ClasificacionID: this.clasificacionID ? this.clasificacionID : 0,
        SubClasificacionID: this.subclasificacionID
          ? this.subclasificacionID
          : 0,
        empresaTransID: empresaTransID,
        FechaInicio: this.formatDate(this.FechaInicio),
        FechaFin: Vue.filter("formatoFecha")(
          new Date(this.FechaFin).toISOString().substr(0, 10)
        ),
      };

      const rs_registriesitems =
        await this.CompanyServices.GetRegistriesTransactionResults(params);
      if (rs_registriesitems.status === 0 || rs_registriesitems.status === 500)
        this.messageCreateAccountResponse(
          rs_registriesitems.message,
          false,
          true,
          "red"
        );
      else if (rs_registriesitems.data.success) {
        this.registros = rs_registriesitems.data.response;
        this.items = rs_registriesitems.data.response;
        if (Object.keys(rs_registriesitems.data.totalAccount).length > 1) {
          this.totalIngresos =
            rs_registriesitems.data.totalAccount.TotalIngreso;
          this.totalGastos = rs_registriesitems.data.totalAccount.TotalGasto;
          this.totalCompras = rs_registriesitems.data.totalAccount.TotalCompra;
          this.utilidadCostos =
            rs_registriesitems.data.totalAccount.MargenUtilidadCosto;
          this.utilidadGastos =
            rs_registriesitems.data.totalAccount.MargenUtilidadGasto;
          this.utilidadNeta = rs_registriesitems.data.totalAccount.UtilidadNeta;
        } else
          this.totalIngresos =
            rs_registriesitems.data.totalAccount.TotalMovimiento;
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
.right-input input {
  text-align: right;
}
</style>