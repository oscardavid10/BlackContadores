
export default class Crypto {
    constructor() {
    }

    Encrypt(value, crypto) {
        return crypto.AES.encrypt(value, "bl4ckc0nt4d0r35.").toString()
    }

    Decrypt(value, crypto) {
        return crypto.AES.decrypt(value, "bl4ckc0nt4d0r35.").toString(crypto.enc.Utf8)
    }
}