import express, { Request, Response } from "express";
import dotenv from "dotenv";
import pool from "./db.js";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// Health route
app.get("/health", (_req: Request, res: Response) => {
  res.json({ status: "ok" });
});

// Example route
app.get("/users", async (_req: Request, res: Response) => {
  try {
    const [rows] = await pool.query("SELECT id, name, email FROM users");
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
});

app.listen(PORT, () => {
  console.log(`✅ Server running at http://localhost:${PORT}`);
});
