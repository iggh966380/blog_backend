import express from "express";
import cors from "cors";
import router from "./routes/router.js";
import dotenv from "dotenv";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

app.use("/api/getRouter", router);

app.listen(8080, () => {
  console.log(`Server running on http://localhost:${8080}`);
});
