import dotenv from "dotenv";
import mongoose from "mongoose";
import passport from "passport";
import passportLocalMongoose from "passport-local-mongoose";
import jwt from "jsonwebtoken";
dotenv.config();

//controllers
import buildUserDb from "./userDb.js";
import buildJwtController from "./jwtController.js";

const userSchema = new mongoose.Schema({
  username: String,
  firstName: String,
  lastName: String,
  email: String,
  googleId: String,
  facebookId: String,
  photoUrl: String,
  displayName:String,
  googleAccessToken:String,
});
userSchema.plugin(passportLocalMongoose, {
  errorMessages: {
    IncorrectPasswordError: "password_incorrect",
    IncorrectUsernameError: "username_incorrect",
    MissingPasswordError :"password_empty",
    MissingUsernameError :"username_empty",
    UserExistsError:"username_duplicate"
  },
});
const User = new mongoose.model("user", userSchema);
passport.use(User.createStrategy());

// console.log(process.env.JWT_SECRET);
export const jwtController = buildJwtController(jwt, process.env.JWT_SECRET);
export const userDb = buildUserDb(User, jwtController);
