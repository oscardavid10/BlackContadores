exports.dbconnection = function () {
  const connect = {
    server: "localhost",
    database: "blackcontadores",
    user: "SA",
    password: "TuPassword123!",
    port: 1433,
    setTimeout: 30000,

    options: {
      encrypt: false,
      trustedconnection: true,
    },
  };

  return connect;
};
