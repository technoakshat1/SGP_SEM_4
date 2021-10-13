import dotenv from "dotenv";
const express = require("express");
const cors = require("cors");
import passport from "passport";
import mongoose from "mongoose";
import session from "express-session";
var GoogleStrategy = require("passport-google-oauth20").Strategy;
var FacebookStrategy = require("passport-facebook").Strategy;

//routers
import buildRouter from "./routes/authV1Router.js";
import buildPostsRouter from "./routes/postsV1Router.js";
import buildNetworkRouter from "./routes/networkV1Router.js";
import buildLikesRouter from "./routes/likesV1Router.js";
import { googleUserExists, facebookUserExists } from "./services/index.js";
import { userDb,jwtController } from "./controller/index.js";

dotenv.config();

const app = express();

const googleCallbackLinkIP="192-168-27-220";//PCIPV4 WITH ALL DOTS(.) REPLACED BY DASHES(-)

app.use(
  express.urlencoded({
    extended: true,
  })
);

app.use(
  cors({
    credentials: true,
    origin: ["http://localhost:3000"],
    methods: ["GET", "POST", "PUT", "PATCH", "DELETE"],
  })
);

app.use(
  session({
    secret: process.env.API_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie:{
      maxAge:30*24*60*60*1000,
    }
  })
);

mongoose.connect("mongodb://localhost:27017/userDb1", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  useFindAndModify: false,
});
mongoose.set("useCreateIndex", true);
app.use(passport.initialize());
app.use(passport.session());
passport.serializeUser(function(user, done) {
  done(null, user.id);
});

passport.deserializeUser(async function(id, done) {
   try{
    let user=await userDb.getUser(id);
    done(null,user);
   }catch(err){
     done(err,null);
   }
});

passport.use(
  new GoogleStrategy(
    {
      clientID: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
      callbackURL: `http://${googleCallbackLinkIP}.nip.io:8000/auth/v1/web/google/callback`,
      userProfileURL: "https://www.googleapis.com/oauth2/v3/userinfo",
    },
    async function (accessToken, refreshToken, profile, cb) {
      try {
        let user = await userDb.findOrRegisterGoogleUser({
          googleId: profile.id,
          username: profile.username,
          email: profile._json.email,
          photoUrl: profile.photos[0].value,
          displayName: profile.displayName,
        });
        
        let token=await jwtController.sign(profile.id);

        let userWithToken={...user,token:token}
        return cb(null,userWithToken);
      } catch (err) {
        return cb(err, null);
      }
    }
  )
);

passport.use(
  new FacebookStrategy(
    {
      clientID: process.env.FACEBOOK_WEB_APP_ID,
      clientSecret: process.env.FACEBOOK_WEB_APP_SECRET,
      callbackURL: "http://localhost:8000/auth/v1/web/facebook/callback",
      profileFields: ["id", "emails", "name", "displayName",'picture.type(large)'],
      passReqToCallback: false,
    },
    async function (accessToken, refreshToken, profile, cb) {
      try {
        let user = await userDb.findOrRegisterFacebookUser({
          facebookId: profile.id,
          username: profile.username,
          email: profile._json.email,
          photoUrl:profile.photos[0].value,
          displayName: profile.displayName,
        });
        let token=await jwtController.sign(profile.id);
        return cb(null,{...user,token:token});
      } catch (err) {
        return cb(err, null);
      }
    }
  )
);

const authAPIRouter = buildRouter();
const postsAPIRouter = buildPostsRouter();
const networkAPIRouter = buildNetworkRouter();
const likesAPIRouter = buildLikesRouter();

app.use("/auth", authAPIRouter);
app.use("/posts", postsAPIRouter);
app.use("/network", networkAPIRouter);
app.use("/likes", likesAPIRouter);

app.listen(8000, function (req, res) {
  console.log("Server started at http://localhost:8000");
});

// app.get("/login", function(req,res){

//     if (isAuthenticated(req.headers.authorization)) {
//         res.json({ isAuthenticated: true });
//     } else {
//         res.sendStatus(403);
//     }

// });

// app.post("/login", function(req,res){
//     const user = new User({
//         username: req.body.username,
//       });

//       user.authenticate(req.body.password, (err, userModel, passwordErr) => {
//         //console.log(userModel);
//         if (!err) {
//           if (!passwordErr) {
//             jwt.sign(
//               { username: userModel.username },
//               process.env.JWT_SECRET,
//               { expiresIn: "2h" },
//               (err, token) => {
//                 if (!err) {
//                   res.json({ token });
//                 } else {
//                   res.sendStatus(500);
//                   console.log(err);
//                 }
//               }
//             );
//           } else {
//             res.status(403).send(passwordErr.message);
//             console.log(passwordErr);
//           }
//           console.log("login hoi gava hai");
//         } else {
//           res.sendStatus(500);
//           console.log(err);
//         }
//       });
// });

// app.get("/signup", function(req,res){

// });
// app.post("/signup", function(req,res){
//     User.register(
//         { username: req.body.username, firstName:req.body.firstName,lastName:req.body.lastName,email:req.body.email },
//         req.body.password,
//         (err, user) => {
//           if (!err) {
//             jwt.sign(
//               { username: user.username },
//               process.env.JWT_SECRET,
//               { expiresIn: "2h" },
//               (err, token) => {
//                 if (!err) {
//                   res.json({ token });
//                 } else {
//                   res.sendStatus(500);
//                   console.log(err);
//                 }
//               }
//             );
//             console.log("signup hoi gava hai nariyal fodo")
//           } else {
//             res.sendStatus(403);
//             console.log(err);
//           }
//         }
//     );
// });
// app.post("/login/confirmPassword", (req, res) => {
//     let token;
//     let authorization = req.headers.authorization;
//     if (authorization) {
//       token = authorization.split(" ")[1];
//     } else {
//       res.sendStatus(403);
//     }

//     jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
//       if (!err) {
//         if (decoded.username) {
//           let user = new User({
//             username: decoded.username,
//           });

//           user.authenticate(req.body.password, (err, userModel, passwordErr) => {
//             if (!err) {
//               if (!passwordErr) {
//                 res.json({ message: true });
//               } else {
//                 res.sendStatus(403);
//               }
//             } else {
//               res.sendStatus(403);
//             }
//           });
//         } else {
//           res.sendStatus(403);
//         }
//       } else {
//         res.sendStatus(500);
//       }
//     });
//   });

//   //password change route
//   app.post("/login/changePassword", (req, res) => {
//     let token;
//     if (req.headers.authorization) {
//       token = req.headers.authorization.split(" ")[1];
//     } else {
//       return;
//     }
//     jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
//       if (!err) {
//         if (decoded) {
//           User.findOne({ username: decoded.username }, (err, user) => {
//             if (!err) {
//               if (user) {
//                 user.setPassword(req.body.newPassword, (err) => {
//                   if (!err) {
//                     user.save();
//                     res.sendStatus(200);
//                   } else {
//                     console.log(err);
//                     res.sendStatus(500);
//                   }
//                 });
//               } else {
//                 console.log(user);
//                 res.status(404).send("user not found!");
//               }
//             } else {
//               console.log(err);
//               res.sendStatus(500);
//             }
//           });
//         } else {
//           console.log(decoded);
//           res.sendStatus(500);
//         }
//       } else {
//         console.log(err);
//         res.sendStatus(500);
//       }
//     });
//   });

//   //authentication function

//   function isAuthenticated(authorization) {
//     let token;
//     if (authorization) {
//       token = authorization.split(" ")[1];
//     } else {
//       return false;
//     }
//     let returnValue = false;
//     jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
//       if (!err) {
//         if (decoded.username) {
//           returnValue = true;
//         }
//       }
//     });
//     return returnValue;
//   }
