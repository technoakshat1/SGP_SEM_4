import { makeFacebookUser } from "../../models/index.js";
export default function buildCreateFacebookUser(
  jwtController,
  userDb,
  verifyFacebookUser,
  networkController,
  postsRecordController
) {
  return async function createFacebookUser(httpBody) {
    try {
      let facebookUser = makeFacebookUser({
        username: httpBody.username,
        facebookId: httpBody.facebookId,
        photoUrl: httpBody.photoUrl,
        displayName: httpBody.displayName,
        email: httpBody.email,
        postsRecordId:"",
        networkRepoId:"",
      });
      let userId = await verifyFacebookUser(httpBody.accessToken);
      console.log(userId + "From service controller");
      if (userId && userId === facebookUser.facebookId) {
        let postsRecord=await postsRecordController.createPostsRecord(facebookUser.username);
        let networkRepo=await networkController.createNetworkRepo(facebookUser.username);
        facebookUser.postsRecordId=postsRecord.id;
        facebookUser.networkRepoId=networkRepo.id;
        //console.log(facebookUser);
        let user = await userDb.registerFacebookUser(facebookUser);
        if (user) {
          let token = await jwtController.sign(user.username);
          return { token: token };
        }
      }
    } catch (err) {
      console.log(err);
      return { Error: err.message };
    }
  };
}
