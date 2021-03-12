import { extractToken } from "../../models/index.js";
export default function buildRefreshAccessTokens(jwtController, userDb) {
  async function refreshGoogleAccessToken(authorization, httpBody) {
    try {
      let googleUser = await userDb.getGoogleUser(httpBody.googleId);
      if (googleUser && googleUser.username == httpBody.username) {
        let token = extractToken(authorization);
        let verified = await jwtController.verify(token);
        if (verified) {
          let refreshedUser = await userDb.refreshGoogleAccessToken(
            googleUser.googleAccessToken,
            httpBody.accessToken
          );
          //console.log(refreshedUser.n);
          if(refreshedUser.n===1){
              return {refreshedToken:true};
          }
        }
      }
      return {refreshedToken:false};
    }catch(err){
        return{refreshedToken:false,Error:err.message};
    }
  }

  return Object.freeze({
    refreshGoogleAccessToken:refreshGoogleAccessToken,
  });
}
