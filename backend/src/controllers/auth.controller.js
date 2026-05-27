const bcrypt = require("bcrypt");
const { v4: uuidv4 } = require("uuid");
const { generateToken } = require("../utils/jwt");

const prisma = require("../config/prisma");

const registerSeller = async (req, res) => {
  try {
    const {
      tradingName,
      legalName,
      mobileNumber,
      idLastFour,
      password
    } = req.body;

    const existingSeller = await prisma.seller.findUnique({
      where: {
        mobileNumber
      }
    });

    if (existingSeller) {
      return res.status(400).json({
        error: "Mobile number already registered"
      });
    }

    const passwordHash = await bcrypt.hash(password, 10);

    const referralCode = uuidv4().slice(0, 8);

    const seller = await prisma.seller.create({
      data: {
        tradingName,
        legalName,
        mobileNumber,
        idLastFour,
        passwordHash,
        referralCode,
        wallet: {
          create: {}
        }
      },
      include: {
        wallet: true
      }
    });

    res.status(201).json({
      message: "Seller registered successfully",
      seller
    });

  } catch (error) {
    console.log(error);

    res.status(500).json({
      error: "Internal server error"
    });
  }
};

const loginSeller = async (req, res) => {

  try {

    const {
      mobileNumber,
      password,
    } = req.body;

    const seller = await prisma.seller.findUnique({
      where: {
        mobileNumber,
      },
      include: {
        wallet: true,
      },
    });

    if (!seller) {
      return res.status(400).json({
        error: "Invalid credentials",
      });
    }

    const passwordMatch = await bcrypt.compare(
      password,
      seller.passwordHash
    );

    if (!passwordMatch) {
      return res.status(400).json({
        error: "Invalid credentials",
      });
    }

    const token = generateToken(seller);

    res.status(200).json({
      message: "Login successful",
      token,
      seller,
    });

  } catch (error) {

    console.log(error);

    res.status(500).json({
      error: "Internal server error",
    });
  }
};

module.exports = {
  registerSeller,
  loginSeller,
};

