const jwt = require("jsonwebtoken");

const prisma = require("../config/prisma");

const authMiddleware = async (req, res, next) => {

  try {

    const authHeader = req.headers.authorization;

    if (!authHeader) {
      return res.status(401).json({
        error: "Unauthorized",
      });
    }

    const token = authHeader.split(" ")[1];

    const decoded = jwt.verify(
      token,
      process.env.JWT_SECRET
    );

    const seller = await prisma.seller.findUnique({
      where: {
        id: decoded.sellerId,
      },
      include: {
        wallet: true,
      },
    });

    if (!seller) {
      return res.status(401).json({
        error: "Seller not found",
      });
    }

    req.seller = seller;

    next();

  } catch (error) {

    return res.status(401).json({
      error: "Invalid token",
    });
  }
};

module.exports = authMiddleware;