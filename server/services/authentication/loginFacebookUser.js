export default function buildLoginFacebookUser(jwtController, userDb) {
    return async function loginFacebookUser(httpBody) {
      try {
        let user = await userDb.getFacebookUser(httpBody.facebookId);
  
        if (user) {
          if (
            user.username == httpBody.username &&
            user.facebookAccessToken == httpBody.accessToken
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
  