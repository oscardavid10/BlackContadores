<template>
  <v-app id="inspire">
    <v-main>
      <!-- mostrar pantalla alerta para mensajes -->
      <AlertDialog
        :titulo="titulo"
        :mensaje="mensaje"
        :esCancelar="esCancelar"
        :esAceptar="esAceptar"
        :vToolBarColor="vToolBarColor"
        :dialog.sync="dialog"
      />
      <!-- -->
      <v-container fill-height fluid id="login">
        <v-row justify="center" align="center">
          <v-col cols="12" sm="10" :md="step == 0 ? 7 : 10" xs="1">
            <v-card class="elevation-7">
              <v-window v-model="step">
                <v-window-item :value="0">
                  <v-row>
                    <v-col cols="12" md="12" class="flex-grow-0 flex-shrink-0">
                      <v-card-text style="height: 520px">
                        <v-row class="text-center">
                          <v-col cols="12 d-flex justify-center">
                            <v-img
                              :src="require('../assets/logo-black.png')"
                              class="my-3"
                              max-height="100"
                              max-width="400"
                            />
                          </v-col>
                        </v-row>
                        <br />
                        <v-row
                          justify="center"
                          align="center"
                          class="pt-0"
                          no-gutters
                        >
                          <v-col
                            cols="12"
                            md="8"
                            class="d-flex justify-center pt-0"
                          >
                            <span class="text-h6 font-weight-bold">
                              Recuperar Contraseña
                            </span>
                          </v-col>
                          <v-col cols="12" md="8" class="d-flex justify-center">
                            <span class="text-subtitle-1">
                              Ingresa tu correo electrónico para buscar tu
                              cuenta y enviaremos un correo con instrucciones
                              para reestablecer tu contraseña.
                            </span>
                          </v-col>
                        </v-row>
                        <v-row class="text-center">
                          <v-col cols="12" class="d-flex justify-center">
                            <br />
                            <v-form class="">
                              <v-text-field
                                ref="email"
                                :label="str_txt_email"
                                name="email"
                                prepend-icon="email"
                                type="text"
                                color="light-blue accent-3"
                                :style="$vuetify.breakpoint.xs ? 'width:300px;' : 'width:500px;'"
                                v-model="emailRecovery"
                                :rules="[rules.email]"
                                @input="(_) => (email = _)"
                              />
                            </v-form>
                          </v-col>
                        </v-row>
                        <br />
                        <v-row>
                          <v-col cols="12">
                            <div class="text-center">
                              <v-btn
                                :loading="loading_reset"
                                color="light-blue"
                                dark
                                @click="RecoveryPassword"
                                >Enviar correo de recuperación</v-btn
                              >
                            </div>
                          </v-col>
                        </v-row>
                        <v-row>
                          <v-col cols="12">
                            <div class="text-center">
                              <div class="text-center">
                                <v-btn color="black" dark @click="step++">{{
                                  str_btn_login
                                }}</v-btn>
                              </div>
                            </div>
                          </v-col>
                        </v-row>
                        <br />
                      </v-card-text>
                    </v-col>
                  </v-row>
                </v-window-item>
                <v-window-item :value="1">
                  <v-row>
                    <v-col cols="12" md="8" class="flex-grow-0 flex-shrink-0">
                      <v-card-text style="height: 500px">
                        <v-row class="text-center">
                          <v-col cols="12" class="d-flex justify-center">
                            <v-img
                              :src="require('../assets/logo-black.png')"
                              class="my-3"
                              max-height="100"
                              max-width="400"
                            />
                          </v-col>
                        </v-row>
                        <span class="text-center mt-4"> </span>
                        <br />
                        <v-row class="text-center">
                          <v-col cols="12" sm="12" class="d-flex justify-center">
                            <v-form class="">
                              <v-text-field
                                ref="email"
                                :label="str_txt_email"
                                name="email"
                                prepend-icon="email"
                                type="text"
                                color="light-blue accent-3"
                                :style="$vuetify.breakpoint.xs ? 'width:250px;' : 'width:500px;'"
                                v-model="usuario"
                              />
                              <v-text-field
                                ref="contra"
                                id="Contraseña"
                                :label="str_txt_password"
                                name="password"
                                prepend-icon="lock"
                                type="password"
                                color="light-blue accent-3"
                                v-model="contrasena"
                              />
                            </v-form>
                          </v-col>
                          <v-row>
                            <v-col>
                              <span style="text-align: rigth">
                                <a target="_blank" @click="step = 0">
                                  ¿Olvidaste tu contraseña?
                                </a>
                              </span>
                            </v-col>
                          </v-row>
                        </v-row>
                        <br />
                        <br />
                        <v-row>
                          <v-col cols="12">
                            <div class="text-center">
                              <v-btn
                                :loading="loading"
                                color="light-blue"
                                dark
                                @click="iniciarSesion(usuario, contrasena)"
                                >{{ str_btn_login }}</v-btn
                              >
                              &nbsp;
                              <v-btn color="black" dark @click="step++">{{
                                str_btn_create_account
                              }}</v-btn>
                            </div>
                          </v-col>
                        </v-row>
                        <br />
                      </v-card-text>
                    </v-col>
                    <v-col cols="12" md="4" class="black">
                      <v-card-text class="white--text mt-10">
                        <h2 class="text-center">
                          ¡ Administración rápida, práctica y sencilla !
                        </h2>
                        <br />
                        <br />
                        <span>
                          Black Administrativo, es un sistema contable en línea
                          que te permite registrar en tiempo real tus
                          operaciones diarias para que tengas una correcta
                          información financiera, además podrás crear reportes en
                          segundos para ayudarte en la correcta toma de
                          decisiones.
                          <br />
                          <br />
                          Registra tus ventas, compras, gastos, cuentas por
                          cobrar, por pagar y más, de una manera rápida,
                          práctica y sencilla.
                        </span>
                        <br />
                      </v-card-text>
                    </v-col>
                  </v-row>
                </v-window-item>

                <v-window-item :value="2">
                  <v-row class="fill-height">
                    <v-col cols="12" md="12" class="black">
                      <br />
                      <h1 class="text-center ml-4 white--text">
                        ELIGE TU PLAN
                      </h1>
                      <v-card-text class="white--text">
                        <h2 class="text-left">
                          Selecciona uno de nuestros planes MENSUALES o ANUALES
                          y comienza a registar tus movimientos de una manera
                          rápida, práctica y sencilla.
                        </h2>
                        <br />
                        <v-btn dark color="light-blue" @click="step--"
                          >Ya tengo cuenta</v-btn
                        >
                      </v-card-text>
                    </v-col>
                  </v-row>
                  <v-row no-gutters>
                    <v-col
                      cols="12"
                      md="3"
                      :key="items.MembresiaID"
                      v-for="items in membershipsList"
                    >
                      <v-card-text>
                        <Membresias
                          :NombreMembresia="items.TipoMembresia[0].Descripcion"
                          :PrecioMes="items.PrecioMes"
                          :PrecioAnual="items.PrecioAnual"
                          :MembresiaID="items.MembresiaID"
                          :EsSugerido="items.TipoMembresia[0].EsSugerido"
                          :NoUsuarios="items.NoUsuarios"
                          :Caracteristicas="
                            items.TipoMembresia[0].Caracteristicas
                          "
                          @createAccountPage="createAccountPage"
                        />
                      </v-card-text>
                    </v-col>
                  </v-row>
                </v-window-item>

                <v-window-item :value="3">
                  <CreateAccount
                    @backToPlans="backToPlans"
                    @dashboardPage="dashboardPage"
                    :ItemMembership="ItemMembershipSelected"
                  />
                </v-window-item>
              </v-window>
            </v-card>
          </v-col>
        </v-row>
        <ContentFooter />
      </v-container>
      <br />
    </v-main>
  </v-app>
</template>

<script>
import Membresias from "../components/Membresias";
//import Pago from "../components/Pago";
import AlertDialog from "../components/AlertDialog";
import Constants from "../util/constants";
import MembershipsService from "../network/services/MembershipService";
import CreateAccount from "../components/CreateAccount";
import Enumerable from "linq";
import Vue from "vue";
import ContentFooter from "../components/ContentFooter";
import AccountService from "../network/services/AccountService";
import VueCryptojs from "vue-cryptojs";
//import Crypto from "../util/crypto";
import Utils from "../util/utils";

Vue.use(VueCryptojs);

export default {
  name: "Login",
  components: {
    Membresias,
    //Pago,
    AlertDialog,
    CreateAccount,
    ContentFooter,
  },
  data: () => ({
    vToolBarColor: "green",
    loading_reset: false,
    loading: false,
    step: 1,
    emailRecovery: "",
    usuario: "",
    contrasena: "",
    titulo: "Black Administrativo - [ Inicio de sesión ]",
    dialog: false,
    mensaje: "",
    esAceptar: false,
    esCancelar: false,
    str_btn_login: Constants.str_btn_login,
    str_btn_create_account: Constants.str_btn_create_account,
    str_txt_email: Constants.str_txt_email,
    str_txt_password: Constants.str_txt_password,
    membershipsList: [],
    ItemMembershipSelected: [],
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

  created() {
    this.MembershipsService = new MembershipsService();
    this.AccountService = new AccountService();
    this.Utils = new Utils();
    localStorage.clear();
  },

  async mounted() {
    this.$refs.contra.focus();
    this.$refs.email.focus();
    const rs_mermershiplist = await this.MembershipsService.GetMembershipList();
    //rs_mermershiplist

    if (rs_mermershiplist.status === 200)
      this.membershipsList = JSON.parse(rs_mermershiplist.data[0].Membresias);
    else {
      this.vToolBarColor = "red";
      this.errorMessage(
        rs_mermershiplist.message,
        "Black Administrativo - [ Problemas con el servicio ]",
        false,
        true,
        "red"
      );
    }
  },

  methods: {
    validateEmail() {
      const pattern = /^[^@]+@[^@]+\.[a-zA-Z]{2,}$/;

      return pattern.test(this.emailRecovery);
    },
    async RecoveryPassword() {
      this.loading_reset = true;
      if (this.validateEmail()) {
        var response = await this.AccountService.PostRecoveryPassword({
          correousuario: this.emailRecovery,
        });

        this.messageCreateAccountResponse(
          response.data.response[0].message,
          false,
          true,
          response.data.response[0].success == "true" ? "green" : "red"
        );
        this.loading_reset = false;
        if (response.data.response[0].success == "true") {
          this.emailRecovery = "";
          this.step++;
        }
      } else {
        this.loading_reset = false;
        this.errorMessage(
          "Favor de ingresar un correo valido.",
          "Black Administrativo - [ Recuperar contraseña ]"
        );
      }
    },
    messageCreateAccountResponse(message, esCancelar, esAceptar, color) {
      this.mensaje = message;
      this.esCancelar = esCancelar;
      this.esAceptar = esAceptar;
      this.vToolBarColor = color;
      this.dialog = true;

      this.overlay = false;
    },
    async iniciarSesion(usuario, contrasena) {
      if (usuario == "" || contrasena == "")
        this.errorMessage(
          Constants.str_error_login,
          "Black Administrativo - [ Inicio de sesión ]"
        );
      else {
        this.loading = true;
        const accountData = {
          CorreoUsuario: usuario,
          Contrasena: contrasena,
        };

        var response = await this.AccountService.PostLogin(accountData);
        this.loading = false;
        if (response.data.response.success != "false") {
          console.log(response.data.response);
          this.Utils.SetValue(response.data.token, "authToken");
          this.Utils.SetValue(usuario, "correoUsuario");
          this.Utils.SetValue(
            response.data.response[0].EmpresaTransID,
            "EmpresaTransID"
          );
          this.Utils.SetValue(
            response.data.response[0].CustomerConektaID,
            "CustomerConektaID"
          );
          this.Utils.SetValue(
            response.data.response[0].EmpresaActiva,
            "EmpresaActiva"
          );
          this.Utils.SetValue(
            response.data.response[0].AltaDeUsuarios,
            "AltaDeUsuarios"
          );
          this.Utils.SetValue(
            response.data.response[0].NoUsuarios,
            "NoUsuarios"
          );
          this.Utils.SetValue(
            response.data.response[0].NombreUsuario,
            "legal_name"
          );
          this.Utils.SetValue(
            response.data.response[0].NombreEmpresa,
            "company_name"
          );
          this.Utils.SetValue(response.data.response[0].UsuarioID, "UsuarioID");
          this.Utils.SetValue(response.data.response[0].AnioOperacion, "AnioOperacion");
          this.Utils.SetValue(
            response.data.response[0].MembresiaID,
            "MembresiaID"
          );
          if (this.membershipID == 1) {
            this.mensaje = response.data.response.message;
            this.messageCreateAccountResponse(
              response.data.response[0].message,
              false,
              true,
              "green"
            );
          }

          if (response.data.response[0].EmpresaActiva) {
            this.messageCreateAccountResponse(
              "Inicio de sesión correcto!",
              false,
              false,
              "green"
            );
            setTimeout(() => {
              this.$router.push("/registro-diario");
            }, 2000);
          } else {
            this.messageCreateAccountResponse(
              response.data.response.message,
              false,
              true,
              "red"
            );
            this.loading = false;
            this.$router.push("/perfil");
          }
        } else {
          this.Utils.SetValue("", "authToken");
          this.Utils.SetValue(response.data.token, "authToken");
          this.messageCreateAccountResponse(
            response.data.response.message,
            false,
            true,
            "red"
          );
          this.loading = false;
        }
        this.loading = false;
      }
    },
    createAccountPage(MembresiaID) {
      this.ItemMembershipSelected = Enumerable.from(this.membershipsList)
        .where((m) => m.MembresiaID == MembresiaID)
        .toArray();
      this.step++;
    },
    backToPlans() {
      this.step--;
    },
    dashboardPage() {
      this.$router.push("/registro-diario");
    },
    errorMessage(mensaje, titulo) {
      this.titulo = titulo;
      this.mensaje = mensaje;
      this.esCancelar = false;
      this.esAceptar = true;
      this.dialog = true;
    },
  },

  props: {
    source: String,
  },
};
</script>
<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Roboto:wght@100&display=swap");
</style>