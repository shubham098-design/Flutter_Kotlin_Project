const UserModel = require("../models/user_model");
const bcrypt = require("bcrypt");

const UserController = {
  createAccount: async function (req, res) {
    try {
      const userData = req.body;
      const newUser = new UserModel(userData);
      await newUser.save();
      return res.json({
        success: true,
        data: newUser,
        message: "User created successfully",
      });
    } catch (err) {
      return res.json({ success: false, message: err.message });
    }
  },

  signIn: async function (req, res) {
    try {
      const { email, password } = req.body;
      const foundUser = await UserModel.findOne({ email: email });
      if (!foundUser) {
        return res.json({ success: false, message: "User not found" });
      }
      const isMatch = bcrypt.compareSync(password, foundUser.password);
      if (!isMatch) {
        return res.json({ success: false, message: "Password does not match" });
      }
      return res.json({
        success: true,
        data: foundUser,
        message: "User found",
      });
    } catch (err) {
      return res.json({ success: false, message: err.message });
    }
  },

  updateUser: async function (req, res) {
    try {
      const userId = req.params.id;
      const updateData = req.body;

      const updatedUser = await UserModel.findOneAndUpdate(
        { _id: userId },
        updateData,
        { new: true }
      );

      if (!updatedUser) {
        throw "user not found!";
      }

      return res.json({
        success: true,
        data: updatedUser,
        message: "User updated!",
      });
    } catch (ex) {
      return res.json({ success: false, message: ex });
    }
  },
};

module.exports = UserController;
