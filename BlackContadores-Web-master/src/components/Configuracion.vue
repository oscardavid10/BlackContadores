<template id="ca">
  <v-main class="px-4" style="padding: 0px; padding-top: 60px; height: 100%">
    <base-material-card color="blue pa-0" style="height: 97%">
      <template v-slot:heading>
        <p class="text-left text-h5">
          CONFIGURACIONES |
          <span class="text-subtitle-1" id="textDescription">Ajustes del sistema</span>
        </p>
      </template>
      <v-card-text class="px-0 pt-0">
        <v-container
          class="pt-0 px-0 mx-0 pb-7"
          style="max-width: 100% !important"
        >
          <v-row no-gutters class="px-0">
            <v-col cols="12" xl="4" lg="6" md="6" sm="12"  class="px-4 pt-10">
              <router-link
                to="/saldos-iniciales"
                style="text-decoration: none; color: inherit"
                disabled
              >
              <base-material-stats-card
                style="cursor: pointer"
                color="orange darken-4"
                icon="mdi-48px mdi-cash-refund"
                title="Catálogo"
                value="Saldos iniciales"
                sub-icon="mdi-cog"
                sub-text="Ajuste de saldos iniciales."
              />
              </router-link>
            </v-col>
            <v-col cols="12" xl="4" lg="6" md="6" sm="12"  class="px-4 pt-10">
              <router-link
                to="/cuentas"
                style="text-decoration: none; color: inherit"
                disabled
              >
                <base-material-stats-card
                  style="cursor: pointer"
                  title="Catálogo"
                  color="indigo"
                  icon="mdi-48px mdi-account-cash"
                  value="Cuentas"
                  sub-icon="mdi-cog"
                  sub-text="Ajuste de cuentas para futuros movimientos."
                />
              </router-link>
            </v-col>
            <v-col cols="12" xl="4" lg="6" md="6" sm="12"  class="px-4 pt-10">
              <router-link
                to="/subclasificaciones"
                style="text-decoration: none; color: inherit"
                disabled
              >
                <base-material-stats-card
                  style="cursor: pointer"
                  title="Catálogo"
                  color="deep-purple"
                  icon="mdi-48px mdi-file-tree"
                  value="Clasificaciónes"
                  sub-icon="mdi-cog"
                  sub-text="Ajuste de clasificaciones para futuros movimientos."
                />
              </router-link>
            </v-col>
            <v-col cols="12" xl="4" lg="6" md="6" sm="12"  class="px-4 pt-10">
              <router-link
                :to="membresiaID == 1 ? '' : '/usuarios'"
                style="text-decoration: none; color: inherit"
                disabled
              >
                <base-material-stats-card
                  style="cursor: pointer"
                  title="Catálogo"
                  color="green"
                  icon="mdi-48px mdi-account-group"
                  value="Usuarios"
                  :sub-icon="membresiaID == 1 ? '' : 'mdi-cog'"
                  :disabled="membresiaID == 1"
                  :sub-text="
                    membresiaID == 1
                      ? 'Adquiere una membresia para mas de 1 usuario.'
                      : 'Gestiona los usuarios que acceden a tu empresa.'
                  "
                  :subTextColor="membresiaID == 1 ? 'red' : 'gray'"
                />
              </router-link>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </base-material-card>
  </v-main>
</template>
<script>
import Utils from "../util/utils";

export default {
  components: {},
  data: () => ({
    membresiaID: 0,
  }),

  created() {
    this.membresiaID = new Utils().GetValue("MembresiaID");
    this.$root.$refs.Dashboard.percentagecompletion();
    //this.membresiaID = 2;
  },
  methods: {},
};
</script>

