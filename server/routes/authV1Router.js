const express = require("express");

import passport from "passport";
import { FirebaseDynamicLinks } from "firebase-dynamic-links";

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
  setGoogleUsername,
} from "../services/index.js";

export default function buildRouter() {
  const router = express.Router();

  const firebaseDynamicLinks = new FirebaseDynamicLinks(
    process.env.FIREBASE_API_KEY
  );

  router.get("/v1/user", async (req, res) => {
    let isAuth = await isAuthenticated(req, true);
    if (isAuth && isAuth.authenticated) {
      if (req.query.details) {
        let userDetails = await getUserDetails(
          isAuth.username,
          req.query.details
        );
        res.json(userDetails);
      } else {
        res.sendStatus(503);
      }
    } else {
      res.sendStatus(403);
    }
  });

  router.get("/v1/user/:username", async (req, res) => {
    let isAuth = await isAuthenticated(req, true);
    if (isAuth && isAuth.authenticated) {
      if (req.query.details) {
        let userDetails = await getUserDetails(
          req.params.username,
          req.query.details
        );
        res.json(userDetails);
      } else {
        res.sendStatus(503);
      }
    } else {
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
    let authenticated = await isAuthenticated(req, true);
    //console.log(authenticated);
    res.json(authenticated);
  });

  router.get("/v1/google/:googleId", async (req, res) => {
    let exists = await googleUserExists(req.params.googleId);
    res.json(exists);
  });

  router.post("/v1/google/username", async (req, res) => {
    let user = await setGoogleUsername(
      req.body.username,
      req.body.googleId,
      req.body.token,
    );
    res.json(user);
  });

  router.post("/v1/google/login", async (req, res) => {
    let token = await loginGoogleUser(req.body);
    res.json(token);
  });

  router.get("/v1/facebook/:facebookId", async (req, res) => {
    let exists = await facebookUserExists(req.params.facebookId);
    res.json(exists);
  });

  router.post("/v1/facebook/signUp", async (req, res) => {
    let user = await createFacebookUser(req.body, false);
    res.json(user);
  });

  router.post("/v1/facebook/login", async (req, res) => {
    let token = await loginFacebookUser(req.body);
    res.json(token);
  });

  router.get("/v1/web/google", (req, res, next) => {
    passport.authenticate("google", {
      scope: ["email", "profile"],
      session: false,
    })(req, res, next);
  });

  router.get("/v1/web/google/callback", (req, res, next) => {
    passport.authenticate("google", async function (err, user) {
      if (!err) {
        console.log(user);
        if (user.created) {
          //signup
          const { shortLink, previewLink } =
            await firebaseDynamicLinks.createLink({
              dynamicLinkInfo: {
                domainUriPrefix: "https://kitchencloud.page.link",
                link: `http://localhost:3000/google-login?created=true&token=${user.token}&googleId=${user.doc.googleId}`,
                androidInfo: {
                  androidPackageName: "com.adcDeepJobu.recipeApp",
                },
              },
            });
          res.redirect(shortLink);
          return;
        } else {
          //login
          const { shortLink, previewLink } =
            await firebaseDynamicLinks.createLink({
              dynamicLinkInfo: {
                domainUriPrefix: "https://kitchencloud.page.link",
                link: `http://localhost:3000/google-login?created=false&username=${user.doc.username}&googleId=${user.doc.googleId}&token=${user.token}`,
                androidInfo: {
                  androidPackageName: "com.adcDeepJobu.recipeApp",
                },
              },
            });
          //console.log(previewLink);
          res.redirect(shortLink);
          return;
        }
      }
      console.log(err);
      res.send("hELLO");
    })(req, res, next);
  });

  router.get("/v1/web/facebook", (req, res, next) => {
    passport.authenticate("facebook", { session: false })(req, res, next);
  });

  router.get("/v1/web/facebook/callback", (req, res, next) => {
    passport.authenticate("facebook", async function (err, user, profile) {
      if (!err) {
        if (user.created) {
          return res.send("Hello user created!");
        } else {
          //login
          return res.send("Hello! user logged in!");
        }
      }
      console.log(err);
      res.send("hELLO");
    })(req, res, next);
  });

  router.get("/v1", (req, res) => {
    res.send("<h1>Kitchen Cloud oAuth API!</h1>");
  });

  return router;
}
