import pkg from "pg";
const { Pool } = pkg;
import dotenv from "dotenv";

let pool;

if (process.env.DATABASE_URL) {
  pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: { rejectUnauthorized: false }, // Railway 上通常需要
  });
  console.log("🌐 Using Railway DATABASE_URL");
} else {
  pool = new Pool({
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });
}

export { pool };
