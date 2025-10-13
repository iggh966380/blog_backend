import pkg from "pg";
const { Pool } = pkg;
import dotenv from "dotenv";

export const pool = new Pool({
  user: "postgres", // 安裝時設定的帳號
  host: "127.0.0.1", // 或 127.0.0.1
  database: "postgres", // 你的 DB 名稱
  password: "!Live2019", // 記得改成實際密碼
  port: 6543, // PostgreSQL 預設埠號
});
