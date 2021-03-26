import {makeFacebookUser} from "../../models/index.js";
export default function buildCreateFacebookUser(jwtController,userDb){
    return async function createFacebookUser(httpBody){
        try{
            let facebookUser=makeFacebookUser({
                username:httpBody.username,
                facebookId:httpBody.facebookId,
                photoUrl:httpBody.photoUrl,
                displayName:httpBody.displayName,
                email:httpBody.email,
                accessToken:httpBody.accessToken,
            });
            let user=await userDb.registerFacebookUser(facebookUser);
            if(user){
                let token=await jwtController.sign(user.username);
                return {token:token};
            }
        }catch(err){
            console.log(err.message);
            return{Error:err.message};
        }
    }
}