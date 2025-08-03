<template id="ca">
  <v-main class="px-4" style="padding: 0px; padding-top: 82px; height: 100%">
    <UsuarioAlert
      :dialog.sync="dialog"
      :title="titulo"
      :accion="accion"
      :usuarioID="usuarioID"
      :usuario="usuario"
      @getUsers="getUsers"
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
    <!-- -->

    <base-material-card color="blue pa-0">
      <template v-slot:heading>
        <p class="text-left text-h5">
          USUARIOS |
          <span class="text-subtitle-1" id="textDescription"
            >Gestiona los usuarios que pueden acceder a tu empresa.</span
          >
          <span class="text-h6 float-right white--text">{{
            mensajeUsuarios
          }}</span>
        </p>
        <span class="text-h6 float-right white--text">{{
          "Usuarios Disponibles: " + usuariosDisponibles
        }}</span>
      </template>
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
                  USUARIO
                </th>
                <th
                  class="
                    text-left text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  E-MAIL
                </th>
                <th
                  class="
                    text-left text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  FECHA REGISTRO
                </th>
                <th
                  class="
                    text-left text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  ESTATUS
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
              </tr>
            </thead>
            <tbody v-if="items.length > 0">
              <tr v-for="item in items" :key="item.FolioID">
                <td style="text-align: center">
                  {{ item.NombreUsuario }}
                </td>
                <td>
                  {{ item.CorreoUsuario }}
                </td>
                <td>
                  {{ item.FechaRegistro }}
                </td>
                <td>
                  {{ item.EsActivo ? "Activo" : "Inactivo" }}
                </td>
                <td style="width: 40px">
                  <v-icon
                    @click="
                      mostrarRegistroAlert(
                        2,
                        'Editar usuario',
                        item.UsuarioID,
                        item.NombreUsuario
                      )
                    "
                  >
                    mdi-pencil
                  </v-icon>
                </td>
                <td style="width: 40px">
                  <v-icon
                    @click="
                      mostrarRegistroAlert(
                        3,
                        'Consultar usuario',
                        item.UsuarioID,
                        item.NombreUsuario
                      )
                    "
                  >
                    mdi-file-search
                  </v-icon>
                </td>
              </tr>
            </tbody>
            <tr style="height: 200px" v-else>
              <td colspan="9" style="text-align: center; font-size: 20px">
                {{ "No tienes usuarios registrados" }}
              </td>
            </tr>
          </template>
        </v-simple-table>
        <v-btn
          @click="mostrarRegistroAlert(0, 'Agregar nuevo usuario', 0, '')"
          color="blue"
          dark
          absolute
          bottom
          right
          v-if="usuariosDisponibles > 0"
          class="mb-2 mr-4 rounded-circle"
          height="60"
        >
          <v-icon>mdi-plus</v-icon>
        </v-btn>
      </v-card-text>
    </base-material-card>
  </v-main>
</template>

<script>
import UsuarioAlert from "../components/UsuarioAlert";
import UserService from "../network/services/UserService";
import Loading from "../components/Loading";
import AlertDialog from "../components/AlertDialog";
import Utils from "../util/utils";

export default {
  components: {
    Loading,
    AlertDialog,
    UsuarioAlert,
  },
  data: () => ({
    mensaje: "",
    items: [],
    dialog: false,
    dialogAlert: false,
    esCancelar: false,
    esAceptar: false,
    vToolBarColor: "",
    overlay: true,
    usuarioID: 0,
    usuario: "",
    titulo: "",
    accion: 0,
    mensajeUsuarios: "",
    usuariosDisponibles: 0,
  }),
  created() {
    this.UserService = new UserService();
    this.Utils = new Utils();
    this.getUsers();
  },
  methods: {
    mostrarRegistroAlert(accion, titulo, usuarioID, usuario) {
      this.titulo = titulo;
      this.accion = accion;
      this.usuarioID = usuarioID;
      this.usuario = usuario;
      this.dialog = true;
    },
    async getUsers() {
      this.overlay = true;

      let empresaTransID = this.Utils.GetValue("EmpresaTransID");

      let params = {
        EmpresaTransID: empresaTransID, //new Utils().GetValue("empresaTransID"),
      };

      const response = await this.UserService.GetUsers(params);
      console.log(response);
      if (response.status === 0 || response.status === 500) {
        this.messageCreateAccountResponse(response.message, false, true, "red");
        this.overlay = false;
      } else if (response.data.success) {
        this.items = response.data.response;
        this.overlay = false;
        this.usuariosDisponibles =
          response.data.response[0]?.UsuariosDisponibles;
        this.mensajeUsuarios =
          response.data.response[0]?.UsuariosDisponibleMensaje;
      }

      this.overlay = false;
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