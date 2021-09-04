import mongoose from "mongoose";
import dotenv from 'dotenv';
import passport from "passport";
import passportLocalMongoose from "passport-local-mongoose";
import jwt from "jsonwebtoken";
import {OAuth2Client} from "google-auth-library";
import axios from 'axios';
import findOrCreate from 'mongoose-findorcreate';
dotenv.config();

//controllers
import buildUserDb from "./authentication/userDb.js";
import buildJwtController from "./authentication/jwtController.js";
import buildGoogleOAuthController from './authentication/OAuthGoogleController.js';
import buildOAuthFacebookController from './authentication/OAuthFacebookController.js';
import buildPostRepo from './posts/postRepo.js';
import buildNetworkController from "./network/networkRepo.js";
import buildLikesController from "./likes/likesRepo.js";
import buildPostsRecordController from "./posts/postsRecordIndex.js";

const userSchema = new mongoose.Schema({
  username: String,
  email: String,
  googleId: String,
  facebookId: String,
  photoUrl: String,
  displayName: String,
  networkRepoId:String,
  postsRecordId:String,
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
userSchema.plugin(findOrCreate);
const User = new mongoose.model("user", userSchema);
passport.use(User.createStrategy());

const postSchema=new mongoose.Schema({
  title:String,
  userId:String,
  displayName:String,
  caption:String,
  categories:[String],
  filters:[String],
  CookingInfo:{
    persons:Number,
    time:String,
    cost:String,
    ingredients:Array,
  },
  Method:{
    steps:Array,
  },
  comment:Boolean,
  commentsRepoId:String,
  media:{
    coverImage:String,
    images:Array,
    video:Array,
  },
  dateTime:Date,
  likesRepoId:String,
});

const networkRepoSchema=new mongoose.Schema({
  userId:String,
  following:[String],
  followers:[String],
});

const likesRepoSchema=new mongoose.Schema({
  postId:String,
  likedBy:Array,
});

const postsRecordSchema=new mongoose.Schema({
  userId:String,
  posts:[String],
});

const NetworkRepo=new mongoose.model("networkRepo",networkRepoSchema);

const Post=new mongoose.model("post",postSchema);

const LikesRepo=new mongoose.model("likesRepo",likesRepoSchema);

const PostsRecord=new mongoose.model("postsRecord",postsRecordSchema);

// console.log(process.env.JWT_SECRET);
export const jwtController = buildJwtController(jwt, process.env.JWT_SECRET);

export const userDb = buildUserDb(User, jwtController);

export const googleAuthController=buildGoogleOAuthController(OAuth2Client);
export const facebookAuthController=buildOAuthFacebookController(axios);
export const postRepo=buildPostRepo(Post);
export const networkController=buildNetworkController(NetworkRepo);
export const likesController=buildLikesController(LikesRepo);
export const postsRecordController=buildPostsRecordController(PostsRecord);
