export default function buildSetGoogleUsername(
  userDb,
  jwtController,
  postsRecordController,
  networkController
) {
  return async function setGoogleUsername(username, googleId, token, web) {
    try {
      let tGoogleId = await jwtController.verify(token);

      if (tGoogleId === googleId) {
        let postsRecord = await postsRecordController.createPostsRecord(
          username
        );
        let networkRepo = await networkController.createNetworkRepo(username);
        let updated = await userDb.findUserAndUpdate(
          { googleId: googleId },
          {
            username: username,
            postsRecordId: postsRecord.id,
            networkRepoId: networkRepo.id,
          }
        );

        //console.log(updated);

        if (updated && !web) {
          let token = await jwtController.sign(username);
          if (token) {
            return { updated: true, token: token };
          }
        }
        if (updated && web) {
          let user = await userDb.getUser(updated._id);
          return user;
        }
      }

      return { updated: false, token: null };
    } catch (err) {
      console.error(err);
      return { updated: false, token: null };
    }
  };
}
