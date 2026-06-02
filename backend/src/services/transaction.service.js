const prisma = require("../config/prisma");

const createTransaction = async ({
  sellerId,
  amount,
  feeAmount = 0,
  type,
  description,
}) => {

  const reference =
      "JSP" +
      Date.now();

  return prisma.transaction.create({
    data: {
      sellerId,
      amount,
      feeAmount,
      type,
      description,
      reference,
    },
  });
};

module.exports = {
  createTransaction,
};