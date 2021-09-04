import { extractToken } from "../../models/index.js";
export default function buildIsAuthenticated(jwtController, userDb) {
  return async function isAuthenticated(req,object) {
    try {
      let verifiedUser;
      let token = extractToken(req.headers.authorization);
      if(token && token==='WEB'){
        //web-based authentication;
        if(req.isAuthenticated()){
          verifiedUser=req.user.username;
        }else{
          throw Error("Un-verified-user");
        }
      }else{
         verifiedUser = await jwtController.verify(token);
      }
     

      let doesExist = await userDb.exists(verifiedUser);
      //console.log(doesExist);
       if(object){
         return Object.freeze({ authenticated: doesExist,username:verifiedUser });
       }else{
         return true;
       }
        
    } catch (err) {
       console.error(err.message);
       if(object){
          return Object.freeze({ authenticated: false,Error: err.message});
       }else{
         return false;
       }
 
    }
  };
}
