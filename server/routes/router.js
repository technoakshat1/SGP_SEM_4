const express = require("express");

//services
import {
  createUser,
  login,
  isAuthenticated,
  usernameAvailable,
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

  return router;
}
