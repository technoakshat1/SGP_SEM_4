import {isAuthenticated,like,unlike,getLikedBy,hasUserLiked} from "../services/index.js";

const express=require("express");

export default function buildRouter(){
    const router=express.Router();

    router.get("/v1/likedBy/:postId",async (req,res)=>{
        let isAuth=await isAuthenticated(req.headers.authorization,true);
       if(isAuth && isAuth.authenticated){
           let likeResponse=await getLikedBy(req.params.postId);
           res.json(likeResponse);
       }else{
           res.sendStatus(403);
       }
    });

    router.get("/v1/hasUserLiked/:postId",async (req,res)=>{
        let isAuth=await isAuthenticated(req.headers.authorization,true);
       if(isAuth && isAuth.authenticated){
           let likeResponse=await hasUserLiked(req.params.postId,isAuth.username);
           res.json(likeResponse);
       }else{
           res.sendStatus(403);
       }
    });

    router.get("/v1/like/:postId",async (req,res)=>{
       let isAuth=await isAuthenticated(req.headers.authorization,true);
       if(isAuth && isAuth.authenticated){
           let likeResponse=await like(req.params.postId,isAuth.username);
           res.json(likeResponse);
       }else{
           res.sendStatus(403);
       }
    });

    router.delete("/v1/like/:postId",async (req,res)=>{
        let isAuth=await isAuthenticated(req.headers.authorization,true);
        if(isAuth && isAuth.authenticated){
            let likeResponse=await unlike(req.params.postId,isAuth.username);
            res.json(likeResponse);
        }else{
            res.sendStatus(403);
        }
    });

    return router;
}