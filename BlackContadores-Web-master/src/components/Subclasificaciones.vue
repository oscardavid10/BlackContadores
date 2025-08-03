<template id="ca">
  <v-main class="px-4" style="padding: 0px; padding-top: 82px; height: 100%">
    <SubclasificacionAlert
      :dialog.sync="dialog"
      :title="titulo"
      :accion="accion"
      :subclasificacionID="subclasificacionID"
      :subclasificacion="subclasificacion"
      :clasificacionID="clasificacionID"
      :activo="activo"
      @getSubclasificaciones="getSubclasificaciones"
    />

    <v-dialog v-model="eliminar" persistent max-width="500">
      <v-card>
        <v-card-title class="text-h5">
          ¿Eliminar la subclasificación "{{ nombreSubClasificacion }}" ?
        </v-card-title>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="red darken-1" text @click="eliminar = false">
            Cancelar
          </v-btn>
          <v-btn color="green darken-1" text @click="DeleteSubclasification">
            Aceptar
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

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
          SUBCLASIFICACIONES |
          <span class="text-subtitle-1" id="textDescription"
            >Gestiona las subclasificaciones para registrar movimientos en tu
            empresa.</span
          >
        </p>
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
                  CONCEPTO
                </th>
                <th
                  class="
                    text-center text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  CLASIFICACIÓN
                </th>
                <th
                  class="
                    text-center text-truncate
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
              <tr v-for="item in items" :key="item.ConceptoID">
                <td style="text-align: center">
                  {{ item.Concepto }}
                </td>
                <td style="text-align: center">
                  {{ item.Clasificacion }}
                </td>
                <td style="text-align: center">
                  {{ item.EsActivo ? "Activo" : "Inactivo" }}
                </td>
                <td style="width: 10px">
                  <v-icon
                    @click="
                      mostrarRegistroAlert(
                        2,
                        'Editar subclasificacion',
                        item.ConceptoID,
                        item.Concepto,
                        item.ClasificacionID,
                        item.EsActivo
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
                        'Consultar subclasificacion',
                        item.ConceptoID,
                        item.Concepto,
                        item.ClasificacionID,
                        item.EsActivo
                      )
                    "
                  >
                    mdi-file-search
                  </v-icon>
                </td>
                <td style="width: 10px">
                  <v-icon @click="onDelete(item.ConceptoID, item.Concepto)">
                    mdi-delete
                  </v-icon>
                </td>
              </tr>
            </tbody>
            <tr style="height: 200px" v-else>
              <td colspan="9" style="text-align: center; font-size: 20px">
                {{ "No tienes subclasificaciones registradas" }}
              </td>
            </tr>
          </template>
        </v-simple-table>
        <v-btn
          @click="
            mostrarRegistroAlert(0, 'Agregar nueva subclasificacion', 0, '', 0)
          "
          color="blue"
          dark
          absolute
          bottom
          right
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
import SubclasificacionAlert from "../components/SubclasificacionAlert";
import CompanyServices from "../network/services/CompanyService";
import Loading from "../components/Loading";
import AlertDialog from "../components/AlertDialog";
import Utils from "../util/utils";

export default {
  components: {
    Loading,
    AlertDialog,
    SubclasificacionAlert,
  },
  data: () => ({
    activo: false,
    mensaje: "",
    items: [],
    dialog: false,
    dialogAlert: false,
    esCancelar: false,
    esAceptar: false,
    vToolBarColor: "",
    overlay: true,
    subclasificacionID: 0,
    clasificacionID: 0,
    subclasificacion: "",
    titulo: "",
    accion: 0,
    eliminar: false,
    nombreSubClasificacion: "",
  }),
  created() {
    this.CompanyServices = new CompanyServices();
    this.Utils = new Utils();
    this.getSubclasificaciones();
  },
  methods: {
    async DeleteSubclasification() {
      this.overlay = true;

      let params = {
        SubClasificacionID: this.subclasificacionID,
        EmpresaTransID: this.Utils.GetValue("EmpresaTransID"),
      };

      const rs_registriesitems =
        await this.CompanyServices.PostDeleteSubclasifications(params);

      if (rs_registriesitems.data.success != "true")
        this.messageCreateAccountResponse(
          rs_registriesitems.data.message,
          false,
          true,
          "red"
        );

      this.getSubclasificaciones();
      this.overlay = false;
      this.eliminar = false;
    },
    onDelete(subclasificacionID, nombreSubClasificacion) {
      this.subclasificacionID = subclasificacionID;
      this.nombreSubClasificacion = nombreSubClasificacion;
      this.eliminar = true;
    },
    mostrarRegistroAlert(
      accion,
      titulo,
      subclasificacionID,
      subclasificacion,
      clasificacionID,
      activo
    ) {
      this.titulo = titulo;
      this.accion = accion;
      this.subclasificacionID = subclasificacionID;
      this.subclasificacion = subclasificacion;
      this.clasificacionID = clasificacionID;
      this.activo = activo;
      this.dialog = true;
    },
    async getSubclasificaciones() {
      this.overlay = true;

      let data = {
        EmpresaTransID: this.Utils.GetValue("EmpresaTransID"),
        mostrarInactivos: 1,
      };
      const response = await this.CompanyServices.GetSubclasifications(data);

      if (response.status === 0 || response.status === 500) {
        this.messageCreateAccountResponse(response.message, false, true, "red");
        this.overlay = false;
      } else {
        this.items = response.data.response;
        this.overlay = false;
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