export default function buildNetworkController(Network) {
    async function createNetworkRepo(userId){
        let networkRepo=Network({
            userId:userId,
            followers:[],
            following:[],
        });
        return await networkRepo.save();
    }

    async function getNetworkRepo(userId){
        let networkRepo=await Network.findOne({userId:userId});
        return networkRepo;
    }

    async function addFollowers(userId,followers){
        let networkRepo=await Network.updateOne({userId:userId},{$push:{followers:followers}});
        return networkRepo;
    }

    async function addFollowing(userId,following){
        let networkRepo=await Network.updateOne({userId:userId},{$push:{following:[following]}});
        return networkRepo;
    }

    async function removeFollower(userId,followerId){
        let networkRepo=await Network.updateOne({userId:userId},{$pull:{followers:followerId}});
        return networkRepo;
    }

    async function removeFollowing(userId,followingId){
        let networkRepo=await Network.updateOne({userId:userId},{$pull:{following:followingId}});
        return networkRepo;
    }

    return Object.freeze({
      createNetworkRepo:createNetworkRepo,
      getNetworkRepo:getNetworkRepo,
      addFollowers:addFollowers,
      addFollowing:addFollowing,
      removeFollower:removeFollower,
      removeFollowing:removeFollowing,
    });
}