import Vue from "vue";
import moment from "moment";
import { format } from "./currency";

Vue.filter("formatoMoneda", (value) => {
  const formatted = format(value, 2);
  return formatted ? `$${formatted}` : "$0.00";
});

Vue.filter("formatoFecha", function (value) {
  if (value) {
    return moment(String(value)).format("DD/MM/YYYY");
  }
});

Vue.filter("formatoPorcentaje", (value) => {
  if (value)
    return value.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,") + "%";
  else return "0.00%";
});
