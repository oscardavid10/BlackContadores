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

    <v-dialog v-model="dialog" persistent max-width="500px">
      <v-card>
        <v-card-title id="titleStyle">
          <span class="headline"
            >{{ title }}
            <span v-if="usuario != ''"> | Usuario: <br>{{ usuario }}</span></span
          >
        </v-card-title>

        <v-container>
          <v-row no-gutters>
            <v-col cols="12" sm="12" md="12">
              <v-text-field
                label="Nombre del usuario (*)"
                required
                outlined
                v-model="nombre"
                prepend-icon="person"
                style="padding-left: 1px"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="12">
              <v-text-field
                readonly
                v-model="correo"
                outlined
                prepend-icon="email"
                style="padding-left: 1px"
                label="Correo electrónico (*)"
                color="light-blue accent-3"
                @click:append="() => (value = !value)"
                :type="value ? 'email' : 'text'"
                :rules="[rules.email]"
                @input="(_) => (email = _)"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="12">
              <v-text-field
                v-model="contra"
                outlined
                prepend-icon="lock"
                style="padding-left: 1px"
                label="Contraseña (*)"
                :value="contra"
                :append-icon="value ? 'mdi-eye-off' : 'mdi-eye'"
                @click:append="() => (value = !value)"
                :type="value ? 'password' : 'text'"
                :rules="[rules.password]"
                @input="(_) => (contra = _)"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="12" justify-right class="justify-right">
              <v-switch
                class="float-right"
                v-model="activo"
                :label="activo ? 'Activo' : 'Inactivo'"
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
import UserService from "../network/services/UserService";
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
    usuario: { type: String, default: "" },
    usuarioID: { type: Number, default: 0 },
    infoRegistro: { type: Array, default: null },
  },
  data: () => ({
    activo: true,
    nombre: "",
    correo: "",
    contra: "",
    esAceptar: false,
    esCancelar: false,
    dialogAlert: false,
    mensaje: "",
    value: true,
    overlay: false,
    vToolBarColor: "green",
    rules: {
      required: (value) => !!value || "Este campo es requerido",

      password: (value) => {
        const pattern =
          /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#/$%/^&/*])(?=.{8,})/;

        return (
          pattern.test(value) ||
          "Se requiere una contraseña mayor o igual a 8 caracteres. Incluye mayúsculas, números y caracteres especiales ($!#%&@)"
        );
      },

      email: (value) => {
        const pattern = /^[^@]+@[^@]+\.[a-zA-Z]{2,}$/;

        return (
          pattern.test(value) ||
          "Correo no válido. Favor de verificar la estructura (ejemplo@tuempresa.com)"
        );
      },
    },
  }),
  watch: {
    dialog() {
      if (this.accion != 0) this.getInfoUser();
    },
  },
  created() {
    this.UserService = new UserService();
    this.Utils = new Utils();
  },
  methods: {
    async getInfoUser() {
      let params = {
        usuarioID: this.usuarioID,
      };

      var response = await this.UserService.GetUser(params);

      if (response.data.success !== false) {
        this.nombre = response.data.response[0].NombreUsuario;
        this.contra = response.data.response[0].Contrasena;
        this.correo = response.data.response[0].CorreoUsuario;
        this.activo = response.data.response[0].EsActivo;
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
      if (this.nombre != "" && this.correo != "" && this.contra != "") {
        //this.overlay = true;

        let EmpresaTransID = this.Utils.GetValue("EmpresaTransID");

        let data = {
          EmpresaTransID: EmpresaTransID, //new Utils().GetValue("empresaTransID"),
          NombreUsuario: this.nombre,
          CorreoUsuario: this.correo,
          Contrasena: this.contra,
          usuarioID: this.usuarioID,
          EsActivo: this.activo,
        };

        let rs_registro = null;
        if (this.accion == 0)
          rs_registro = await this.UserService.PostUser(data);
        else rs_registro = await this.UserService.PostUpdateUser(data);

        console.log(rs_registro.data);
        if (rs_registro.data.success == "true") {
          this.overlay = false;
          this.nombre = "";
          this.contra = "";
          this.correo = "";
          this.$emit("update:dialog", false);
          this.$emit("getUsers");
          this.overlay = false;
        } else {
          this.overlay = false;
          this.mensaje = rs_registro.data.message;
          this.esCancelar = false;
          this.esAceptar = true;
          this.vToolBarColor = "red";

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
      this.contra = "";
      this.correo = "";
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