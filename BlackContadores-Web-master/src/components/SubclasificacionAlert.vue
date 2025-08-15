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

    <v-dialog v-model="dialog" persistent max-width="540px">
      <v-card>
        <v-card-title id="titleStyle">
          <span class="headline"
            >{{ title }}
            <span v-if="subclasificacion != ''">
              | Subclasificación: <br />{{ subclasificacion }}</span
            ></span
          >
        </v-card-title>
        <v-container>
          <v-row no-gutters>
            <v-col cols="12" sm="12" md="12">
              <v-text-field
                label="Nombre de la subclasificacion (*)"
                required
                outlined
                v-model="nombre"
                prepend-icon="mdi-file-tree"
                style="padding-left: 1px"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="12" justify-right class="justify-right">
              <v-autocomplete
                :value="ClasificacionID"
                ref="clasificaciones"
                outlined
                label="Clasificación (*)"
                required
                prepend-icon="mdi-book-account-outline"
                :items="itemsClasificacion"
                item-text="Clasificacion"
                item-value="ClasificacionID"
                item-key="itemsClasificacion"
                return-object
                :disabled="pagos"
                @change="clasificacionSeleccionada"
              ></v-autocomplete>
            </v-col>
            <v-col cols="12" sm="12" justify-right class="justify-right">
              <v-switch
                class="float-right"
                v-model="Activo"
                :label="Activo ? 'Activa' : 'Inactiva'"
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
    subclasificacion: { type: String, default: "" },
    subclasificacionID: { type: Number, default: 0 },
    clasificacionID: { type: Number, default: 0 },
    infoRegistro: { type: Array, default: null },
    activo: { type: Boolean, default: false },
    saldos: { type: Boolean, default: false },
  },
  data: () => ({
    pagos: false,
    ClasificacionID: 0,
    itemsClasificacion: [],
    Activo: true,
    nombre: "",
    esAceptar: false,
    esCancelar: false,
    dialogAlert: false,
    mensaje: "",
    value: true,
    overlay: false,
    vToolBarColor: "green",
    rules: {
      required: (value) => !!value || "Este campo es requerido",
    },
  }),
  watch: {
    dialog(visible) {
      if (visible) {
        if (this.accion != 0) {
          this.nombre = this.$props.subclasificacion;
          this.ClasificacionID = this.$props.clasificacionID;
          this.Activo = this.$props.activo;
        }
        if (this.$props.saldos) {
          if (this.$props.clasificacionID == 1)
            this.itemsClasificacion = this.itemsClasificacion.filter(
              (Clasificacion) => Clasificacion.ClasificacionID == 1
            );
          else
            this.itemsClasificacion = this.itemsClasificacion.filter(
              (Clasificacion) =>
                Clasificacion.ClasificacionID == 2 ||
                Clasificacion.ClasificacionID == 3
            );
        }
      }
    },
  },
  created() {
    this.CompanyServices = new CompanyServices();
    this.Utils = new Utils();
  },
  mounted() {
    this.getclasifications();
    this.ClasificacionID = this.$props.clasificacionID;
    if (this.ClasificacionID == 4) this.pagos = true;
  },
  methods: {
    clasificacionSeleccionada(value) {
      this.ClasificacionID = value.ClasificacionID;
    },
    async getclasifications() {
      const rs_itemsclasificacion =
        await this.CompanyServices.GetClasifications();

      if (rs_itemsclasificacion.status === 200)
        this.itemsClasificacion = rs_itemsclasificacion.data.response;
    },
    async aceptar() {
      if (this.nombre != "" && this.ClasificacionID != "") {
        //this.overlay = true;

        let EmpresaTransID = this.Utils.GetValue("EmpresaTransID");

        let data = {
          ConceptoID: this.subclasificacionID,
          EmpresaTransID: EmpresaTransID,
          Concepto: this.nombre,
          ClasificacionID: this.ClasificacionID,
          EsActivo: this.Activo,
        };

        let rs_registro = null;
        if (this.accion == 0)
          rs_registro = await this.CompanyServices.PostSubclasifications(data);
        else
          rs_registro = await this.CompanyServices.PostUpdateSubclasifications(
            data
          );

        if (rs_registro.data.success == "true") {
          this.$root.$refs.Dashboard.percentagecompletion();
          this.overlay = false;

          this.overlay = false;
          this.mensaje = rs_registro.data.message;
          this.esCancelar = false;
          this.esAceptar = true;
          this.vToolBarColor = "green";

          this.dialogAlert = true;

          this.nombre = "";
          this.$refs["clasificaciones"].reset();
          this.$emit("update:dialog", false);
          this.$emit("getSubclasificaciones");
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