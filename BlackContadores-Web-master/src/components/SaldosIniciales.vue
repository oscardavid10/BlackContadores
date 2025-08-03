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
    <Saldos
      :dialog.sync="dialog"
      :titulo="titulo"
      :esCxC="esCxCInicial"
      :ver="ver"
    />
    <base-material-card color="blue pa-0" style="height: 97%">
      <template v-slot:heading>
        <p class="text-left text-h5">
          SALDOS INICIALES |
          <span class="text-subtitle-1" id="textDescription"
            >Ajuste de saldos</span
          >
          <v-tooltip bottom>
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                class="ma-1 ml-7"
                v-bind="attrs"
                v-on="on"
                fab
                small
                @click="editar = !editar"
                :color="editar ? 'green' : ''"
              >
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
            </template>
            <span>{{ editar ? "Deshabilitar" : "Habilitar " }} Edición</span>
          </v-tooltip>
          <v-btn
            :loading="loading"
            :disabled="!editar"
            class="ma-1 ml-7"
            color="green"
            x-large
            :hidden="!editar"
            @click="guardarSaldos"
          >
            Guardar
          </v-btn>
        </p>
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
                        :readonly="!editar"
                        style="max-width: 100%"
                        dense
                        filled
                        class="pa-0"
                        prepend-inner-icon="mdi-currency-usd"
                        align="right"
                        required
                        type="number"
                        :min="0"
                        v-model="efectivo"
                        @keypress="validarNumero"
                        @change="onChange('efectivo')"
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
                        :readonly="!editar"
                        style="max-width: 100%"
                        dense
                        filled
                        class="pa-0"
                        prepend-inner-icon="mdi-currency-usd"
                        align="right"
                        required
                        type="number"
                        :min="0"
                        v-model="bancos"
                        @keypress="validarNumero"
                        @change="onChange('bancos')"
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
                        formatter.format(
                          parseFloat(bancos) + parseFloat(efectivo)
                        )
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
                        :readonly="!editar"
                        style="max-width: 100%"
                        dense
                        filled
                        class="pa-0"
                        prepend-inner-icon="mdi-currency-usd"
                        align="right"
                        required
                        type="number"
                        :min="0"
                        v-model="deudaxc"
                        @keypress="validarNumero"
                        @change="onChange('deudaxc')"
                        :append-icon="'mdi-eye'"
                        @click:append="
                          ver = true;
                          esCxCInicial = true;
                          titulo = 'Cuenta por cobrar iniciales';
                          dialog = true;
                        "
                      ></v-text-field>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item dense class="text-subtitle-1">
                    <v-list-item-content dense
                      >Activo fijo:</v-list-item-content
                    >
                    <v-list-item-content class="align-end text-right">
                      <v-text-field
                        :readonly="!editar"
                        style="max-width: 100%"
                        dense
                        filled
                        class="pa-0"
                        prepend-inner-icon="mdi-currency-usd"
                        align="right"
                        required
                        type="number"
                        :min="0"
                        v-model="activofijo"
                        @keypress="validarNumero"
                        @change="onChange('activofijo')"
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
                        formatter.format(
                          parseFloat(activofijo) + parseFloat(deudaxc)
                        )
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
                        formatter.format(
                          parseFloat(activofijo) +
                            parseFloat(deudaxc) +
                            parseFloat(bancos) +
                            parseFloat(efectivo)
                        )
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
                        :readonly="!editar"
                        style="max-width: 100%"
                        dense
                        filled
                        class="pa-0"
                        prepend-inner-icon="mdi-currency-usd"
                        align="right"
                        required
                        type="number"
                        :min="0"
                        v-model="deudaxp"
                        @keypress="validarNumero"
                        @change="onChange('deudaxp')"
                        :append-icon="'mdi-eye'"
                        @click:append="
                          ver = true;
                          esCxCInicial = false;
                          titulo = 'Cuenta por pagar iniciales';
                          dialog = true;
                        "
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
                        formatter.format(parseFloat(deudaxp))
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
                <v-list dense class="px-4">
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
                        formatter.format(
                          parseFloat(activofijo) +
                            parseFloat(deudaxc) +
                            parseFloat(bancos) +
                            parseFloat(efectivo) -
                            parseFloat(deudaxp)
                        )
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
                        formatter.format(parseFloat(0))
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
                        formatter.format(
                          parseFloat(activofijo) +
                            parseFloat(deudaxc) +
                            parseFloat(bancos) +
                            parseFloat(efectivo) -
                            parseFloat(deudaxp)
                        )
                      }}</span>
                    </v-list-item-content>
                  </v-list-item>
                  <v-divider />
                  <v-list-item class="pt-7 pb-1">
                    <v-list-item-content
                      class="text-h6 indigo--text font-weight-bold"
                      >TOTAL PASIVO + CAPITAL:</v-list-item-content
                    >
                    <v-list-item-content
                      class="align-end text-right"
                      style="display: block"
                    >
                      <span class="text-h5 indigo--text font-weight-bold">{{
                        formatter.format(
                          parseFloat(activofijo) +
                            parseFloat(deudaxc) +
                            parseFloat(bancos) +
                            parseFloat(efectivo)
                        )
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
import Saldos from "../components/Saldos";
import Utils from "../util/utils";
import Loading from "../components/Loading";
import AlertDialog from "../components/AlertDialog";
import CompanyServices from "../network/services/CompanyService";

export default {
  components: {
    Loading,
    AlertDialog,
    Saldos,
  },
  data: () => ({
    esCxCInicial: true,
    titulo: "Cuentas Iniciales",
    dialog: false,
    loading: false,
    mensaje: "",
    esCancelar: false,
    esAceptar: false,
    vToolBarColor: "",
    dialogAlert: false,
    efectivo: 0,
    bancos: 0,
    deudaxc: 0,
    activofijo: 0,
    deudaxp: 0,
    utilidad_perdida: 0,
    editar: false,
    overlay: true,
    ver: false,
    formatter: new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "USD",
    }),
  }),

  created() {
    this.CompanyServices = new CompanyServices();
    this.Utils = new Utils();
    this.getOpeningBalances();
    this.validarCuadreCuentas();
    this.$root.$refs.SaldosIniciales = this;
  },
  methods: {
    async validarCuadreCuentas() {
      this.dialogAlert = false;
      this.$root.$refs.Dashboard.collectionOpeningBalances().then(() => {
        if (this.$root.$refs.Dashboard.cxcinicial != 0) {
          if (!this.dialog)
            this.messageCreateAccountResponse(
              "Se detectaron cambios en tus saldos de deudas por cobrar inicales, para continuar utilizando el sistema es necesario que ajustes tus saldos de deuda.",
              false,
              false,
              "red"
            );
          this.esCxCInicial = true;
          setTimeout(() => {
            this.titulo = "Cuenta por cobrar iniciales";
            this.dialog = true;
            this.ver = false;
            this.$root.$refs.Saldos.getInitCxc();
          }, 2000);
        } else if (this.$root.$refs.Dashboard.cxpinicial != 0) {
          if (!this.dialog)
            this.messageCreateAccountResponse(
              "Se detectaron cambios en tus saldos de deudas por pagar inicales, para continuar utilizando el sistema es necesario que ajustes tus saldos de deuda.",
              false,
              false,
              "red"
            );
          this.esCxCInicial = false;
          setTimeout(() => {
            this.titulo = "Cuenta por pagar iniciales";
            this.dialog = true;
            this.ver = false;
            this.$root.$refs.Saldos.getInitCxc();
          }, 2000);
        } else this.dialog = false;
      });

    },
    onChange(tipo) {
      switch (tipo) {
        case "efectivo":
          if (this.efectivo == "") this.efectivo = 0;
          break;
        case "bancos":
          if (this.bancos == "") this.bancos = 0;
          break;
        case "activofijo":
          if (this.activofijo == "") this.activofijo = 0;
          break;
        case "deudaxc":
          if (this.deudaxc == "") this.deudaxc = 0;
          break;
        case "deudaxp":
          if (this.deudaxp == "") this.deudaxp = 0;
          break;
      }
    },
    messageCreateAccountResponse(message, esCancelar, esAceptar, color) {
      this.mensaje = message;
      this.esCancelar = esCancelar;
      this.esAceptar = esAceptar;
      this.vToolBarColor = color;
      this.dialogAlert = true;

      this.overlay = false;
    },
    async guardarSaldos() {
      this.loading = true;

      const data = {
        CorreoUsuario: new Utils().GetValue("correoUsuario"),
        CapitalInicial:
          parseFloat(this.activofijo) +
          parseFloat(this.deudaxc) +
          parseFloat(this.bancos) +
          parseFloat(this.efectivo) -
          parseFloat(this.deudaxp),
        CapitalFinal:
          parseFloat(this.activofijo) +
          parseFloat(this.deudaxc) +
          parseFloat(this.bancos) +
          parseFloat(this.efectivo) -
          parseFloat(this.deudaxp),
        DeudasPagar: this.deudaxp,
        ActivoFijo: this.activofijo,
        DeudasCobrar: this.deudaxc,
        Bancos: this.bancos,
        Efectivo: this.efectivo,
        EmpresaTransID: new Utils().GetValue("EmpresaTransID"),
      };

      var response = await this.CompanyServices.PostUpdateOpeningBalances(data);

      if (response.status === 0 || response.status === 500) {
        this.messageCreateAccountResponse(response.message, false, true, "red");
        this.overlay = false;
      } else {
        this.messageCreateAccountResponse(
          response.data.message,
          false,
          true,
          "green"
        );
        this.$root.$refs.Dashboard.percentagecompletion();
        this.editar = this.overlay = false;
        setTimeout(() => {
            this.validarCuadreCuentas();
          }, 2000);
      }

      this.loading = false;
    },
    async getOpeningBalances() {
      this.overlay = true;

      const response = await this.CompanyServices.GetOpeningBalance(
        this.Utils.GetValue("EmpresaTransID")
      );

      if (response.status === 0 || response.status === 500) {
        this.messageCreateAccountResponse(response.message, false, true, "red");
        this.overlay = false;
      } else {
        this.efectivo = response.data.response[0].Efectivo;
        this.bancos = response.data.response[0].Bancos;
        this.deudaxc = response.data.response[0].DeudasCobrar;
        this.deudaxp = response.data.response[0].DeudasPagar;
        this.activofijo = response.data.response[0].ActivoFijo;
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

