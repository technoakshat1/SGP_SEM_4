export default function buildSetFacebookUsername(
  userDb,
  jwtController,
  postsRecordController,
  networkController
) {
  return async function setFacebookUsername(username, facebookId, token) {
    try {
      let tFacebookId = await jwtController.verify(token);

      if (tFacebookId === facebookId) {
        let postsRecord = await postsRecordController.createPostsRecord(
          username
        );
        let networkRepo = await networkController.createNetworkRepo(username);

        let updated = await userDb.findUserAndUpdate(
          { facebookId: facebookId },
          {
            username: username,
            postsRecordId: postsRecord.id,
            networkRepoId: networkRepo.id,
          }
        );


        if (updated) {
          let user = await userDb.getUser(updated._id);
          return user;
        }
      }

      return { updated: false };
    } catch (err) {
      console.error(err);
      return { updated: false, Error: err };
    }
  };
}
