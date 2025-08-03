<template id="ca">
  <v-main class="px-4" style="padding: 0px; padding-top: 60px; height: 100%">
    <Loading :overlay="overlay" />
    <!-- mostrar pantalla alerta para mensajes -->
    <AlertDialog
      titulo="Black Administrativo - [ Saldos Iniciales ]"
      :mensaje="mensaje"
      :esCancelar="esCancelar"
      :esAceptar="esAceptar"
      :vToolBarColor="vToolBarColor"
      :dialog.sync="dialogAlert"
    />
    <!-- -->
    <base-material-card color="blue pa-0" style="height: 97%">
      <template v-slot:heading>
        <div class="text-left text-h5" style="height: 50px">
          BALANCE GENERAL
          <span class="text-h6" id="textDescription"
            >AL
            {{
              new Date()
                .toLocaleDateString("es-ES", {
                  year: "numeric",
                  month: "long",
                  day: "numeric",
                })
                .toUpperCase()
            }}</span
          >
          <div class="float-right text-left text-h5 mb-2" v-if="reportes > 0">
            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">
                <download-excel
                  :data="registros"
                  :fields="json_fields"
                  worksheet="Balance"
                  name="Balance_General"
                  :before-generate="formarReporte"
                >
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
                </download-excel>
              </template>
              <span> Generar Reporte</span>
            </v-tooltip>
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
        <v-container
          class="pt-0 px-0 mx-0 pb-7"
          style="max-width: 100% !important"
        >
          <v-row>
            <v-col cols="12" sm="6" md="6" lg="6">
              <v-card>
                <v-card-title
                  class="subheading text-center black white--text"
                  style="display: block"
                >
                  Activos
                </v-card-title>
                <v-divider />
                <v-list dense class="px-4">
                  <v-list-item dense>
                    <v-list-item-content dense class="text-subtitle-1"
                      >Efectivo:</v-list-item-content
                    >
                    <v-list-item-content class="align-end text-right">
                      <v-text-field
                        readonly
                        style="max-width: 100%"
                        dense
                        filled
                        class="pa-0"
                        align="right"
                        required
                        type="text"
                        :min="0"
                        v-model="efectivo"
                      ></v-text-field>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item>
                    <v-list-item-content dense class="text-subtitle-1"
                      >Bancos:</v-list-item-content
                    >
                    <v-list-item-content
                      class="align-end text-right pa-0"
                      style="width: 100px"
                    >
                      <v-text-field
                        readonly
                        style="max-width: 100%"
                        dense
                        filled
                        class="pa-0"
                        align="right"
                        required
                        type="text"
                        v-model="bancos"
                      ></v-text-field>
                    </v-list-item-content>
                  </v-list-item>
                  <v-divider />
                  <v-list-item class="pt-4 pb-4">
                    <v-list-item-content
                      class="text-subtitle-1 font-weight-bold"
                      >Total activo circulante:</v-list-item-content
                    >
                    <v-list-item-content
                      class="align-end text-right"
                      style="display: block"
                    >
                      <span class="text-subtitle-1 font-weight-bold">{{
                        totalCirculante
                      }}</span>
                    </v-list-item-content>
                  </v-list-item>
                  <v-divider />
                  <v-list-item dense>
                    <v-list-item-content dense class="text-subtitle-1"
                      >Deuda por cobrar:</v-list-item-content
                    >
                    <v-list-item-content class="align-end text-right">
                      <v-text-field
                        readonly
                        style="max-width: 100%"
                        dense
                        filled
                        class="pa-0"
                        align="right"
                        required
                        type="text"
                        v-model="deudaxc"
                      ></v-text-field>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item dense>
                    <v-list-item-content dense class="text-subtitle-1"
                      >Activo fijo:</v-list-item-content
                    >
                    <v-list-item-content class="align-end text-right">
                      <v-text-field
                        readonly
                        style="max-width: 100%"
                        dense
                        filled
                        class="pa-0"
                        align="right"
                        required
                        type="text"
                        v-model="activofijo"
                      ></v-text-field>
                    </v-list-item-content>
                  </v-list-item>
                  <v-divider />
                  <v-list-item class="pt-2">
                    <v-list-item-content
                      class="text-subtitle-1 font-weight-bold"
                      >Total activo no circulante:</v-list-item-content
                    >
                    <v-list-item-content
                      class="align-end text-right"
                      style="display: block"
                    >
                      <span class="text-subtitle-1 font-weight-bold">{{
                        totalNoCirculante
                      }}</span>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item>
                    <v-list-item-content
                      class="text-h6 indigo--text font-weight-bold"
                      >TOTAL ACTIVO:</v-list-item-content
                    >
                    <v-list-item-content
                      class="align-end text-right"
                      style="display: block"
                    >
                      <span class="text-h5 indigo--text font-weight-bold">{{
                        totalActivo
                      }}</span>
                    </v-list-item-content>
                  </v-list-item>
                </v-list>
              </v-card>
            </v-col>
            <v-col cols="12" sm="6" md="6" lg="6">
              <v-card>
                <v-card-title
                  class="subheading text-center black white--text"
                  style="display: block"
                >
                  Pasivos
                </v-card-title>
                <v-divider />
                <v-list dense class="px-4">
                  <v-list-item dense>
                    <v-list-item-content dense class="text-subtitle-1"
                      >Deudas por pagar:</v-list-item-content
                    >
                    <v-list-item-content class="align-end text-right">
                      <v-text-field
                        readonly
                        style="max-width: 100%"
                        dense
                        filled
                        class="pa-0"
                        align="right"
                        required
                        type="text"
                        v-model="deudaxp"
                      ></v-text-field>
                    </v-list-item-content>
                  </v-list-item>
                  <v-divider />
                  <v-list-item class="pt-4 pb-4">
                    <v-list-item-content
                      class="text-subtitle-1 font-weight-bold"
                      >Total pasivo:</v-list-item-content
                    >
                    <v-list-item-content
                      class="align-end text-right"
                      style="display: block"
                    >
                      <span class="text-subtitle-1 font-weight-bold">{{
                        deudaxp
                      }}</span>
                    </v-list-item-content>
                  </v-list-item>
                </v-list>
              </v-card>
              <br />
              <v-card>
                <v-card-title
                  class="subheading text-center black white--text"
                  style="display: block"
                >
                  Capital
                </v-card-title>
                <v-divider />
                <v-list dense class="pt-4 px-4">
                  <v-list-item>
                    <v-list-item-content
                      class="text-subtitle-1 font-weight-bold"
                      >Capital inicial:</v-list-item-content
                    >
                    <v-list-item-content
                      class="align-end text-right"
                      style="display: block"
                    >
                      <span class="text-subtitle-1 font-weight-bold">{{
                        capitalInicial
                      }}</span>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item>
                    <v-list-item-content
                      class="text-subtitle-1 font-weight-bold"
                      >Utilidad/Perdida:</v-list-item-content
                    >
                    <v-list-item-content
                      class="align-end text-right"
                      style="display: block"
                    >
                      <span class="text-subtitle-1 font-weight-bold">{{
                        utilidadPerdida
                      }}</span>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item class="pb-4">
                    <v-list-item-content
                      class="text-subtitle-1 font-weight-bold"
                      >Capital final:</v-list-item-content
                    >
                    <v-list-item-content
                      class="align-end text-right"
                      style="display: block"
                    >
                      <span class="text-subtitle-1 font-weight-bold">{{
                        capitalFinal
                      }}</span>
                    </v-list-item-content>
                  </v-list-item>
                  <v-divider />
                  <v-list-item class="pt-5 pb-1">
                    <v-list-item-content
                      class="text-h6 indigo--text font-weight-bold"
                      >TOTAL PASIVO + CAPITAL:</v-list-item-content
                    >
                    <v-list-item-content class="align-end text-right">
                      <span class="text-h5 indigo--text font-weight-bold">{{
                        totalPasivoMasCapital
                      }}</span>
                    </v-list-item-content>
                  </v-list-item>
                </v-list>
              </v-card>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </base-material-card>
  </v-main>
</template>
<script>
import Utils from "../util/utils";
import Loading from "../components/Loading";
import AlertDialog from "../components/AlertDialog";
import CompanyServices from "../network/services/CompanyService";
import JsonExcel from "vue-json-excel";
import ReportService from "../network/services/ReportService";
import Vue from "vue";
Vue.component("downloadExcel", JsonExcel);

export default {
  components: {
    Loading,
    AlertDialog,
  },
  data: () => ({
    loading: false,
    mensaje: "",
    esCancelar: false,
    esAceptar: false,
    vToolBarColor: "",
    dialogAlert: false,
    efectivo: "",
    bancos: "",
    deudaxc: "",
    activofijo: "",
    deudaxp: "",
    utilidadPerdida: "",
    capitalFinal: "",
    capitalInicial: "",
    totalActivo: "",
    totalCirculante: "",
    totalNoCirculante: "",
    totalPasivoMasCapital: "",
    overlay: true,
    formatter: new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "USD",
    }),
    reportes: 0,
    json_fields: {
      ACTIVOS: "conceptoactivo",
      "": "importeactivo",
      PASIVOS: "conceptopasivo",
      " ": "importepasivo",
    },
    registros: [],
  }),

  created() {
    this.ReportService = new ReportService();
    this.CompanyServices = new CompanyServices();
    this.Utils = new Utils();
    this.getGeneralBalances();
    this.validarGenerarReporte();
    this.$root.$refs.Dashboard.percentagecompletion();
  },
  methods: {
    formarReporte() {
      this.registros.push(
        {
          conceptoactivo: "Efectivo",
          importeactivo: this.efectivo,
          conceptopasivo: "Deudas por pagar",
          importepasivo: this.deudaxp,
        },
        {
          conceptoactivo: "Bancos",
          importeactivo: this.bancos,
          conceptopasivo: "Total de pasivo",
          importepasivo: this.deudaxp,
        },
        {
          conceptoactivo: "Total de activo circulante",
          importeactivo: this.totalCirculante,
          conceptopasivo: "CAPITAL",
        },
        {
          conceptoactivo: "Deuda por cobrar",
          importeactivo: this.deudaxc,
          conceptopasivo: "Capital inicial",
          importepasivo: this.capitalInicial,
        },
        {
          conceptoactivo: "Activo fijo",
          importeactivo: this.activofijo,
          conceptopasivo: "Utilidad / Perdida",
          importepasivo: this.utilidadPerdida,
        },
        {
          conceptoactivo: "Total de activo no circulante",
          importeactivo: this.totalNoCirculante,
          conceptopasivo: "Capital final",
          importepasivo: this.capitalFinal,
        },
        {},
        {
          conceptoactivo: "Total de activo",
          importeactivo: this.totalActivo,
          conceptopasivo: "Total de pasivo mas capital",
          importepasivo: this.totalPasivoMasCapital,
        }
      );
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
        this.overlay = false;
        this.eliminar = false;
      } else
        this.messageCreateAccountResponse(
          "No cuentas con reportes disponibles para la descarga. Favor de mejorar tu membresía.",
          false,
          true,
          "red"
        );
    },
    messageCreateAccountResponse(message, esCancelar, esAceptar, color) {
      this.mensaje = message;
      this.esCancelar = esCancelar;
      this.esAceptar = esAceptar;
      this.vToolBarColor = color;
      this.dialogAlert = true;

      this.overlay = false;
    },
    async getGeneralBalances() {
      this.overlay = true;
      const response = await this.CompanyServices.GetGeneralBalance(
        this.Utils.GetValue("EmpresaTransID")
      );

      if (response.status === 0 || response.status === 500) {
        this.messageCreateAccountResponse(response.message, false, true, "red");
        this.overlay = false;
      } else {
        console.log(response.data.response[0]);
        this.efectivo = this.formatter.format(
          parseFloat(response.data.response[0].Efectivo)
        );
        this.bancos = this.formatter.format(
          parseFloat(response.data.response[0].Bancos)
        );
        this.deudaxc = this.formatter.format(
          parseFloat(response.data.response[0].DeudasCobrar)
        );
        this.deudaxp = this.formatter.format(
          parseFloat(response.data.response[0].DeudasPagar)
        );
        this.activofijo = this.formatter.format(
          parseFloat(response.data.response[0].ActivoFijo)
        );
        this.utilidadPerdida = this.formatter.format(
          parseFloat(response.data.response[0].UtilidadPerdida)
        );
        this.capitalFinal = this.formatter.format(
          parseFloat(response.data.response[0].CapitalFinal)
        );
        this.capitalInicial = this.formatter.format(
          parseFloat(response.data.response[0].CapitalInicial)
        );
        this.totalActivo = this.formatter.format(
          parseFloat(response.data.response[0].TotalActivo)
        );
        this.totalCirculante = this.formatter.format(
          parseFloat(response.data.response[0].TotalCirculante)
        );
        this.totalNoCirculante = this.formatter.format(
          parseFloat(response.data.response[0].TotalNoCirculante)
        );
        this.totalPasivoMasCapital = this.formatter.format(
          parseFloat(response.data.response[0].TotalPasivoMasCapital)
        );
        this.overlay = false;
      }

      this.overlay = false;
    },
    validarNumero(e) {
      if (e.keyCode < 48 || e.keyCode > 57) {
        if (e.keyCode != 46) e.preventDefault();
      }
    },
  },
};
</script>
