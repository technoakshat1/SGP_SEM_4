export default function buildMakeFacebookUser() {
    return function makeFacebookUser({
      username,
      email,
      photoUrl,
      facebookId,
      displayName,
      accessToken,
    }) {
      if (username == null) {
        throw new Error("username_empty");
      }
  
      if (username.length == 0) {
        throw new Error("username_empty");
      }
  
      if (username.length > 20) {
        throw new Error("username_outOfRange");
      }
  
      if (email == null || email.length == 0) {
        throw new Error("email_empty");
      }
  
      if (facebookId == null || facebookId.length == 0) {
        throw new Error("facebookId_empty");
      }
  
      if(accessToken==null||accessToken.length==0){
        throw new Error("password_empty");
      }
  
      return Object.freeze({
        username,
        email,
        photoUrl,
        facebookId,
        displayName,
        facebookAccessToken:accessToken,
      });
    };
  }
  