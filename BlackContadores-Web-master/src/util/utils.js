export default class Utils {
    constructor() {
    }

    RegExpPassword(value) {
        const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#/$%/^&/*])(?=.{8,})/;

        if (pattern.test(value))
            return true
        else
            return false
    }

    RegExpEmail(value) {
        const pattern = /^[^@]+@[^@]+\.[a-zA-Z]{2,}$/;

        if (pattern.test(value))
            return true
        else
            return false
    }

    RegExpTelefono(value) {
        const pattern = /^[0-9]{10}$/;

        if (pattern.test(value))
            return true
        else
            return false
    }

    GetValue(key) {
        return localStorage.getItem(key)
    }

    SetValue(value, key) {
        localStorage.setItem(key, value)
    }

}