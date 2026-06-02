const prisma = require("../config/prisma");

const {
  createTransaction,
} = require("../services/transaction.service");

const testCredit = async (req, res) => {
  try {
    const seller = req.seller;
    const amount = 100;

    await prisma.wallet.update({
      where: {
        sellerId: seller.id,
      },
      data: {
        balance: {
          increment: amount,
        },
        totalEarned: {
          increment: amount,
        },
      },
    });

    const transaction = await createTransaction({
      sellerId: seller.id,
      amount,
      type: "CREDIT",
      description: "Test wallet credit",
    });

    res.status(200).json({
      message: "Wallet credited",
      transaction,
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      error: "Internal server error",
    });
  }
};

const getTransactions = async (req, res) => {
  try {
    const transactions = await prisma.transaction.findMany({
      where: {
        sellerId: req.seller.id,
      },
      orderBy: {
        createdAt: "desc",
      },
    });

    res.status(200).json({
      transactions,
    });
  } catch (error) {
    res.status(500).json({
      error: "Internal server error",
    });
  }
};

module.exports = {
  testCredit,
  getTransactions,
};
