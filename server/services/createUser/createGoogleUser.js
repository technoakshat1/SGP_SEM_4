import {makeGoogleUser} from "../../models/index.js";

export default function buildCreateGoogleUser(jwtController,userDb){
    return async function createGoogleUser(httpBody){
       try{
           let googleUser=makeGoogleUser({
              username:httpBody.username,
              googleId:httpBody.googleId,
              photoUrl:httpBody.photoUrl,
              displayName:httpBody.displayName,
              email:httpBody.email,
              accessToken:httpBody.accessToken,
           });

           let user=await userDb.registerGoogleUser(googleUser);

           if(user){
               let token=await jwtController.sign(user.username);
               return {token:token};
           }
       }catch(err){
           console.log(err.message);
           return {Error:err.message};
       }
    }
}