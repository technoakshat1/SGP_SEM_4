import { extractToken } from "../../models/index.js";
export default function buildRefreshFacebookAccessTokens(jwtController, userDb) {
  async function refreshFacebookAccessTokens(authorization, httpBody) {
    try {
      let facebookUser = await userDb.getFacebookUser(httpBody.facebookId);
      if (facebookUser && facebookUser.username == httpBody.username) {
        let token = extractToken(authorization);
        let verified = await jwtController.verify(token);
        if (verified) {
          let refreshedUser = await userDb.refreshFacebookAccessToken(
            facebookUser.facebookAccessToken,
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
    refreshFacebookAccessToken:refreshFacebookAccessToken,
  });
}