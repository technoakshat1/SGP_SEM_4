export default function buildLike(likesController){
    return async function like(postId,userId){
        try {
            let likeresponse=await likesController.addLike(postId,userId);
            if(likeresponse && likeresponse.nModified===1){
               return {liked:true};
            }
        } catch (error) {
            console.error(error);
            return {liked:false};
        }
    }
}