export default function buildMakeGoogleUser() {
  return function makeGoogleUser({
    username,
    email,
    photoUrl,
    googleId,
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

    if (googleId == null || googleId.length == 0) {
      throw new Error("googleId_empty");
    }

    if(accessToken==null||accessToken.length==0){
      throw new Error("password_empty");
    }

    return Object.freeze({
      username,
      email,
      photoUrl,
      googleId,
      displayName,
      googleAccessToken:accessToken,
    });
  };
}
