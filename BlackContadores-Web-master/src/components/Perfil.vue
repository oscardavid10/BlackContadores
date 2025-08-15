<template id="ca">
  <v-main class="px-4" style="padding: 0px; padding-top: 60px; height: 100%">
    <AlertDialog
      :titulo="titulo"
      :mensaje="mensaje"
      :esCancelar="esCancelar"
      :esAceptar="esAceptar"
      :vToolBarColor="vToolBarColor"
      :dialog.sync="dialog"
    />

    <Pago
      @create="payment"
      :dialog.sync="dialogPago"
      :tokenParams.sync="tokenParams"
      :membershipSelectedMonth.sync="membershipSelectedMonth"
      :membresia="nombre_Nueva_Membresia"
      :membresiaID="nueva_MembresiaID"
      :precio="precio_nueva_membresia"
      :precio_anual="precio_anual_nueva_membresia"
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

    <base-material-card color="blue pa-0" style="height: 99%">
      <template v-slot:heading>
        <p class="text-left text-h5">
          PERFIL DE USUARIO |
          <span class="text-subtitle-1 pr-5" id="textDescription"
            >Datos de perfil
          </span>
          <v-tooltip bottom>
            <template v-slot:activator="{ on, attrs }">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <v-btn
                v-bind="attrs"
                v-on="on"
                fab
                small
                :disabled="!activa"
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
            @click="updateProfile"
          >
            Guardar
          </v-btn>
        </p>
      </template>
      <v-card-text style="padding: 0px">
        <v-container class="pb-0 px-0 mx-0" style="max-width: 100% !important">
          <v-row no-gutters>
            <v-col cols="12" sm="9" class="pr-sm-3">
              <v-container class="pa-0">
                <v-row no-gutters class="pa-0">
                  <v-col cols="12" sm="12" class="pr-sm-3 pb-4">
                    <v-card
                      elevation="8"
                      class="d-flex flex-column rounded-lg black white--text"
                    >
                      <v-card-title class="pt-3 pl-7 title">
                        Datos de la Empresa
                      </v-card-title>
                      <hr />
                      <v-card-text class="text-center white">
                        <v-container>
                          <v-row>
                            <v-col cols="12" sm="8">
                              <v-text-field
                                :disabled="!editar"
                                :label="str_txt_company_name"
                                required
                                prepend-icon="house"
                                type="text"
                                :value="Empresa"
                                @input="(_) => (Empresa = _)"
                              ></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="4">
                              <v-autocomplete
                                :value="anio"
                                v-model="anio"
                                ref="anio"
                                label="Año de inicio de operaciones (*)"
                                required
                                :items="anios"
                                @input="setSelected"
                                :readonly="CapitalFinal > 0 || !editar"
                              ></v-autocomplete>
                            </v-col>
                            <v-col cols="12" sm="4">
                              <v-autocomplete
                                :disabled="!editar"
                                :value="GiroID"
                                prepend-icon="mdi-map"
                                label="Giro de la empresa"
                                :items="itemsGiros"
                                item-text="NombreGiro"
                                item-value="GiroID"
                                item-key="itemsGiros"
                                return-object
                                @change="giroSeleccionado"
                              ></v-autocomplete>
                            </v-col>
                            <v-col cols="12" sm="4">
                              <v-autocomplete
                                :disabled="!editar"
                                :value="SubGiroID"
                                prepend-icon="mdi-map"
                                label="Subgiro de la empresa"
                                :items="itemsSubGiros"
                                item-text="NombreSubGiro"
                                item-value="SubGiroID"
                                item-key="itemsSubGiros"
                                return-object
                                @change="subGiroSeleccionado"
                              ></v-autocomplete>
                            </v-col>
                            <v-col cols="12" sm="4">
                              <v-autocomplete
                                :disabled="!editar"
                                :value="ActividadID"
                                prepend-icon="mdi-map"
                                label="Actividad de la empresa"
                                :items="itemsActividades"
                                item-text="NombreActividad"
                                item-value="ActividadID"
                                item-key="itemsActividades"
                                return-object
                                @change="actividadSeleccionado"
                              ></v-autocomplete>
                            </v-col>
                            <v-col cols="12" sm="12" v-if="otraActividad">
                              <v-text-field
                                :disabled="!editar"
                                v-model="actividad"
                                id="actividad"
                                label="Descripcion de la actividad"
                                name="actividad"
                                prepend-icon="mdi-map"
                                color="light-blue accent-3"
                                @click:append="() => (value = !value)"
                              />
                            </v-col>
                          </v-row>
                        </v-container>
                      </v-card-text>
                    </v-card>
                  </v-col>
                  <v-col cols="12" sm="12" class="pr-sm-3 pb-4">
                    <v-card
                      elevation="8"
                      class="d-flex flex-column rounded-lg black"
                    >
                      <v-card-title class="white--text pt-3 pl-sm-7 title">
                        Membresia
                      </v-card-title>
                      <hr />
                      <v-card-text class="text-center white pa-0">
                        <v-container>
                          <v-row no-gutters>
                            <v-col
                              cols="12"
                              :md="items.MembresiaID !== 1 ? 4 : 0"
                              :key="items.MembresiaID"
                              v-for="items in membershipsList"
                            >
                              <v-card-text
                                class="pa-1"
                                v-if="items.MembresiaID !== 1"
                              >
                                <Membresias
                                  :Actual="
                                    MembresiaID == items.MembresiaID
                                      ? true
                                      : false
                                  "
                                  :NombreMembresia="
                                    items.TipoMembresia[0].Descripcion
                                  "
                                  :PrecioMes="items.PrecioMes"
                                  :PrecioAnual="items.PrecioAnual"
                                  :MembresiaID="items.MembresiaID"
                                  :EsSugerido="false"
                                  :NoUsuarios="items.NoUsuarios"
                                  :Caracteristicas="
                                    items.TipoMembresia[0].Caracteristicas
                                  "
                                  @createAccountPage="createAccountPage"
                                />
                              </v-card-text>
                            </v-col>
                          </v-row>
                        </v-container>
                      </v-card-text>
                    </v-card>
                  </v-col>
                </v-row>
                <v-row> </v-row>
              </v-container>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card
                style="height: 100%"
                elevation="8"
                class="d-flex flex-column rounded-lg black"
              >
                <v-card-title class="white--text pt-3 pl-3 title">
                  Datos de Cuenta
                </v-card-title>
                <hr />
                <v-card-text class="text-center white" style="height: 100%">
                  <v-avatar color="indigo" size="100">
                    <v-icon x-large dark> mdi-48px mdi-account-circle </v-icon>
                  </v-avatar>
                  <br /><br /><br />
                  <v-text-field
                    :label="str_txt_legal_name"
                    :disabled="!editar"
                    required
                    prepend-icon="person"
                    type="text"
                    :value="Nombre"
                    @input="(_) => (Nombre = _)"
                  ></v-text-field>
                  <v-text-field
                    :disabled="!editar"
                    v-model="telefono"
                    label="Numero de telefono (*)"
                    name="telefono"
                    id="telefono"
                    prepend-icon="phone"
                    type="number"
                    color="light-blue accent-3"
                    @keypress="validarNumero"
                    :rules="[rules.telefono]"
                  />
                  <v-text-field
                    :disabled="true"
                    label="Usuario"
                    prepend-icon="email"
                    required
                    id="email"
                    name="email"
                    :value="email"
                    color="light-blue accent-3"
                    @click:append="() => (value = !value)"
                    :type="value ? 'email' : 'text'"
                    :rules="[rules.email]"
                    @input="(_) => (email = _)"
                  ></v-text-field>
                  <v-text-field
                    :disabled="!editar"
                    label="Contraseña"
                    required
                    prepend-icon="lock"
                    autocomplete="current-password"
                    :value="password"
                    :type="value ? 'password' : 'text'"
                    :rules="[rules.password]"
                    @input="(_) => (password = _)"
                  ></v-text-field>
                  <v-divider />
                  <br />
                  <h3>Tu Membresia</h3>
                  <v-text-field
                    :disabled="true"
                    label="Plan Contratado"
                    prepend-icon="mdi-card-account-details"
                    :value="plan"
                  ></v-text-field>
                  <v-text-field
                    :disabled="true"
                    label="Precio"
                    prepend-icon="mdi-currency-usd"
                    :value="precio"
                  ></v-text-field>
                  <v-text-field
                    :disabled="true"
                    label="Fecha Activación"
                    prepend-icon="mdi-calendar-account"
                    :value="fechaActivacion"
                  ></v-text-field>
                  <v-text-field
                    :disabled="true"
                    label="Fecha Vencimiento"
                    prepend-icon="mdi-calendar-lock"
                    :value="fechaVencimiento"
                  ></v-text-field>
                  <h2 class="red--text" v-if="vencida">
                    Tu Membresia se encuentra vencida, favor de realizar su pago
                  </h2>
                </v-card-text>
              </v-card>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </base-material-card>
  </v-main>
</template>

<script>
import AlertDialog from "../components/AlertDialog";
import AccountService from "../network/services/AccountService";
import Utils from "../util/utils";
import Enumerable from "linq";
import Constants from "../util/constants";
import Loading from "../components/Loading";
import Membresias from "../components/Membresias";
import Pago from "../components/Pago";
import PaymentService from "../network/services/PaymentService";

export default {
  components: {
    Loading,
    AlertDialog,
    Membresias,
    Pago,
  },
  data: () => ({
    otraActividad: false,
    actividad: "",
    anios: [],
    anio: "",
    telefono: "",
    tokenParams: [],
    dialogPago: false,
    activa: true,
    plan: "",
    precio: "",
    fechaActivacion: "",
    fechaVencimiento: "",
    //fechaProximoPago: "",
    loading: false,
    Actividades: [],
    itemsActividades: [],
    ActividadID: 0,
    itemsSubGiros: [],
    SubGiros: [],
    SubGiroID: 0,
    GiroID: 0,
    itemsGiros: [],
    editar: false,
    MembresiaID: 0,
    membershipsList: [],
    ItemMembershipSelected: [],
    password: "",
    password_old: "",
    email: "",
    Nombre: "",
    CapitalFinal: 0,
    Empresa: "",
    items: [],
    dialog: false,
    dialogAlert: false,
    esCancelar: false,
    esAceptar: false,
    mensaje: "",
    titulo: "",
    membershipSelectedMonth: false,
    overlay: false,
    vToolBarColor: "",
    str_txt_legal_name: Constants.str_txt_legal_name,
    str_txt_company_name: Constants.str_txt_company_name,
    str_no_data: Constants.str_no_data,
    str_txt_password: Constants.str_txt_password,
    value: true,
    precio_nueva_membresia: 0,
    precio_anual_nueva_membresia: 0,
    nueva_MembresiaID: 0,
    nombre_Nueva_Membresia: "",
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
      telefono: (value) => {
        const pattern = /^[0-9]{10}$/;

        return (
          pattern.test(value) ||
          "Telefono no válido. El telefono debe ser a 10 digitos."
        );
      },
    },
  }),

  created() {
    for (let x = 2000; x <= new Date().getFullYear(); x++) this.anios.push(x);
    this.AccountService = new AccountService();
    this.Utils = new Utils();
    this.activa = /true/i.test(new Utils().GetValue("EmpresaActiva"));
    this.PaymentService = new PaymentService();
    this.getProfile();
  },

  mounted() {
    const script = document.createElement("script");
    script.src = "https://cdn.conekta.io/js/latest/conekta.js";
    script.async = true;
    document.body.appendChild(script);
  },

  methods: {
    setSelected(value) {
      this.anio = value;
    },
    payment() {
      window.Conekta.setPublicKey("key_cMSsgqZ1uJXGmrCfdVAzxyg");
      window.Conekta.Token.create(
        this.tokenParams,
        async (token) => {
          const data = {
            MembresiaID: this.ItemMembershipSelected[0].MembresiaID,
            Membresia: this.ItemMembershipSelected[0].Descripcion,
            Precio: this.membershipSelectedMonth
              ? this.ItemMembershipSelected[0].PrecioMes
              : this.ItemMembershipSelected[0].PrecioAnual,
            Frecuencia: this.membershipSelectedMonth ? "Me" : "An",
            Email: new Utils().GetValue("correoUsuario"),
            Usuario: new Utils().GetValue("legal_name"),
            Token: token.id,
            EmpresaTransID: new Utils().GetValue("EmpresaTransID"),
          };

          var response = await this.PaymentService.PostPayment(data);

          if (response.data.success != "false") {
            this.messageCreateAccountResponse(
              response.data.message,
              false,
              true,
              "green"
            );
            setTimeout(() => {
              localStorage.clear();
              this.$router.push("/");
            }, 3000);
          } else {
            this.messageCreateAccountResponse(
              response.data.message,
              false,
              true,
              "red"
            );
          }
        },
        (error) => {
          this.messageCreateAccountResponse(error.message_to_purchaser, "red");
          console.log(error);
        }
      );
    },
    validarNumero(e) {
      if (e.keyCode < 48 || e.keyCode > 57) {
        if (e.keyCode != 46) e.preventDefault();
      }
    },
    async updateProfile() {
      this.loading = true;

      let empresaTransID = new Utils().GetValue("EmpresaTransID");

      const accountData = {
        RepresentanteLegal: this.Nombre,
        NombreEmpresa: this.Empresa,
        CorreoUsuario: this.email,
        Contrasena: this.password,
        GiroID: this.GiroID,
        SubGiroID: this.SubGiroID,
        ActividadID: this.ActividadID,
        companyTransID: empresaTransID,
        Telefono: this.telefono,
        EsCambiarContrasena: this.password != this.password_old,
        OtraActividad: this.otraActividad ? this.actividad : "",
        AnioOperacion: this.anio
      };

      var response = await this.AccountService.PostUpdateProfile(accountData);

      if (response.data.token != "") {
        this.loading = false;
        this.messageCreateAccountResponse(
          response.data.response[0].message,
          true,
          true,
          "green"
        );
        this.$root.$refs.Dashboard.percentagecompletion();
        this.editar = false;
      } else {
        this.loading = false;
        this.Utils.SetValue("", "authToken");
        this.messageCreateAccountResponse(
          response.data.response.message,
          false,
          true,
          "red"
        );
      }

      this.loading = false;
    },
    showFeature(showFor, planId) {
      return showFor.includes(planId);
    },
    async getProfile() {
      this.overlay = true;

      let params = {
        EmpresaTransID: this.Utils.GetValue("EmpresaTransID"),
        UsuarioID: this.Utils.GetValue("UsuarioID"),
      };

      var response = await this.AccountService.GetProfile(params);

      if (response.data.success !== false) {
        this.membershipsList = JSON.parse(
          response.data.response.membresias[0].Membresias
        );
        this.anio = parseInt(response.data.response.perfil[0].AnioOperacion);
        this.CapitalFinal = response.data.response.perfil[0].CapitalFinal;
        this.itemsGiros = response.data.response.giros;
        this.SubGiros = response.data.response.subgiros;
        this.Actividades = response.data.response.actividades;
        this.email = response.data.response.perfil[0].CorreoUsuario;
        this.telefono = response.data.response.perfil[0].Telefono;
        this.password = response.data.response.perfil[0].Contrasena;
        this.password_old = response.data.response.perfil[0].Contrasena;
        this.GiroID = response.data.response.perfil[0].GiroID;
        this.giroSeleccionado({ GiroID: this.GiroID });
        this.SubGiroID = response.data.response.perfil[0].SubGiroID;
        this.subGiroSeleccionado({ SubGiroID: this.SubGiroID });
        this.ActividadID = response.data.response.perfil[0].ActividadID;
        this.Nombre = response.data.response.perfil[0].RepresentanteLegal;
        this.Empresa = response.data.response.perfil[0].NombreEmpresa;
        this.MembresiaID = response.data.response.perfil[0].MembresiaID;
        this.plan = response.data.response.perfil[0].PeriodoVigente;
        this.precio = response.data.response.perfil[0].PrecioVigente;
        this.actividad = response.data.response.perfil[0].OtraActividad;
        this.otraActividad = response.data.response.perfil[0].OtraActividad;
        this.fechaActivacion = response.data.response.perfil[0].FechaActivacion;
        this.fechaVencimiento = response.data.response.perfil[0].FechaVencimiento; 
        // puede venir "02/09/2025" o "2025-04-28 13:34:38.173"

        // 1) extraer sólo la parte de fecha
        let datePart;
        if (this.fechaVencimiento.includes('/')) {
          // formato DD/MM/YYYY
          datePart = this.fechaVencimiento;
        } else {
          // formato SQL "YYYY-MM-DD hh:mm:ss"
          datePart = this.fechaVencimiento.split(' ')[0]; // "2025-04-28"
          // lo convertimos a "28/04/2025" para reutilizar
          const [yyyy, mm, dd] = datePart.split('-');
          datePart = `${dd}/${mm}/${yyyy}`;
        }

        // 2) parsear siempre DD/MM/YYYY en Date
        const [dd2, mm2, yyyy2] = datePart.split('/');
        const venc = new Date(Number(yyyy2), Number(mm2) - 1, Number(dd2));

        // 3) marcar vencida si la fecha ya pasó
        this.vencida = Date.now() > venc.getTime();

        // if (Date.now() > new Date(this.fechaVencimiento)) this.vencida = true;
        //this.fechaProximoPago =
        //response.data.response.perfil[0].FechaProximoPago;
      } else {
        this.messageCreateAccountResponse(
          response.data.message,
          false,
          true,
          "red"
        );
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
    createAccountPage(MembresiaID) {
     
      this.ItemMembershipSelected = Enumerable.from(this.membershipsList)
        .where((m) => m.MembresiaID == MembresiaID)
        .toArray();

      this.precio_nueva_membresia = this.ItemMembershipSelected[0].PrecioMes;
      this.precio_anual_nueva_membresia =
        this.ItemMembershipSelected[0].PrecioAnual;
      this.nueva_MembresiaID = this.ItemMembershipSelected[0].MembresiaID;
      this.nombre_Nueva_Membresia =
        this.ItemMembershipSelected[0].TipoMembresia[0].Descripcion;
      this.dialogPago = true;

    },
    giroSeleccionado(value) {
      this.otraActividad = false;
      this.GiroID = value.GiroID;
      this.itemsSubGiros = this.SubGiros.filter(
        (Giro) => Giro.GiroID == value.GiroID
      );
    },
    subGiroSeleccionado(value) {
      this.otraActividad = false;
      this.SubGiroID = value.SubGiroID;
      this.itemsActividades = this.Actividades.filter(
        (Actividad) => Actividad.SubGiroID == value.SubGiroID
      );
    },
    actividadSeleccionado(value) {
      this.otraActividad = value.NombreActividad == "Otro";
      this.ActividadID = value.ActividadID;
    },
  },
};
</script>

<style>
.custom-loader {
  animation: loader 1s infinite;
  display: flex;
}
@-moz-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@-webkit-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@-o-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
</style>