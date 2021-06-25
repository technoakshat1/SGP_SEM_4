export default function buildUnLike(likesController){
    return async function unlike(postId,userId){
        try {
            let removeLike=await likesController.removeLike(postId,userId);
            console.log(removeLike);
            if(removeLike && removeLike.nModified===1){
                return {unlike:true,unliked:postId};
            }else{
                return {unlike:false};
            }
        } catch (error) {
            console.error(error);
            return {unlike:false};
        }
    }
}