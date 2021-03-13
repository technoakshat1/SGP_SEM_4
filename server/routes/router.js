const express = require("express");

//services
import {
  createUser,
  login,
  isAuthenticated,
  usernameAvailable,
  googleUserExists,
  createGoogleUser,
  refreshAccessTokens,
  loginGoogleUser,
} from "../services/index.js";

export default function buildRouter() {
  const router = express.Router();

  router.post("/username_available", async (req, res) => {
    let isAvailable = await usernameAvailable(req.body.username);
    res.json(isAvailable);
  });

  router.post("/signUp", async (req, res) => {
    let token = await createUser(req.body);
    res.json(token);
  });

  router.post("/login", async (req, res) => {
    let token = await login(req.body);
    res.json(token);
  });

  router.get("/login", async (req, res) => {
    let authenticated = await isAuthenticated(req.headers.authorization,true);
    //console.log(authenticated);
    res.json(authenticated);
  });

  router.post('/google_user_exists',async(req,res)=>{
     let exists=await googleUserExists(req.body);
     res.json(exists);
  });

  router.post('/signUp/googleUser',async (req,res)=>{
     let user=await createGoogleUser(req.body);
     res.json(user);
  });

  router.post('/login/refresh_google_access_token',async (req,res)=>{
     let refreshedToken=await refreshAccessTokens.refreshGoogleAccessToken(req.headers.authorization,req.body);
     res.json(refreshedToken);
  });

  router.post('/login/googleUser',async(req,res)=>{
    let token=await loginGoogleUser(req.body);
    res.json(token);
  });

  router.get('/',(req,res)=>{
    res.send('Hello welcome to kitchen cloud!');
  })

  return router;
}
