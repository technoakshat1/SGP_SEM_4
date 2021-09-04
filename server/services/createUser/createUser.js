import { makeUser } from "../../models/index.js";

export default function buildCreateUser(
  userDb,
  networkController,
  postsRecordController
) {
  return async function createUser(httpBody,web) {
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
        postsRecordId: "",
        networkRepoId: "",
      });
      
       let postsRecord = await postsRecordController.createPostsRecord(
            user.username
          );
          let networkRepo = await networkController.createNetworkRepo(
            user.username
          );

          user.postsRecordId = postsRecord.id;
          user.networkRepoId = networkRepo.id;
          //console.log(user);

      let registeredUser = await userDb.register(user, httpBody.password,web);

      if(web){
        return registeredUser;
      }

      return { signUp: true, token: registeredUser };
    } catch (err) {
      console.log(err);
      return { signUp: false, Error: err.message };
    }
  };
}
