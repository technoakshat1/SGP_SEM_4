export default function buildGetPostByUserId(
  postRepo,
){
    return async function getPostByUserId(userId){
        try {
            let post=await postRepo.getPostByUserId(userId);
            if(post){
                return post;
            }
        } catch (error) {
            console.error(error);
            return {post:null};
        }
    }
}