export default function buildLoginGoogleUser(jwtController, userDb) {
  return async function loginGoogleUser(httpBody) {
    try {
      let user = await userDb.getGoogleUser(httpBody.googleId);

      if (user) {
        if (
          user.username == httpBody.username &&
          user.googleAccessToken == httpBody.accessToken
        ) {
          let token = await jwtController.sign(user.username);
          return { token: token };
        }else{
            return {Error:"accessToken_incorrect"};
        }
      }
    } catch (err) {
      console.log(err);
      return { Error: err.message };
    }
  };
}
