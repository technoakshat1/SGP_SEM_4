export default function buildUnfollow(networkRepo) {
  return async function unfollow(currentUserId, unFollowId) {
    try {
      if (currentUserId !== unFollowId) {
        let removeFollowingResponse = await networkRepo.removeFollowing(
          currentUserId,
          unFollowId
        );
        let removeFollowerResponse = await networkRepo.removeFollower(
          unFollowId,
          currentUserId
        );
        // console.log(removeFollowingResponse);
        // console.log(removeFollowerResponse);
        if (
          removeFollowingResponse &&
          removeFollowingResponse.nModified === 1 &&
          removeFollowerResponse &&
          removeFollowerResponse.nModified === 1
        ) {
          return { unfollow: true, unfollowed: unFollowId };
        }

        throw Error("unfollow_exeception");
      }

      throw Error("username_same");
      
    } catch (error) {
      console.error(error);
      return { unfollow: false , Error:error.message};
    }
  };
}
