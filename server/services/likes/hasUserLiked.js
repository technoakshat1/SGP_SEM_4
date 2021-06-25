export default function buildHasUserLiked(likesController){
    return async function hasUserLiked(postId,userId){
        try {
            let hasUserLiked=await likesController.hasUserLiked(postId,userId);
            //console.log(hasUserLiked.postId+" "+postId);
            if(hasUserLiked && hasUserLiked.postId==postId){
                return {liked:true};
            }
            return {liked:false};
        } catch (error) {
            console.error(error);
            return {liked:false};
        }
    }
}