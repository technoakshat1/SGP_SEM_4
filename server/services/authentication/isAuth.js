import {extractToken} from '../../models/index.js';
export default function buildIsAuthenticated(jwtController,userDb){
    return async function isAuthenticated(authHeader){
         let token=extractToken(authHeader);
         
         let verifiedUser=await jwtController.verify(token);

         let doesExist=await userDb.exists(verifiedUser);
         
         if(doesExist){
             return Object.freeze({authenticated:true});
         }
      return Object.freeze({authenticated:false});
    }
}