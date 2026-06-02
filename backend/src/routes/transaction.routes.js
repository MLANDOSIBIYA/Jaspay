const express = require("express");

const router = express.Router();

const authMiddleware = require("../middleware/auth.middleware");

const {
  testCredit,
  getTransactions,
} = require("../controllers/transaction.controller");

router.post(
  "/credit",
  authMiddleware,
  testCredit
);

router.get(
  "/history",
  authMiddleware,
  getTransactions
);

module.exports = router;
