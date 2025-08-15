<template>
  <v-row justify="center">
    <SubclasificacionAlert
      :dialog.sync="dialogsub"
      title="Agregar nueva subclasificación"
      :itemsClasificacion="itemsClasificacion"
      :saldos="$props.registroInicial"
      :clasificacionID="$props.esCxCInicial ? 1 : 3"
      @getSubclasificaciones="getsubclasifications"
    />
    <CuentaAlert
      :dialog.sync="dialogaccount"
      title="Agregar nueva cuenta"
      @getCuentas="getbankaccount"
    />
    <CuentaPorAlert
      :dialog.sync="dialogaccountto"
      :abono.sync="importe"
      :cxCID.sync="CxCID"
      :cuentaPagoID.sync="CuentaPagoID"
      :total.sync="Total"
      :subclasificacionID.sync="subclasificacionID"
      :title="'Selecciona cuenta por ' + (TipoCuenta == 3 ? 'cobrar' : 'pagar')"
      :tipoCuenta="TipoCuenta"
      :itemsSubClasificacion="itemsSubClasificacion"
      :itemsCuentas="cuentas"
      @getSubclasificaciones="getsubclasifications"
      @getCuentas="getbankaccount"
    />
    <!-- mostrar pantalla alerta para mensajes -->
    <AlertDialog
      titulo="Black Administrativo - [ Registro diario ]"
      :mensaje="mensaje"
      :esCancelar="esCancelar"
      :esAceptar="esAceptar"
      :vToolBarColor="vToolBarColor"
      :dialog.sync="dialogAlert"
    />
    <!-- -->

    <Loading :overlay="overlay" style='z-index:20001'/>

    <v-dialog v-model="dialog" persistent max-width="600px">
      <v-card>
        <v-card-title id="titleStyle">
          <span class="headline"
            >{{ title }}
            <span v-if="$props.registroInicial"
              ><br />
              | Saldo pendiente: ${{
                parseFloat(
                  $props.esCxCInicial
                    ? $root.$refs.Dashboard.cxcinicial
                    : $root.$refs.Dashboard.cxpinicial
                )
              }}</span
            >
            <span v-if="folio != ''"> | Folio: {{ folio }}</span></span
          >
        </v-card-title>

        <v-container>
          <v-row no-gutters>
            <v-col cols="12" sm="12" md="12">
              <v-text-field
                label="Descripción del movimiento (*)"
                required
                outlined
                :readonly="accion == 3 || (accion != 0 && registroInicial)"
                v-model="descripcionMovimiento"
                style="padding-left: 1px"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="4">
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
                    :disabled="accion == 3 || $props.registroInicial"
                    outlined
                    v-model="dateFormatted"
                    label="Fecha Registro"
                    readonly
                    v-bind="attrs"
                    v-on="on"
                    @blur="date = parseDate(dateFormatted)"
                  ></v-text-field>
                </template>
                <v-date-picker
                  locale="es-mx"
                  v-model="Fecha"
                  @input="menu2 = false"
                  :min="this.Utils.GetValue('AnioOperacion') + '-01-01'"
                  :max="
                    new Date(
                      new Date().getTime() -
                        new Date().getTimezoneOffset() * 60000
                    )
                      .toISOString()
                      .substr(0, 10)
                  "
                ></v-date-picker>
              </v-menu>
            </v-col>
            <v-col cols="12" sm="8">
              <v-text-field
                :readonly="accion == 3 || (accion != 0 && registroInicial)"
                v-model="referencia"
                outlined
                style="padding-left: 1px"
                label="Referencia"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="12">
              <v-autocomplete
                :readonly="
                  accion == 3 ||
                  ($props.registroInicial && $props.esCxCInicial) ||
                  (accion != 0 && registroInicial)
                "
                :value="clasificacionID"
                ref="clasificaciones"
                outlined
                label="Clasificación (*)"
                no-data-text="Sin clasificaciones disponibles"
                required
                :items="itemsClasificacion"
                item-text="Clasificacion"
                item-value="ClasificacionID"
                item-key="itemsClasificacion"
                return-object
                @change="clasificacionSeleccionada"
              ></v-autocomplete>
            </v-col>
            <v-col cols="10" sm="10" v-show="clasificacionID !== 4">
              <v-autocomplete
                :readonly="accion == 3 || (accion != 0 && registroInicial)"
                :v-model="subclasificacionID"
                :value="subclasificacionID"
                ref="subclasificaciones"
                outlined
                label="Subclasificación (*)"
                no-data-text="Sin subclasificaciones disponibles"
                required
                :items="itemsSubClasificacion"
                item-text="Concepto"
                item-value="ConceptoID"
                item-key="itemsSubClasificacion"
                return-object
                @change="subclasificacionSeleccionada"
              ></v-autocomplete>
            </v-col>
            <v-col
              v-show="clasificacionID !== 4"
              cols="2"
              sm="2"
              class="py-2 pl-2 pt-3 pr-2"
            >
              <v-tooltip bottom>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    :disabled="accion == 3"
                    block
                    v-bind="attrs"
                    v-on="on"
                    color="blue"
                    dark
                    @click.native="mostrarRegistroSubAlert"
                  >
                    <v-icon>mdi-plus</v-icon>
                  </v-btn>
                </template>
                <span>Agregar subclasificacion al catálogo</span>
              </v-tooltip>
            </v-col>
            <v-col cols="10" sm="10" xs="10">
              <v-autocomplete
                :readonly="accion == 3 || $props.registroInicial"
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
                label="Cuenta afectar (*)"
                @change="cuentaSeleccionada"
                style="padding-left: 1px"
              ></v-autocomplete>
            </v-col>
            <v-col cols="2" sm="2" class="p-2 pl-2 pr-2 pt-3">
              <v-tooltip bottom>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    :disabled="accion == 3 || $props.registroInicial"
                    block
                    v-bind="attrs"
                    v-on="on"
                    color="blue"
                    dark
                    @click.native="mostrarRegistroCuentaAlert"
                  >
                    <v-icon>mdi-plus</v-icon>
                  </v-btn>
                </template>
                <span>Agregar cuenta al catálogo</span>
              </v-tooltip>
            </v-col>

            <v-col v-show="clasificacionID == 5 || clasificacionID == 6" cols="12" sm="12">
              <v-autocomplete
                :readonly="accion == 3 || $props.registroInicial"
                required
                outlined
                :value="subcuentaID"
                ref="subcuentas"
                :items="itemsSubCuentas"
                item-value="CuentaID"
                item-text="Descripcion"
                no-data-text="Sin cuentas disponibles"
                item-key="itemsSubCuentas"
                return-object
                label="Subcuenta afectar (*)"
                style="padding-left: 1px"
                @change="subcuentaSeleccionada"
              ></v-autocomplete>
            </v-col>

            <v-col v-show="clasificacionID == 4" cols="12" sm="12">
              <div style="padding-left: 3px" class="my-2">
                <v-tooltip bottom>
                  <template v-slot:activator="{ on, attrs }">
                    <v-btn
                      :disabled="accion == 3"
                      block
                      v-bind="attrs"
                      v-on="on"
                      color="success"
                      large
                      dark
                      @click.native="mostrarRegistroCuentaToAlert"
                    >
                      Ver Cuentas afectables
                    </v-btn>
                  </template>
                  <span>Ver Cuentas</span>
                </v-tooltip>
              </div>
            </v-col>
            <v-col cols="12" sm="12" md="12">
              <v-textarea
                outlined
                :readonly="accion == 3"
                label="Observaciones"
                v-model="observaciones"
              ></v-textarea>
            </v-col>
            <v-col cols="6" sm="6" md="6"></v-col>
            <v-col cols="6" sm="6" md="6">
              <v-text-field
                v-currency
                :readonly="accion == 3"
                align="right"
                label="Importe (*)"
                required
                outlined
                :min="0"
                type="text"
                :value="importe"
                v-model="importe"
                @keypress="validarNumero"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn width="30%" color="error" @click.native="cancelar">
            Cancelar
          </v-btn>
          <v-btn
            width="40%"
            color="blue"
            dark
            v-if="accion != 3"
            @click.passive="aceptar"
          >
            Guardar
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import Vue from "vue";
import CompanyServices from "../network/services/CompanyService";
import Utils from "../util/utils";
import Constants from "../util/constants";
import AlertDialog from "../components/AlertDialog";
import Loading from "../components/Loading";
import CuentaAlert from "../components/CuentaAlert";
import CuentaPorAlert from "../components/CuentasPorAlert";
import SubclasificacionAlert from "../components/SubclasificacionAlert";
import { VueMaskDirective } from "v-mask";
Vue.directive("mask", VueMaskDirective);

export default {
  components: {
    AlertDialog,
    Loading,
    CuentaAlert,
    CuentaPorAlert,
    SubclasificacionAlert,
  },
  props: {
    dialog: { type: Boolean, default: false },
    registroInicial: { type: Boolean, default: false },
    esCxCInicial: { type: Boolean, default: false },
    title: { type: String, default: "" },
    accion: { type: Number, default: 0 },
    folio: { type: Number, default: 0 },
    folioID: { type: Number, default: 0 },
    infoRegistro: { type: Array, default: null },
  },
  data: (vm) => ({
    numericFormat: "$###,###.##",
    dateFormatted: vm.formatDate(
      new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10)
    ),
    Fecha: new Date(
      new Date().getTime() - new Date().getTimezoneOffset() * 60000
    )
      .toISOString()
      .substr(0, 10),
    CuentaPagoID: 0,
    menu2: false,
    descripcionMovimiento: "",
    referencia: "",
    fechaRegistro: "",
    clasificacionID: 0,
    subclasificacionID: 0,
    cuentaID: 0,
    subcuentaID: 0,
    observaciones: "",
    importe: "",
    Clasificacions: [],
    itemsClasificacion: [],
    itemsSubClasificacion: [],
    itemsCuentas: [],
    itemsSubCuentas: [],
    cuentas: [],
    subcuentas: [],
    esAceptar: false,
    esCancelar: false,
    dialogAlert: false,
    mensaje: "",
    overlay: false,
    vToolBarColor: "green",
    dialogaccount: false,
    dialogaccountto: false,
    dialogsub: false,
    SubClasificaciones: [],
    TipoCuenta: 0,
    Abono: 0,
    CxCID: 0,
    Total: 0,
    importeInicial: 0,
    guardando: false,
  }),
  watch: {
    Fecha() {
      var datefin = new Date();
      var date = new Date(this.Fecha);
      if (date > datefin) {
        this.dateFormatted = this.formatDate(datefin.toString());
        this.Fecha = datefin.toISOString().substr(0, 10);
      } else this.dateFormatted = this.formatDate(this.Fecha.toString());
    },
    dialog(visible) {
      if (visible) {
        console.log(this.$props.esCxCInicial);
        if (this.$props.registroInicial) {
          if (this.cuentas.length > 0) {
            if (this.$props.esCxCInicial) {
              this.clasificacionID = 1;
              this.itemsClasificacion = this.Clasificacions.filter(
                (Clasificacion) => Clasificacion.ClasificacionID == 1
              );
              this.cuentaID = this.cuentas.filter(
                (cuenta) => cuenta.TipoCuentaID == 3
              )[0].CuentaID;
              this.TipoCuenta = 3;
            } else {
              this.clasificacionID = 2;
              this.itemsClasificacion = this.Clasificacions.filter(
                (Clasificacion) =>
                  Clasificacion.ClasificacionID == 2 ||
                  Clasificacion.ClasificacionID == 3
              );
              this.cuentaID = this.cuentas.filter(
                (cuenta) => cuenta.TipoCuentaID == 4
              )[0].CuentaID;
              this.TipoCuenta = 4;
            }
          } else
            this.getbankaccount().then(() => {
              if (this.$props.esCxCInicial) {
                this.clasificacionID = 1;
                this.itemsClasificacion = this.Clasificacions.filter(
                  (Clasificacion) => Clasificacion.ClasificacionID == 1
                );
                this.cuentaID = this.cuentas.filter(
                  (cuenta) => cuenta.TipoCuentaID == 3
                )[0].CuentaID;
                this.TipoCuenta = 3;
              } else {
                this.clasificacionID = 2;
                this.itemsClasificacion = this.Clasificacions.filter(
                  (Clasificacion) =>
                    Clasificacion.ClasificacionID == 2 ||
                    Clasificacion.ClasificacionID == 3
                );
                this.cuentaID = this.cuentas.filter(
                  (cuenta) => cuenta.TipoCuentaID == 4
                )[0].CuentaID;
                this.TipoCuenta = 4;
              }
            });
          if (this.SubClasificaciones.length > 0) {
            this.itemsSubClasificacion = this.SubClasificaciones.filter(
              (Subclasificacion) =>
                Subclasificacion.ClasificacionID == this.clasificacionID
            );
          } else
            this.getbankaccount().then(() => {
              this.itemsSubClasificacion = this.SubClasificaciones.filter(
                (Subclasificacion) =>
                  Subclasificacion.ClasificacionID == this.clasificacionID
              );
            });
          this.Fecha =
            parseInt(this.Utils.GetValue("AnioOperacion")) - 1 + "-12-31";
          this.dateFormatted = this.formatDate(this.Fecha.toString());
        }
        if (this.accion != 0) this.getInfoRegistry();
      }
    },
  },
  created() {
    this.CompanyServices = new CompanyServices();
    this.Utils = new Utils();
    this.getCatalog();
  },

  mounted() {},
  methods: {
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
    getCatalog() {
      this.overlay = true;
      this.getbankaccount();
      this.getclasifications();
      this.getsubclasifications();
      this.overlay = false;
    },

    async getInfoRegistry() {
      let params = {
        folioID: this.folioID,
      };
      this.subclasificacionID = 0;
      await this.CompanyServices.GetRegistryTransaction(params).then(
        (response) => {
          if (response.data.success !== false) {
            this.referencia = response.data.response[0].Referencia;
            this.clasificacionID = response.data.response[0].ClasificacionID;
            this.itemsSubClasificacion = this.SubClasificaciones.filter(
              (Subclasificacion) =>
                Subclasificacion.ClasificacionID == this.clasificacionID
            );
            
            this.cuentaID = response.data.response[0].CuentaID;
            this.subcuentaID = response.data.response[0].SubCuentaID;
            this.descripcionMovimiento = response.data.response[0].Descripcion;
            this.fechaRegistro = response.data.response[0].FechaRegistro;
            this.importe = response.data.response[0].Importe;
            this.importeInicial = this.importe;
            this.observaciones = response.data.response[0].Observaciones;
            this.subclasificacionID =
              response.data.response[0].SubClasificacionID;

          } else {
            this.messageCreateAccountResponse(
              response.data.message,
              false,
              true,
              "red"
            );
          }
        }
      );
    },

    async getbankaccount() {
      let data = {
        empresaTransID: this.Utils.GetValue("EmpresaTransID"),
        mostrarInactivos: 0,
      };

      const rs_itemscuentas = await this.CompanyServices.GetBankaccounts(data);

      if (rs_itemscuentas.status === 200) {
        this.cuentas = rs_itemscuentas.data.response;
        this.subcuentas = rs_itemscuentas.data.response;
        this.itemsCuentas = rs_itemscuentas.data.response;
        this.itemsSubCuentas = rs_itemscuentas.data.response;

        this.itemsSubCuentas = this.subcuentas.filter((item) => {
            return (item.TipoCuentaID != 3 && item.TipoCuentaID != 4)
        })
      }
    },
    async getsubclasifications() {
      let data = {
        EmpresaTransID: this.Utils.GetValue("EmpresaTransID"),
        mostrarInactivos: 0,
      };
      const response = await this.CompanyServices.GetSubclasifications(data);
      if (response.status === 200) {
        this.SubClasificaciones = response.data.response;
        this.itemsSubClasificacion = this.SubClasificaciones.filter(
          (Subclasificacion) =>
            Subclasificacion.ClasificacionID == this.clasificacionID
        );
      }
    },
    async getclasifications() {
      const rs_itemsclasificacion =
        await this.CompanyServices.GetClasifications();

      if (rs_itemsclasificacion.status === 200) {
        this.itemsClasificacion = rs_itemsclasificacion.data.response;
        this.Clasificacions = rs_itemsclasificacion.data.response;
      }
    },

    fechaSeleccionada(fecha) {
      this.fechaRegistro = fecha;
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
    async guardarRegistro() {
      if (
        (this.$props.registroInicial &&
          this.importe > this.$root.$refs.Dashboard.cxcinicial &&
          this.TipoCuenta == 3) ||
        (this.$props.registroInicial &&
          this.importe > this.$root.$refs.Dashboard.cxpinicial &&
          this.TipoCuenta == 4)
      )
        this.messageCreateAccountResponse(
          "El importe no puede ser mayor al saldo de cuentas por " +
            (this.TipoCuenta == 3 ? "cobrar" : "pagar"),
          false,
          true,
          "red"
        );
      else {
        if (this.fechaRegistro == "") this.fechaRegistro = this.currentDate();
        this.overlay = true;

        let empresaTransID = this.Utils.GetValue("EmpresaTransID");

        let data = {
          empresaTransID: empresaTransID,
          descripcion: this.descripcionMovimiento,
          fechaRegistro: this.$props.registroInicial
            ? "31/12/" +
              (parseInt(this.Utils.GetValue("AnioOperacion")) - 1).toString()
            : this.formatDate(this.Fecha),
          referencia: this.referencia,
          clasificacionID: this.clasificacionID,
          cuentaID: this.cuentaID,
          observaciones: this.observaciones,
          importe: this.importe,
          folioID: this.folioID,
          subclasificacionID: this.subclasificacionID,
          tipoPagoCuenta: this.CuentaPagoID,
          subcuentaID: this.subcuentaID,
          CreadoPor: new Utils().GetValue("correoUsuario"),
          EsCxC: this.TipoCuenta == 3 ? true : false,
          EsCobranzaInicial: this.$props.registroInicial,
        };

        if (this.accion == 0)
          await this.CompanyServices.PostRegistryTransaction(data).then(
            (rs_registro) => {
              if (rs_registro.data.response[0].success) {
                if (this.clasificacionID == 4)
                  this.guardarAbono(rs_registro.data.response[0].FolioID);
                else {
                  if (this.$root.$refs.SaldosIniciales)
                    this.$root.$refs.SaldosIniciales.validarCuadreCuentas();
                  this.overlay = false;
                  this.descripcionMovimiento = "";
                  this.fechaRegistro = "";
                  this.referencia = "";
                  this.observaciones = "";
                  this.importe = "";
                  this.clasificacionID = 0;
                  this.subclasificacionID = 0;
                  this.cuentaID = 0;
                  this.subcuentaID=0;
                  this.$refs["clasificaciones"].reset();
                  this.$refs["cuentas"].reset();
                  this.$refs["subcuentas"].reset();
                  this.$emit("update:dialog", false);
                  this.$emit("getregistries");
                  this.overlay = false;
                  this.guardando = false;
                }
              } else {
                this.messageCreateAccountResponse(
                  rs_registro.data.response[0].message,
                  false,
                  true,
                  "red"
                );
                this.guardando = false;
              }
            }
          );
        else
          await this.CompanyServices.PostUpdateRegistryTransaction(data).then(
            (rs_registro) => {
              if (rs_registro.data.response[0].success) {
                this.overlay = false;
                this.descripcionMovimiento = "";
                this.fechaRegistro = "";
                this.referencia = "";
                this.observaciones = "";
                this.importe = "";
                this.clasificacionID = 0;
                this.subclasificacionID = 0;
                this.cuentaID = 0;
                this.subcuentaID = 0;
                this.$refs["clasificaciones"].reset();
                this.$refs["cuentas"].reset();
                this.$refs["subcuentas"].reset();
                this.$emit("update:dialog", false);
                this.$emit("getregistries");
                this.overlay = false;
                this.guardando = false;
              }
            }
          );
      }
    },
    messageCreateAccountResponse(message, esCancelar, esAceptar, color) {
      this.guardando = false;
      this.mensaje = message;
      this.esCancelar = esCancelar;
      this.esAceptar = esAceptar;
      this.vToolBarColor = color;
      this.dialogAlert = true;

      this.overlay = false;
    },
    async guardarAbono(folioID) {
      if (this.CxCID == 0) {
        this.mensaje =
          "Para guardar un pago es necesario seleccionar una cuenta y registrar un abono mayor a 0 y menor al saldo restante.";
        this.esCancelar = false;
        this.esAceptar = true;
        this.vToolBarColor = "red";
        this.guardando = false;
        this.dialogAlert = true;
        return false;
      }
      let data = {
        EsCxC: this.CxCID,
        Abono: this.importe,
        CreadoPor: new Utils().GetValue("correoUsuario"),
        Total: this.Total,
        TipoPagoCuentaID: this.CuentaPagoID,
        RegistroID: folioID,
      };

      await this.CompanyServices.PostCollection(data).then((response) => {
        if (response.data.success) {
          this.overlay = false;
          this.descripcionMovimiento = "";
          this.fechaRegistro = "";
          this.referencia = "";
          this.observaciones = "";
          this.importe = "";
          this.clasificacionID = 0;
          this.subclasificacionID = 0;
          this.cuentaID = 0;
          this.subcuentaID = 0;
          this.$refs["clasificaciones"].reset();
          this.$refs["cuentas"].reset();
          this.$refs["subcuentas"].reset();
          this.$emit("update:dialog", false);
          this.$emit("getregistries");
          this.overlay = false;
        }
      });
    },
    async aceptar() {
      if (!this.guardando) {
        this.guardando = true;
        if (
          this.descripcionMovimiento != "" &&
          this.clasificacionID != "" &&
          this.cuentaID != "" &&
          this.subclasificacionID != "" &&
          this.importe != ""
        ) {
          if (this.$props.registroInicial && this.accion != 0)
            this.guardarRegistroInicial();
          else this.guardarRegistro();
        } else {
          this.mensaje = Constants.str_error_registry;
          this.esCancelar = false;
          this.esAceptar = true;
          this.vToolBarColor = "red";

          this.dialogAlert = true;
        }
      }
    },
    async guardarRegistroInicial() {
      this.overlay = true;
      if (
        (this.$props.registroInicial &&
          this.importe - this.importeInicial >
            this.$root.$refs.Dashboard.cxcinicial &&
          this.TipoCuenta == 3) ||
        (this.$props.registroInicial &&
          this.importe - this.importeInicial >
            this.$root.$refs.Dashboard.cxpinicial &&
          this.TipoCuenta == 4)
      ) {
        this.messageCreateAccountResponse(
          "El importe no puede ser mayor al saldo de cuentas por " +
            (this.TipoCuenta == 3 ? "cobrar" : "pagar"),
          false,
          true,
          "red"
        );
      } else {
        await this.CompanyServices.PostAccountsOpeningBalance(
          this.folioID,
          this.importe
        ).then((response) => {
          if (response.status === 0 || response.status === 500) {
            this.messageCreateAccountResponse(
              response.message,
              false,
              true,
              "red"
            );
            this.guardando = false;
          } else {
            this.guardando = false;
            this.overlay = false;
            this.descripcionMovimiento = "";
            this.fechaRegistro = "";
            this.referencia = "";
            this.observaciones = "";
            this.importe = "";
            this.clasificacionID = 0;
            this.subclasificacionID = 0;
            this.cuentaID = 0;
            this.subcuentaID = 0;
            this.$refs["clasificaciones"].reset();
            this.$refs["cuentas"].reset();
            this.$refs["subcuentas"].reset();
            this.$emit("update:dialog", false);
            this.$emit("getregistries");
            this.overlay = false;
            if (this.$root.$refs.SaldosIniciales)
              this.$root.$refs.SaldosIniciales.validarCuadreCuentas();
          }
        });
      }
    },
    cancelar() {
      this.guardando = false;
      this.clasificacionID = 0;
      this.$refs["clasificaciones"].reset();
      this.$refs["subclasificaciones"].reset();
      this.$refs["cuentas"].reset();
      this.$refs["subcuentas"].reset();
      this.importe = "";
      this.descripcionMovimiento = "";
      this.referencia = "";
      this.observaciones = "";
      this.cuentaID = 0;
      this.subcuentaID= 0;
      this.sizecol = 6;
      this.$emit("update:dialog", false);
    },
    subclasificacionSeleccionada(value) {
      this.subclasificacionID = value.ConceptoID;
    },

    clasificacionSeleccionada(value) {
      this.clasificacionID = value.ClasificacionID;
      this.itemsSubClasificacion = this.SubClasificaciones.filter(
        (Subclasificacion) =>
          Subclasificacion.ClasificacionID == value.ClasificacionID
      );
      if (this.clasificacionID == 4)
        this.itemsCuentas = this.cuentas.filter(
          (cuenta) => cuenta.TipoCuentaID == 3 || cuenta.TipoCuentaID == 4
        );
      else this.itemsCuentas = this.cuentas;

      if(value.ClasificacionID == 5)
          this.itemsCuentas = this.subcuentas.filter((item) => item.TipoCuentaID == 3 || item.TipoCuentaID == 4);
    },
    cuentaSeleccionada(value) {
      this.cuentaID = value.CuentaID;
      this.TipoCuenta = this.cuentas.filter(
        (cuenta) => cuenta.CuentaID === value.CuentaID
      )[0]["TipoCuentaID"];
    },
    subcuentaSeleccionada(value) {
       this.subcuentaID =  value.CuentaID
    },
    mostrarRegistroSubAlert() {
      this.dialogsub = true;
    },
    mostrarRegistroCuentaAlert() {
      this.dialogaccount = true;
    },
    mostrarRegistroCuentaToAlert() {
      this.dialogaccountto = true;
    },
    limpiar() {},
    validarNumero(e) {
      if (e.keyCode < 48 || e.keyCode > 57) {
        if (e.keyCode != 46) e.preventDefault();
      }
    },
  },
};
</script>

<style scoped>
#titleStyle {
  background-color: black;
  color: white;
}
</style>
