const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const morgan = require("morgan");
const authRoutes = require("./routes/auth.routes");
const sellerRoutes = require("./routes/seller.routes");
const transactionRoutes = require("./routes/transaction.routes");

const app = express();

app.use(cors());
app.use(helmet());
app.use(morgan("dev"));
app.use(express.json());

app.get("/", (req, res) => {
  res.json({
    message: "Jaspay backend Running"
  });
});

app.use("/api/auth", authRoutes);
app.use("/api/seller", sellerRoutes);
app.use("/api/transactions", transactionRoutes);

module.exports = app;
