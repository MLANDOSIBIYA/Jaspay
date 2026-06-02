const express = require("express");

const router =
    express.Router();

const authMiddleware =
    require("../middleware/auth.middleware");

const {
  createPaymentRequest,
} = require(
  "../controllers/payment.controller"
);

router.post(
  "/create",
  authMiddleware,
  createPaymentRequest
);

module.exports =
    router;