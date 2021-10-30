import {
  isAuthenticated,
  createPost,
  getPostByUserId,
  getLatestPostsByUserId,
  getLatestPostsByUserIds,
  getPostsByQuery,
  getPostsByCategories,
  getPostsByFilters,
  getPostsByCategoryAndFilters,
  getPostById,
} from "../services/index.js";

import {array} from "./recipes.js";

const express = require("express");

export default function buildPostRouter() {
  const router = express.Router();

  router.get("/v1/posts", async (req, res) => {
    let isAuth = await isAuthenticated(req, true);
    if (isAuth && isAuth.authenticated) {
        //console.log(req.query);
      if (req.query.q || req.query.cat || req.query.filter) {
          let searchQuery=req.query.q;
          let category=req.query.cat;
          let filter=req.query.filter;
          if(searchQuery){
              let posts=await getPostsByQuery(searchQuery);
              res.json(posts);
          }else if(category && filter){
            console.log(filter);
            let posts=await getPostsByCategoryAndFilters(category,filter);
            //console.log(posts);
            res.json(posts);
          }else if(category){
            //console.log(category);
            let posts=await getPostsByCategories(category);
            res.json(posts);
          }else if(filter){
            let posts=await getPostsByFilters(filter);
            res.json(posts);
          }
      } else {
        let posts = await getLatestPostsByUserIds(isAuth.username);
        res.json(posts);
      }
    } else {
      res.sendStatus(403);
    }
  });

  router.get("/v1/posts/:userId", async (req, res) => {
    let isAuth = await isAuthenticated(req, true);
    if (isAuth && isAuth.authenticated) {
      let post = await getLatestPostsByUserId(req.params.userId);
      res.json(post);
    } else {
      res.sendStatus(403);
    }
  });

  router.get("/v1/post/:userId", async (req, res) => {
    let isAuth = await isAuthenticated(req, true);
    if (isAuth && isAuth.authenticated) {
      let post = await getPostByUserId(req.params.userId);
      res.json(post);
    } else {
      res.sendStatus(403);
    }
  });
  router.get("/v1/postById/:postId", async (req, res) => {
    //let isAuth = await isAuthenticated(req, true);
    //if (isAuth && isAuth.authenticated) {
      let post = await getPostById(req.params.postId);
      res.json(post);
    //} else {
      //res.sendStatus(403);
    //}
  });

  router.post("/v1/post", async (req, res) => {
    let isAuth = await isAuthenticated(req, true);
    //console.log(isAuth);
    if (isAuth && isAuth.authenticated) {
      let post = await createPost(isAuth.username, req.body);
      res.json(post);
    } else {
      res.sendStatus(403);
    }
  });

  router.post("/v1/uploadTest/:username",async (req,res)=>{
     for(let i=0;i<array.length;i++){
       let post=await createPost(req.params.username,array[i]);
       console.log(post);
     }
  });

  return router;
}
