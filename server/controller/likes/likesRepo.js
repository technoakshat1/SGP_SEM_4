export default function buildLikesController(LikesRepo){
    async function createLikesRepo(postId){
        let likesRepo=LikesRepo({
            postId:postId,
            likedBy:[],
        });

        return await likesRepo.save();
    }

    async function addLike(postId,userId){
        let likesRepo=await LikesRepo.updateOne({postId:postId},{$push:{likedBy:[userId]}});
        return likesRepo;
    }

    async function removeLike(postId,userId){
        let likesRepo=await LikesRepo.updateOne({postId:postId},{$pull:{likedBy:userId}});
        return likesRepo;
    }

    async function getLikedBy(postId){
        let likesRepo=await LikesRepo.findOne({postId:postId},'likedBy');
        return likesRepo.likedBy;
    }

    return Object.freeze({
      createLikesRepo:createLikesRepo,
      addLike:addLike,
      removeLike:removeLike,
      getLikedBy:getLikedBy,
    });
}