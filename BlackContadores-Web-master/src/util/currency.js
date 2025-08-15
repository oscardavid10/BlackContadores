// currency.js
const nf = new Intl.NumberFormat("en-US");

const sanitize = (v) => {
  // Solo dígitos y un punto decimal
  v = (v || "").replace(/,/g, "").replace(/[^\d.]/g, "");
  const parts = v.split(".");
  if (parts.length > 2) {
    // Más de un punto: nos quedamos con el primero
    v = parts[0] + "." + parts.slice(1).join("");
  }
  // Quitar ceros a la izquierda salvo "0" o "0.xxx"
  v = v.replace(/^0+(?=\d)/, "");
  // Si empieza con ".", anteponer 0
  if (v.startsWith(".")) v = "0" + v;
  return v;
};

const format = (value, fractionDigits) => {
  const n = Number(value);
  if (!isFinite(n)) return "";
  const opts =
    fractionDigits != null
      ? { minimumFractionDigits: fractionDigits, maximumFractionDigits: fractionDigits }
      : {};
  return n.toLocaleString("en-US", opts);
};

function setNativeValue(el, value) {
  // Asigna y dispara "input" nativo para que v-model recoja el cambio (solo en inputs nativos)
  el.value = value;
  el.dispatchEvent(new Event("input", { bubbles: true }));
}

export default {
  bind(el, binding, vnode) {
    const input = el.tagName.toLowerCase() === "input" ? el : el.querySelector("input");
    if (!input) return;

    const fractionDigits = binding.modifiers?.int ? 0 : 2;

    const onInput = () => {
      const prev = input.value;
      const start = input.selectionStart ?? prev.length;

      // Saneamos y formateamos sin emitir
      const raw = sanitize(prev);
      const [intPart = "", decPart = ""] = raw.split(".");
      const intFormatted = intPart ? nf.format(Number(intPart)) : "";
      const newDisplay = decPart !== "" ? `${intFormatted}.${decPart}` : intFormatted;

      // Reposicionar cursor (desde el final, evita saltos al insertar comas)
      const posFromEnd = prev.length - start;
      input.value = newDisplay;
      const newPos = Math.max(0, input.value.length - posFromEnd);
      input.setSelectionRange(newPos, newPos);
    };

    const onBlur = () => {
      const raw = sanitize(input.value);
      if (raw === "") return;

      // Valor numérico consolidado para el modelo
      const numeric = Number(raw);
      const display = format(numeric, fractionDigits);

      // 1) Actualiza el modelo (para v-model en inputs nativos)
      setNativeValue(input, numeric);

      // 2) Deja el input formateado visualmente
      //    Usa nextTick si estás dentro de un componente con re-render inmediato
      Promise.resolve().then(() => {
        input.value = display;
      });
    };

    const onFocus = () => {
      // Opcional: mostrar sin comas al editar fino (descomenta si lo prefieres)
      // input.value = sanitize(input.value);
    };

    input.addEventListener("input", onInput);
    input.addEventListener("blur", onBlur);
    input.addEventListener("focus", onFocus);

    // Guarda para unbind
    el._currency = { onInput, onBlur, onFocus };
  },

  // Si el valor cambia desde afuera, re-formatea el display.
  componentUpdated(el, binding) {
    const input = el.tagName.toLowerCase() === "input" ? el : el.querySelector("input");
    if (!input) return;
    const fractionDigits = binding.modifiers?.int ? 0 : 2;

    const raw = sanitize(input.value);
    if (raw === "") return;

    const n = Number(raw);
    if (!isFinite(n)) return;

    const display = format(n, fractionDigits);
    if (input.value !== display) {
      input.value = display;
    }
  },

  unbind(el) {
    const input = el.tagName.toLowerCase() === "input" ? el : el.querySelector("input");
    if (!input || !el._currency) return;
    const { onInput, onBlur, onFocus } = el._currency;
    input.removeEventListener("input", onInput);
    input.removeEventListener("blur", onBlur);
    input.removeEventListener("focus", onFocus);
    delete el._currency;
  },
};

export { format };
