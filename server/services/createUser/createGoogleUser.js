import { makeGoogleUser } from "../../models/index.js";

export default function buildCreateGoogleUser(
  jwtController,
  userDb,
  verifyGoogleUser,
  networkController,
  postsRecordController
) {
  return async function createGoogleUser(httpBody) {
    try {
      let googleUser = makeGoogleUser({
        username: httpBody.username,
        googleId: httpBody.googleId,
        photoUrl: httpBody.photoUrl,
        displayName: httpBody.displayName,
        email: httpBody.email,
        postsRecordId: "",
        networkRepoId: "",
      });

      let userid = await verifyGoogleUser(httpBody.accessToken);

      if (userid) {
        if (userid === googleUser.googleId) {
          let postsRecord = await postsRecordController.createPostsRecord(
            googleUser.username
          );
          let networkRepo = await networkController.createNetworkRepo(
            googleUser.username
          );

          googleUser.postsRecordId = postsRecord.id;
          googleUser.networkRepoId = networkRepo.id;
          //console.log(googleUser);

          let user = await userDb.registerGoogleUser(googleUser);

          if (user) {
            let token = await jwtController.sign(user.username);
            return { token: token };
          }
        }
      }
      throw new Error("Server_error");
    } catch (err) {
      console.log(err);
      return { Error: err.message };
    }
  };
}
