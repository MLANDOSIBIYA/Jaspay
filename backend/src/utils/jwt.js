const jwt = require("jsonwebtoken");

const generateToken = (seller) => {

  return jwt.sign(
    {
      sellerId: seller.id,
      mobileNumber: seller.mobileNumber,
    },

    process.env.JWT_SECRET,

    {
      expiresIn: "24h",
    }
  );
};

module.exports = {
  generateToken,
};