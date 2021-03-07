import { extractToken } from "../../models/index.js";
export default function buildIsAuthenticated(jwtController, userDb) {
  return async function isAuthenticated(authHeader,object) {
    try {
      let token = extractToken(authHeader);
      let verifiedUser = await jwtController.verify(token);

      let doesExist = await userDb.exists(verifiedUser);
      //console.log(doesExist);
       if(object){
         return Object.freeze({ authenticated: doesExist });
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
