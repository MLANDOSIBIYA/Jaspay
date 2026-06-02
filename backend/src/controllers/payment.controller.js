const prisma = require("../config/prisma");
const { v4: uuidv4 } = require("uuid");

const createPaymentRequest =
  async (req, res) => {

    try {

      const {
        amount,
        description,
      } = req.body;

      const seller =
          req.seller;

      const qrCode =
          uuidv4();

      const paymentRequest =
          await prisma.paymentRequest.create({
        data: {
          sellerId:
              seller.id,

          amount,

          description,

          qrCode,
        },
      });

      res.status(201).json({
        message:
            "Payment request created",

        paymentRequest,
      });

    } catch (error) {

      console.log(error);

      res.status(500).json({
        error:
            "Internal server error",
      });
    }
};

module.exports = {
  createPaymentRequest,
};