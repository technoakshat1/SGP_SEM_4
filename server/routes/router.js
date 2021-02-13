const express = require("express");

//services
import { createUser, login, isAuthenticated } from "../services/index.js";

export default function buildRouter() {
  const router = express.Router();

  router.post("/signUp", async (req, res) => {
    let token = await createUser(req.body);
    res.json(token);
  });

  router.post("/login", async (req, res) => {
    let token = await login(req.body);
    res.json(token);
  });

  router.get("/login", async (req, res) => {
    let authenticated = await isAuthenticated(req.headers.authorization);
    res.json(authenticated);
  });

  return router;
}
