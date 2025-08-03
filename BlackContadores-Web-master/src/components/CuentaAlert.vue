<template>
  <v-row justify="center">
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

    <Loading :overlay="overlay" />

    <v-dialog v-model="dialog" persistent max-width="550px">
      <v-card>
        <v-card-title id="titleStyle">
          <span class="headline"
            >{{ title }}
            <span v-if="cuenta != ''"> | Cuenta: <br />{{ cuenta }}</span></span
          >
        </v-card-title>

        <v-container>
          <v-row no-gutters>
            <v-col cols="12" sm="12">
              <v-select
                v-if="tipoID != 3 && tipoID != 4"
                :value="tipoID"
                ref="tipo"
                outlined
                label="Tipo de cuenta (*)"
                required
                :items="itemsTipo"
                item-text="Descripcion"
                item-value="TipoCuentaID"
                item-key="itemsTipo"
                return-object
                prepend-icon="mdi-format-list-bulleted-type"
                @change="tipoSeleccionada"
              ></v-select>
            </v-col>
            <v-col cols="12" sm="12" md="12">
              <v-text-field
                label="Nombre de la cuenta (*)"
                required
                outlined
                v-model="nombre"
                prepend-icon="mdi-bank"
                style="padding-left: 1px"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="12" justify-right class="justify-right">
              <v-switch
                class="float-right"
                v-model="activo"
                :label="activo ? 'Activa' : 'Inactiva'"
              ></v-switch>
            </v-col>
          </v-row>
        </v-container>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn width="25%" color="error" @click.native="cancelar">
            Cancelar
          </v-btn>
          <v-btn
            width="30%"
            color="blue"
            dark
            v-if="accion != 3"
            @click.native="aceptar"
          >
            Guardar
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import CompanyServices from "../network/services/CompanyService";
import Constants from "../util/constants";
import AlertDialog from "../components/AlertDialog";
import Loading from "../components/Loading";
import Utils from "../util/utils";

export default {
  components: {
    AlertDialog,
    Loading,
  },
  props: {
    dialog: { type: Boolean, default: false },
    title: { type: String, default: "" },
    accion: { type: Number, default: 0 },
    cuenta: { type: String, default: "" },
    cuentaID: { type: Number, default: 0 },
    infoRegistro: { type: Array, default: null },
  },
  data: () => ({
    activo: true,
    nombre: "",
    esAceptar: false,
    esCancelar: false,
    dialogAlert: false,
    mensaje: "",
    value: true,
    overlay: false,
    vToolBarColor: "green",
    itemsTipo: [],
    tipoID: 0,
    rules: {
      required: (value) => !!value || "Este campo es requerido",
    },
  }),
  watch: {
    dialog() {
      if (this.accion != 0) this.getInfoCuenta();
    },
  },
  created() {
    this.CompanyServices = new CompanyServices();
    this.Utils = new Utils();
    this.getTypeAccount();
  },
  methods: {
    tipoSeleccionada(value) {
      this.tipoID = value.TipoCuentaID;
    },
    async getTypeAccount() {
      await this.CompanyServices.GetTypeAccount().then((response) => {
        if (response.status === 200) {
          this.itemsTipo = response.data.response;
        }
      });
    },
    async getInfoCuenta() {
      let params = {
        cuentaID: this.cuentaID,
      };

      var response = await this.CompanyServices.GetBankaccount(params);

      if (response.data.success !== false) {
        this.nombre = response.data.response.Descripcion;
        this.activo = response.data.response.EsActivo;
        this.tipoID = response.data.response.TipoCuentaID;
      } else {
        //this.Utils.SetValue("", "authToken");
        this.messageCreateAccountResponse(
          response.data.message,
          false,
          true,
          "red"
        );
      }
    },
    async aceptar() {
      if (this.nombre != "") {
        //this.overlay = true;

        let EmpresaTransID = this.Utils.GetValue("EmpresaTransID");

        let data = {
          cuentaID: this.cuentaID,
          empresaTransID: EmpresaTransID, //new Utils().GetValue("empresaTransID"),
          descripcionCuenta: this.nombre,
          correoUsuario: this.Utils.GetValue("correoUsuario"),
          esActivo: this.activo,
          tipoCuentaID: this.tipoID,
        };

        let rs_registro = null;
        if (this.accion == 0)
          rs_registro = await this.CompanyServices.PostCuenta(data);
        else rs_registro = await this.CompanyServices.PostUpdateCuenta(data);

        if (rs_registro.data.success == "true") {
          this.overlay = false;

          this.overlay = false;
          this.mensaje = rs_registro.data.message;
          this.esCancelar = false;
          this.esAceptar = true;
          this.vToolBarColor = "green";

          this.dialogAlert = true;

          this.nombre = "";
          this.$emit("update:dialog", false);
          this.$emit("getCuentas");
          this.overlay = false;
        } else {
          this.overlay = false;
          this.mensaje = rs_registro.data.message;
          this.esCancelar = false;
          this.esAceptar = true;
          this.vToolBarColor = "GREEB";

          this.dialogAlert = true;
        }
      } else {
        this.overlay = false;
        this.mensaje = Constants.str_error_registry;
        this.esCancelar = false;
        this.esAceptar = true;
        this.vToolBarColor = "red";

        this.dialogAlert = true;
      }
    },
    cancelar() {
      this.nombre = "";
      this.$emit("update:dialog", false);
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