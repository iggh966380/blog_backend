import express from "express";
import { pool } from "../db.js";

const router = express.Router();

router.get("/", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM nodes");
    console.log(result);
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "unknown error" });
  }
});

export default router;
