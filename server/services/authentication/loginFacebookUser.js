export default function buildLoginFacebookUser(
  jwtController,
  userDb,
  verifyFacebookUser
) {
  return async function loginFacebookUser(httpBody) {
    try {
      let userId = await verifyFacebookUser(httpBody.accessToken);

      if (userId) {
        let user = await userDb.getFacebookUser(userId);

        if (user) {
          if (
            user.username == httpBody.username &&
            user.facebookId == httpBody.facebookId
          ) {
            let token = await jwtController.sign(user.username);
            return { token: token };
          }
        }
      }
      return { Error: "accessToken_incorrect" };
    } catch (err) {
      console.error(err);
      return { Error: err.message };
    }
  };
}
