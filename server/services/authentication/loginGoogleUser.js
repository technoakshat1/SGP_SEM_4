export default function buildLoginGoogleUser(
  jwtController,
  userDb,
  verfiyGoogleUser
) {
  return async function loginGoogleUser(httpBody) {
    try {
      let userId = await verfiyGoogleUser(httpBody.accessToken);

      if (userId && userId === httpBody.googleId) {
        let user = await userDb.getGoogleUser(userId);

        if (user) {
          if (user.username === httpBody.username) {
            let token = await jwtController.sign(user.username);
            return { token: token };
          }
        }
      }
      return { Error: "accessToken_incorrect" };
    } catch (err) {
      console.log(err);
      return { Error: err.message };
    }
  };
}
