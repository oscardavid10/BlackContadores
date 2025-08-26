exports.dbconnection = function () {
  const connect = {
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

  return connect;
};
