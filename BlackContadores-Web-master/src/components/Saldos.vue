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
    <RegistroDiarioAlert
      :dialog.sync="dialogRegistro"
      :title="tituloRegistro"
      :accion="accion"
      :folioID="registroID"
      :folio="folio"
      @getregistries="getInitCxc"
      :registroInicial="true"
      :esCxCInicial="esCxC"
    />
    <Loading :overlay="overlay" />

    <v-dialog v-model="eliminar" persistent max-width="500">
      <v-card>
        <v-card-title class="text-h5">
          ¿Eliminar la cuenta inicial con folio "{{ folio }}" ?
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

    <v-dialog v-model="dialog" persistent max-width="1000px">
      <v-card>
        <v-card-title id="titleStyle">
          <span class="headline mr-2">{{ $props.titulo }}</span>
          <span>
            | Saldo pendiente por registrar: ${{
              parseFloat(
                $props.esCxC
                  ? $root.$refs.Dashboard.cxcinicial
                  : $root.$refs.Dashboard.cxpinicial
              )
            }}</span
          >
        </v-card-title>

        <v-simple-table fixed-header height="500px" class="grey lighten-3">
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
                    text-center text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  DESCRIPCION
                </th>
                <th
                  class="
                    text-center text-truncate
                    font-weight-regular
                    black
                    white--text
                  "
                >
                  TOTAL
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
              <tr v-for="item in items" :key="item.RegistroID">
                <td style="text-align: center">
                  {{ item.Folio }}
                </td>
                <td style="text-align: center">
                  {{ item.Descripcion }}
                </td>
                <td style="text-align: center">
                  {{ formatter.format(item.Total) }}
                </td>
                <td style="width: 10px">
                  <v-icon
                    @click="
                      mostrarRegistroAlert(
                        2,
                        'Editar registro',
                        item.RegistroID,
                        item.Folio
                      )
                    "
                  >
                    mdi-pencil
                  </v-icon>
                </td>
                <td style="width: 10px">
                  <v-icon @click="onDelete(item.RegistroID, item.Folio)">
                    mdi-delete
                  </v-icon>
                </td>
              </tr>
            </tbody>
            <tr style="height: 200px" v-else>
              <td colspan="9" style="text-align: center; font-size: 20px">
                {{ "No tienes cuentas iniciales registradas" }}
              </td>
            </tr>
          </template>
        </v-simple-table>
        <v-btn
          v-show="
            $root.$refs.Dashboard.cxcinicial != 0 ||
            $root.$refs.Dashboard.cxpinicial != 0
          "
          @click="mostrarRegistroAlert(0, 'Agregar nueva cuenta', 0, 0)"
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
      </v-card>
      <v-card-actions class="white" v-show="ver">
        <v-spacer></v-spacer>
        <v-btn width="30%" color="error" @click.native="cancelar">
          Cerrar
        </v-btn>
      </v-card-actions>
    </v-dialog>
  </v-row>
</template>

<script>
import RegistroDiarioAlert from "../components/RegistroDiarioAlert";
import CompanyServices from "../network/services/CompanyService";
import AlertDialog from "../components/AlertDialog";
import Loading from "../components/Loading";
import Utils from "../util/utils";

export default {
  components: {
    AlertDialog,
    Loading,
    RegistroDiarioAlert,
  },
  props: {
    esCxC: { type: Boolean, default: false },
    dialog: { type: Boolean, default: false },
    ver: { type: Boolean, default: false },
    titulo: { type: String, default: "" },
  },
  data: () => ({
    tituloRegistro: "",
    accion: 0,
    registroID: 0,
    items: [],
    mensaje: "",
    esCancelar: false,
    esAceptar: false,
    vToolBarColor: "",
    dialogAlert: false,
    overlay: true,
    eliminar: false,
    folio: 0,
    dialogRegistro: false,
    formatter: new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "USD",
    }),
  }),
  watch: {
    dialog(visible) {
      if (visible) {
        this.getInitCxc();
      }
    },
  },

  created() {
    this.CompanyServices = new CompanyServices();
    this.Utils = new Utils();
    this.getInitCxc();
    this.$root.$refs.Saldos = this;
  },
  methods: {
    cancelar() {
      this.$emit("update:dialog", false);
    },
    async getInitCxc() {
      await this.CompanyServices.GetAccountsOpeningBalance(
        this.Utils.GetValue("EmpresaTransID"),
        this.$root.$refs.SaldosIniciales.esCxCInicial
      ).then((response) => {
        if (response.status === 200) this.items = response.data.response;
        this.overlay = false;
      });
    },
    async DeleteRegistry() {
      this.overlay = true;

      await this.CompanyServices.DeleteAccountsOpeningBalance(
        this.registroID
      ).then((response) => {
        if (response.status === 0 || response.status === 500) {
          this.overlay = false;
          this.messageCreateAccountResponse(
            response.message,
            false,
            true,
            "red"
          );
        } else {
          this.$root.$refs.SaldosIniciales.ver = false;
          this.$root.$refs.SaldosIniciales.validarCuadreCuentas();
        }

        this.overlay = false;
        this.eliminar = false;
      });
    },
    onDelete(registroID, folio) {
      this.registroID = registroID;
      this.folio = folio;
      this.eliminar = true;
    },
    mostrarRegistroAlert(accion, titulo, folioID, folio) {
      this.tituloRegistro = titulo;
      this.accion = accion;
      this.registroID = folioID;
      this.folio = folio;
      this.dialogRegistro = true;
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