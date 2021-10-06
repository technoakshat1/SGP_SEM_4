export default function buildWebFacebookLogin(jwtController, userDb) {
    return async function webFacebookLogin(httpBody) {
      try {
        let verifiedFacebookId = await jwtController.verify(httpBody.token);
        console.log(verifiedFacebookId);
        if (verifiedFacebookId === httpBody.facebookId) {
          let user = await userDb.getFacebookUser(verifiedFacebookId);
          //console.log(user);
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