import dotenv from "dotenv";
const express = require("express");
import buildRouter from "./routes/authV1Router.js";
import bodyParser from "body-parser";
import passport from "passport";
import passportLocalMongoose from "passport-local-mongoose";
import mongoose from "mongoose";
import jwt from "jsonwebtoken";

dotenv.config();

const app = express();

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

mongoose.connect("mongodb://localhost:27017/userDb1", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});
mongoose.set("useCreateIndex", true);
app.use(passport.initialize());

const authAPIRouter = buildRouter();

app.use("/auth",authAPIRouter);

app.listen(3000, function (req, res) {
  console.log("Server started at http://localhost:3000");
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
