const sql = require("mssql");

const config = {
  server: "127.0.0.1", // o "localhost"
  port: 1433,
  user: "SA",
  password: "TuPassword123!",
  database: "blackcontadores",
  options: {
    encrypt: false,
    trustServerCertificate: true,
  },
};

sql
  .connect(config)
  .then(() => {
    console.log("✅ Conexión exitosa a SQL Server");
    return sql.query`SELECT TOP 1 * FROM MtoCat_Empresas`;
  })
  .then((result) => {
    console.log("Resultado:", result.recordset);
    sql.close();
  })
  .catch((err) => {
    console.error("❌ Error de conexión:", err);
  });
