const express = require("express");

//services
import {
  createUser,
  login,
  isAuthenticated,
  usernameAvailable,
  googleUserExists,
  createGoogleUser,
  loginGoogleUser,
  createFacebookUser,
  loginFacebookUser,
  facebookUserExists,
  getUserDetails,
} from "../services/index.js";

export default function buildRouter() {
  const router = express.Router();

  router.get("/v1/user",async (req,res)=>{
    let isAuth=await isAuthenticated(req.headers.authorization,true);
    if(isAuth && isAuth.authenticated){
      if(req.query.details){
        let userDetails=await getUserDetails(isAuth.username,req.query.details);
        res.json(userDetails);
      }else{
        res.sendStatus(503);
      }
    }else{
      res.sendStatus(403);
    }
  });
  
   router.get("/v1/user/:username",async (req,res)=>{
    let isAuth=await isAuthenticated(req.headers.authorization,true);
    if(isAuth && isAuth.authenticated){
      if(req.query.details){
        let userDetails=await getUserDetails(req.params.username,req.query.details);
        res.json(userDetails);
      }else{
        res.sendStatus(503);
      }
    }else{
      res.sendStatus(403);
    }
  });

  router.get("/v1/username_available/:username", async (req, res) => {
    let isAvailable = await usernameAvailable(req.params.username);
    res.json(isAvailable);
  });

  router.post("/v1/local/signUp", async (req, res) => {
    let token = await createUser(req.body);
    res.json(token);
  });

  router.post("/v1/local/login", async (req, res) => {
    let token = await login(req.body);
    res.json(token);
  });

  router.get("/v1/login", async (req, res) => {
    let authenticated = await isAuthenticated(req.headers.authorization,true);
    //console.log(authenticated);
    res.json(authenticated);
  });

  router.get('/v1/google/:googleId',async(req,res)=>{
     let exists=await googleUserExists(req.params.googleId);
     res.json(exists);
  });

  router.post('/v1/google/signUp',async (req,res)=>{
     let user=await createGoogleUser(req.body);
     res.json(user);
  });

  router.post('/v1/google/login',async(req,res)=>{
    let token=await loginGoogleUser(req.body);
    res.json(token);
  });

  router.get('/v1/facebook/:facebookId',async(req,res)=>{
    let exists=await facebookUserExists(req.params.facebookId);
    res.json(exists);
 });

 router.post('/v1/facebook/signUp',async (req,res)=>{
    let user=await createFacebookUser(req.body);
    res.json(user);
 });

 router.post('/v1/facebook/login',async(req,res)=>{
   let token=await loginFacebookUser(req.body);
   res.json(token);
 });

  router.get('/v1',(req,res)=>{
    res.send('<h1>Kitchen Cloud oAuth API!</h1>');
  })

  return router;
}
