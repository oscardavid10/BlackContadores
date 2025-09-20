# BlackContadores
Sistema administrativo web para la gestión de clientes, facturación, pagos y reportes contables.  
Desarrollado para **[Alfredo - BlackContadores]** en stack **JavaScript fullstack**.

---

## 🧩 ¿Qué es BlackContadores?

Solución todo-en-uno que permite:

* Catálogo de clientes y usuarios internos  
* Emisión de facturas y recibos de pago  
* Cobro con tarjeta (**Conekta**)  
* Envío automático de comprobantes por e-mail  
* Exportación de reportes a Excel  
* Panel administrativo responsive (Vuetify)  
* Autenticación segura (JWT + bcrypt)  

---

## 🚀 Demo rápida

| Módulo         | URL local después de `npm run serve` / `npm start` |
|----------------|-----------------------------------------------------|
| Web App        | http://localhost:8080                               |
| API REST       | http://localhost:3000                               |
| Swagger (si se agrega) | http://localhost:3000/docs (próximamente)      |

---

## 🏗️ Stack técnico

| Capa        | Tecnologías principales                                                                 |
|-------------|------------------------------------------------------------------------------------------|
| Frontend    | Vue 2.6 + Vuetify 2 + Vuex + Vue Router + Axios                                        |
| Backend     | Node.js 14+ + Express 4 + JWT + bcrypt + Conekta + Nodemailer                         |
| Base de datos | SQL Server 2019 (script incluido)                                                     |
| Utilidades  | Moment.js, LINQ, CryptoJS, Excel-export (vue-json-excel), máscaras de entrada (v-mask) |

---

## Endpoints API (resumen)

|Método| Ruta | Descripción |
|---|---|---|
|POST| `/api/auth/login` | Login devuelve JWT |
|GET| `/api/clientes` | Listar clientes |
|POST| `/api/clientes` | Crear cliente |
|PUT| `/api/clientes/:id` | Actualizar cliente |
|GET| `/api/facturas` | Listar facturas |
|POST| `/api/facturas` | Crear factura y timbrar |
|POST| `/api/pagos` | Registrar pago con Conekta |
|GET| `/api/reportes/excel` | Exportar reporte mensual |
