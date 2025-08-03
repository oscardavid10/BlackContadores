<template>
  <v-app>
      <router-view />
  </v-app>
</template>
<script>
import Constants from "./util/constants"

export default {
  components: {
    
  },

  
  data: () => ({}),

  created() {
    document.title = Constants.str_title_name_app + " - " + Constants.str_slogan
  },
};
</script>
