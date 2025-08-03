<template>
  <div class="text-center">
    <v-overlay :value="overlay">
      <v-progress-circular indeterminate size="64" width="10"></v-progress-circular>
      <h3>{{str_loading_default}}</h3>
    </v-overlay>
  </div>
</template>

<script>
import Constants from "../util/constants"

export default {
  props: {
    overlay: { type: Boolean, required: true },
  },
  data: () => ({
      str_loading_default: Constants.str_loading_default,
  }),
};
</script>
        