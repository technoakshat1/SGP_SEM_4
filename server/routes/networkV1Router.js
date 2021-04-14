import {isAuthenticated,follow,unfollow} from "../services/index.js";

const express=require("express");

export default function buildRouter(){
    const router=express.Router();

    router.get("/v1/follow/:userId",async (req,res)=>{
        let isAuth=await isAuthenticated(req.headers.authorization,true);
        if(isAuth && isAuth.authenticated){
            let networkResponse=await follow(isAuth.username,req.params.userId);
            res.json(networkResponse);
        }else{
            res.sendStatus(403);
        }
    });

    router.delete("/v1/follow/:userId",async (req,res)=>{
       let isAuth=await isAuthenticated(req.headers.authorization,true);
       if(isAuth && isAuth.authenticated){
           let networkResponse=await unfollow(isAuth.username,req.params.userId);
           res.json(networkResponse);
       }else{
           res.sendStatus(403);
       }
    });

    return router;
}