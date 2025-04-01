const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const authRouter = express.Router();

// ✅ Signup API
authRouter.post("/api/users/signup", async (req, res) => {
  try {
    const { name, email, password, address, type } = req.body;

    // ✅ Check if user already exists
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    // ✅ Hash Password
    const hashedPassword = await bcrypt.hash(password, 10);

    // ✅ Create New User
    const newUser = new User({
      name,
      email,
      password: hashedPassword,
      address: address || "", // Default empty
      type: type || "user", // Default to "user"
    });

    await newUser.save();

    // ✅ Generate JWT Token
    const token = jwt.sign({ userId: newUser._id }, "your_secret_key", { expiresIn: "7d" });

    // ✅ Send Response
    res.status(201).json({
      message: "User registered successfully",
      token,
      user: {
        _id: newUser._id,
        name: newUser.name,
        email: newUser.email,
        address: newUser.address,
        type: newUser.type,
      },
    });

  } catch (error) {
    console.error("🚨 Signup Error:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
});

authRouter.post("/api/users/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ error: "User not found" });
    }

    // Generate JWT Token
    const token = jwt.sign({ userId: user._id }, "your_secret_key", { expiresIn: "7d" });

    // ✅ Send Full User Data in Response
    res.status(200).json({
      message: "Login successful",
      token,
      user: {
        _id: user._id,
        name: user.name,
        email: user.email,
        address: user.address,
        type: user.type,
      }
    });
  } catch (error) {
    console.error("Login Error:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});


authRouter.post("/api/users/logout", (req, res) => {
  res.json({ message: "Logout successful" });
});

authRouter.put("/api/users/update/:id", async (req, res) => {
  try {
    const { name, email, address, type } = req.body;

    const updatedUser = await User.findByIdAndUpdate(
      req.params.id,
      { name, email, address, type },
      { new: true }
    );

    if (!updatedUser)
      return res.status(404).json({ message: "User not found" });

    res.json({ message: "User updated successfully", user: updatedUser });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

authRouter.get("/api/users/all", async (req, res) => {
  try {
    const users = await User.find();
    res.json({ users });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

authRouter.get("/api/users/:id", async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) return res.status(404).json({ message: "User not found" });

    res.json({ user });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

authRouter.delete("/api/users/:id", async (req, res) => {
  try {
    const deletedUser = await User.findByIdAndDelete(req.params.id);
    if (!deletedUser)
      return res.status(404).json({ message: "User not found" });

    res.json({ message: "User deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = authRouter;
