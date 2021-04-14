import { postModel } from "../../models/index.js";
export default function buildCreatePost(
  postRepo,
  postsRecordController,
  likeController
) {
  return async function createPost(userId,httpBody) {
    try {
      let post = postModel({
          ...httpBody,
          userId:userId,
      });
      if (post) {
        let storedPost = await postRepo.createPost(post);
        let likesRepo=await likeController.createLikesRepo(storedPost.id);
        let record=await postsRecordController.addPost(userId,storedPost.id);
        if(likesRepo&&record){
          storedPost.likesRepoId=likesRepo.id;
         let modifiedPost=await storedPost.save();
         if(modifiedPost.likesRepoId===likesRepo.id){
           return {posted:true};
         }
        }
      }
    } catch (err) {
      console.error(err);
      return { posted: false };
    }
  };
}
