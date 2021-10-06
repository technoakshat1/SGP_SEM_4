export default function buildWebGoogleLogin(jwtController, userDb) {
  return async function webGoogleLogin(httpBody) {
      //console.log(httpBody);
    try {
      let verifiedGoogleId = await jwtController.verify(httpBody.token);
      if (verifiedGoogleId === httpBody.googleId) {
        let user = await userDb.getGoogleUser(verifiedGoogleId);
        if (user) {
          return user;
        }
      }
      throw Error("Un-verified-user");
    } catch (error) {
      console.error(error);
      return { Error: error.message };
    }
  };
}
