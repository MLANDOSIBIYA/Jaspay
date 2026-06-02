const getProfile = async (req, res) => {

  try {

    res.status(200).json({
      seller: req.seller,
    });

  } catch (error) {

    res.status(500).json({
      error: "Internal server error",
    });
  }
};

module.exports = {
  getProfile,
};