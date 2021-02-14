import { makeUser } from "../../models/index.js";

export default function buildCreateUser(userDb) {
  return async function createUser(httpBody) {
    //console.log(httpBody);
    try {
      const user = makeUser({
        username: httpBody.username,
        firstName: httpBody.firstName,
        lastName: httpBody.lastName,
        email: httpBody.email,
        googleId: httpBody.googleId,
        photoUrl: httpBody.photoUrl,
        facebookId: httpBody.facebookId,
      });
      let registeredUser = await userDb.register(user, httpBody.password);

      return {signUp:true, token: registeredUser};
    } catch (err) {
      console.log(err.message);
      return{signUp:false,Error:err.message}
    }
  };
}
