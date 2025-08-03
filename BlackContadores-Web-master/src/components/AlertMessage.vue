<template>
  <div>
    <v-snackbar
      height="200"
      v-model="showMessage"
      :timeout="timeout"
      :message="message"
      centered
      color="success"
    >
      {{ message }}
    </v-snackbar>
  </div>
</template>

<script>
export default {
  props: {
    showMessage: { type: Boolean, required: true },
    message: { type: String, require: true },
  },
  data: () => ({
    timeout: 2500,
  }),
};
</script>