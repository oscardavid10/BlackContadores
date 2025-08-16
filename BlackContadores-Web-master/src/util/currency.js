const format = (value, fractionDigits) => {
  const number = Number(value);
  if (isNaN(number)) return "";
  const options =
    fractionDigits !== undefined
      ? {
          minimumFractionDigits: fractionDigits,
          maximumFractionDigits: fractionDigits,
        }
      : {};
  return number.toLocaleString("en-US", options);
};

const formatRaw = raw => {
  if (raw.startsWith('.')) raw = `0${raw}`
  const endsWithDot = raw.endsWith('.')
  if (endsWithDot) raw = raw.slice(0, -1)
  const [intPart = '', decPart] = raw.split('.')
  const formattedInt = intPart.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
  let result = decPart !== undefined ? `${formattedInt}.${decPart}` : formattedInt
  if (endsWithDot) result += '.'
  return result
}

export default {
  bind(el, binding, vnode) {
    const input =
      el.tagName.toLowerCase() === "input" ? el : el.querySelector("input");
    if (!input) return;

    const onInput = () => {
      const start = input.selectionStart;
      const oldLength = input.value.length;
      let raw = input.value.replace(/,/g, "");
      
      const newValue = formatRaw(raw)
      input.value = newValue

      vnode.componentInstance.$emit("input", raw);
      const newLength = input.value.length;
      const diff = newLength - oldLength;
      const newPos = start + diff;
      input.setSelectionRange(newPos, newPos);
    };

    const onBlur = () => {
      const raw = input.value.replace(/,/g, "");
      if (raw === "") return;
      const val = Number(Number(raw).toFixed(2));
      const formatted = format(val, 2);      
      vnode.context.$nextTick(() => {
        input.value = formatted;
      });
    };

    input.addEventListener("input", onInput);
    input.addEventListener("blur", onBlur);

    el._currency = { onInput, onBlur };
  },
  componentUpdated (el, binding) {
    const input = el.tagName.toLowerCase() === 'input' ? el : el.querySelector('input')
    if (!input) return
    if (document.activeElement === input) return
    const value = (binding.value || '').toString().replace(/,/g, '')
    input.value = formatRaw(value)
  },
  unbind(el) {
    const input =
      el.tagName.toLowerCase() === "input" ? el : el.querySelector("input");
    if (!input || !el._currency) return;
    input.removeEventListener("input", el._currency.onInput);
    input.removeEventListener("blur", el._currency.onBlur);
    delete el._currency;
  },
};

export { format };
