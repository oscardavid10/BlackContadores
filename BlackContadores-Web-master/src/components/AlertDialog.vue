<template>
  <v-dialog persistent v-model="dialog" width="500">
    <v-card>
      <v-toolbar :color="vToolBarColor" dark>{{ titulo }}</v-toolbar>

      <h4 class="ma-5" style="white-space: pre-line">
        {{ mensaje }}
      </h4>

      <v-divider></v-divider>

      <v-footer>
        <v-row justify="end" no-gutters>
          <v-btn
            v-if="esAceptar"
            class="mr-1"
            color="light-blue"
            id="btnAceptar"
            dark
            @click.native="aceptar"
            >Aceptar</v-btn
          >

          <v-btn
            v-if="esCancelar"
            color="red"
            id="btnCancelar"
            dark
            @click.native="cancelar"
            >Cancelar</v-btn
          >
        </v-row>
      </v-footer>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    titulo: { type: String, required: true },
    dialog: { type: Boolean, default: false },
    mensaje: { type: String },
    esAceptar: { type: Boolean, default: false },
    esCancelar: { type: Boolean, default: false },
    vToolBarColor: { type: String },
  },
  data: () => ({}),
  methods: {
    aceptar() {
      this.$emit("update:dialog", false);
    },
    cancelar() {
      this.$emit("update:dialog", false);
    },
  },
};
</script>

<style>
#btnGuardar {
  background-color: darkgreen;
  color: white;
}
</style>