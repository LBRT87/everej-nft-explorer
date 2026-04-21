const mysql = require("mysql2")
const db = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "",
    database: "everej",
    waitForConnections:true,
    connectionLimit:100,
    queueLimit:100
})

console.log("Database Terhubung")
module.exports = db;