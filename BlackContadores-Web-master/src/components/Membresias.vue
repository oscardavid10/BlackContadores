<template>
  <div id="app">
    <!--<v-app id="inspire">-->
    <v-container>
      <v-layout>
        <v-flex xs12>
          <v-layout row wrap justify-center>
            <v-card
              elevation="5"
              flat
              class="flex ip-plan rounded-xl pa-0 ma-0"
            >
              <v-card-text
                :class="
                  EsSugerido
                    ? 'green darken-3 text-center ma-0'
                    : Actual
                    ? 'green darken-3 text-center ma-0 white--text'
                    : 'light-blue darken-3 text-center ma-0'
                "
              >
                <v-flex class="headline white--text text-h5">
                  {{ NombreMembresia }}
                  <br />
                  <span v-if="EsSugerido" class="text-subtitle-2">
                    Recomendado
                  </span>
                </v-flex>

                <v-flex
                  pa-0
                  :class="
                    EsSugerido
                      ? 'ip-plan-precio white--text font-weight-black text-h4'
                      : 'ip-plan-precio white--text text-h4'
                  "
                  >{{ PrecioMes | formatoMoneda }}
                  <span pa-0 class="white--text text-body-2 text-right">
                    mxn/mes</span
                  >
                </v-flex>
                <v-flex
                  v-if="PrecioMes > 0"
                  pa-0
                  class="ip-plan-precio white--text text-body-2"
                  >{{ PrecioAnual | formatoMoneda }}
                  <span pa-0 class="white--text text-body-2 text-right">
                    mxn/anual</span
                  >
                </v-flex>
                <v-flex
                  v-else
                  pa-0
                  class="ip-plan-precio white--text text-body-2"
                >
                  Vigencia 30 días
                  <span pa-0 class="white--text text-body-2 text-right"> </span>
                </v-flex>
              </v-card-text>

              <!-- <v-list-item>
                <v-list-item-content>
                  <v-list-item-title v-if="NoUsuarios == 1" class="body-2"
                    ><v-icon>mdi-check-circle</v-icon> Acceso con
                    {{ NoUsuarios }} usuario</v-list-item-title
                  >
                  <v-list-item-title v-else class="body-2"
                    ><v-icon>mdi-check-circle</v-icon> Acceso con
                    {{ NoUsuarios }} usuarios</v-list-item-title
                  >
                </v-list-item-content>
              </v-list-item> -->
              <template v-for="feature in this.Caracteristicas">
                <v-list :key="feature.Caracteristica" class="text-left pa-0">
                  <v-list-item>
                    <v-icon color="green" class="pr-2">{{ feature.icon || "done" }} </v-icon>
                    {{ feature.Caracteristica }}
                  </v-list-item>
                </v-list>
              </template>
              <v-flex ma-2
                ><v-btn
                  block
                  outlined
                  depressed
                  rounded
                  large
                  :class="
                    EsSugerido
                      ? 'green darken-3 text-center ma-0 white--text'
                      : Actual
                      ? 'green darken-3 text-center ma-0 white--text'
                      : 'light-blue darken-3 text-center ma-0 white--text'
                  "
                  @click="selectedPlan(MembresiaID)"
                >
                  {{ Actual ? "Tu Membresia" : "Seleccionar" }}</v-btn
                ></v-flex
              >
            </v-card>
          </v-layout>
        </v-flex>
      </v-layout>
    </v-container>
    <!--</v-app>-->
  </div>
</template>
<script>
export default {
  props: {
    NombreMembresia: { type: String, required: true },
    PrecioMes: { type: Number, required: true },
    PrecioAnual: { type: Number, required: true },
    MembresiaID: { type: Number, require: true },
    EsSugerido: { type: Boolean, require: true },
    NoUsuarios: { type: Number, require: true },
    Caracteristicas: { type: Array, require: true },
    Actual: { type: Boolean, require: false },
  },

  data: () => ({}),

  computed: {
    breakToRow() {
      return this.$vuetify.breakpoint.mdAndUp;
    },
  },
  methods: {
    selectedPlan(MembresiaID) {
      this.$emit("createAccountPage", MembresiaID);
    },
  },
};
</script>
<style>
.ip-plan {
  border: solid 1px #e0e0e0;
  margin-top: 40px;
}

.ip-plan-row .ip-plan {
  max-width: 400px !important;
}
.ip-plan-row .ip-plan:nth-child(2) {
  border-right: 0;
  border-left: 0;
}

.ip-plan-precio {
  display: block;
  font-size: 38px;
  font-weight: 400;
  line-height: 1;
  margin-bottom: 5px;
  margin-top: 20px;
}
.cursor-help {
  cursor: help;
}
.ip-highligh-plan {
  height: 40px;
  position: absolute;
  width: calc(100% + 3px);
  left: -1px;
  top: -40px;
}
</style>