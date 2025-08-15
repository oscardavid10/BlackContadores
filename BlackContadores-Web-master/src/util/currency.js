const format = (value, fractionDigits) => {
  const number = Number(value)
  if (isNaN(number)) return ''
  const options = fractionDigits !== undefined ? {
    minimumFractionDigits: fractionDigits,
    maximumFractionDigits: fractionDigits
  } : {}
  return number.toLocaleString('en-US', options)
}

export default {
  bind (el, binding, vnode) {
    const input = el.tagName.toLowerCase() === 'input' ? el : el.querySelector('input')
    if (!input) return

    const onInput = () => {
      const start = input.selectionStart
      const oldLength = input.value.length
      const raw = input.value.replace(/,/g, '')
      const [intPart = '', decPart] = raw.split('.')
      let formattedInt = ''
      if (intPart || intPart === '0') {
        const number = Number(intPart)
        if (!isNaN(number)) {
          formattedInt = number.toLocaleString('en-US')
        }
      } else if (raw.startsWith('.')) {
        formattedInt = '0'
      }
      input.value = decPart !== undefined ? `${formattedInt}.${decPart}` : formattedInt
      vnode.componentInstance.$emit('input', raw)
      const newLength = input.value.length
      const diff = newLength - oldLength
      const newPos = start + diff
      input.setSelectionRange(newPos, newPos)
    }

    const onBlur = () => {
      const raw = input.value.replace(/,/g, '')
      if (raw === '') return
      const val = Number(raw).toFixed(2)
      input.value = format(val, 2)
      vnode.componentInstance.$emit('input', val)
    }

    input.addEventListener('input', onInput)
    input.addEventListener('blur', onBlur)

    el._currency = { onInput, onBlur }
  },
  unbind (el) {
    const input = el.tagName.toLowerCase() === 'input' ? el : el.querySelector('input')
    if (!input || !el._currency) return
    input.removeEventListener('input', el._currency.onInput)
    input.removeEventListener('blur', el._currency.onBlur)
    delete el._currency
  }
}

export { format }
