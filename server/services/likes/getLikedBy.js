export default function buildGetLikedBy(likesController){
    return async function getLikedBy(postId){
        try {
            let likedBy=await likesController.getLikedBy(postId);
            if(likedBy){
                return {likedBy:likedBy,count:likedBy.length};
            }
        } catch (error) {
            console.error(error);
            return {likedBy:null};
        }
    }
}