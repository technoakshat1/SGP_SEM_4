export default function buildLike(likesController){
    return async function like(postId,userId){
        try {
            let likeresponse=await likesController.addLike(postId,userId);
            console.log(likeresponse);
            if(likeresponse && likeresponse.nModified===1){
               return {liked:true};
            }else{
                return {liked:false};
            }
        } catch (error) {
            console.error(error);
            return {liked:false};
        }
    }
}