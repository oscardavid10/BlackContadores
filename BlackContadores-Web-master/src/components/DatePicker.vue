<template>
  <v-menu
    ref="menu1"
    v-model="menu1"
    :close-on-content-click="false"
    transition="scale-transition"
    offset-y
    max-width="290px"
    min-width="auto"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-text-field
        readonly
        outlined
        v-model="dateFormatted"
        label="Fecha movimiento"
        v-bind="attrs"
        @blur="date = parseDate(dateFormatted)"
        v-on="on"
      ></v-text-field>
    </template>

    <v-date-picker v-model="date" no-title @input="menu1 = false">
    </v-date-picker>
  </v-menu>
</template>

<script>
export default {
  data: (vm) => ({
    date: new Date(
      new Date().getTime() - new Date().getTimezoneOffset() * 60000
    )
      .toISOString()
      .substr(0, 10),
    dateFormatted: vm.formatDate(
      new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10)
    ),
    menu1: false,
    menu2: false,
  }),

  computed: {
    computedDateFormatted() {
      return this.formatDate(this.date);
    },
  },

  watch: {
    date() {
      this.dateFormatted = this.formatDate(this.date);
      this.$emit("fechaSeleccionada", this.dateFormatted);
    },
  },

  methods: {
    formatDate(date) {
      if (!date) return null;

      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },
    parseDate(date) {
      if (!date) return null;

      const [month, day, year] = date.split("/");
      return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
    },
  },
};
</script>