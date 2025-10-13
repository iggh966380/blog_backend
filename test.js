import { pool } from "./db.js";

(async () => {
  try {
    const result = await pool.query("SELECT version();");
    console.log("✅ Connected! PostgreSQL version:", result.rows[0].version);
  } catch (err) {
    console.error("❌ Connection error:", err);
  } finally {
    await pool.end();
  }
})();
