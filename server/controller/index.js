import mongoose from "mongoose";
import dotenv from 'dotenv';
import passport from "passport";
import passportLocalMongoose from "passport-local-mongoose";
import jwt from "jsonwebtoken";
import {OAuth2Client} from "google-auth-library";
import axios from 'axios';
dotenv.config();

//controllers
import buildUserDb from "./authentication/userDb.js";
import buildJwtController from "./authentication/jwtController.js";
import buildGoogleOAuthController from './authentication/OAuthGoogleController.js';
import buildOAuthFacebookController from './authentication/OAuthFacebookController.js';

const userSchema = new mongoose.Schema({
  username: String,
  firstName: String,
  lastName: String,
  email: String,
  googleId: String,
  facebookId: String,
  photoUrl: String,
  displayName: String,
});
userSchema.plugin(passportLocalMongoose, {
  errorMessages: {
    IncorrectPasswordError: "password_incorrect",
    IncorrectUsernameError: "username_incorrect",
    MissingPasswordError :"password_empty",
    MissingUsernameError :"username_empty",
    UserExistsError:"username_duplicate",
    NoSaltValueStoredError:"username_incorrect"
  },
});
const User = new mongoose.model("user", userSchema);
passport.use(User.createStrategy());

// console.log(process.env.JWT_SECRET);
export const jwtController = buildJwtController(jwt, process.env.JWT_SECRET);
export const userDb = buildUserDb(User, jwtController);
export const googleAuthController=buildGoogleOAuthController(OAuth2Client);
export const facebookAuthController=buildOAuthFacebookController(axios);
