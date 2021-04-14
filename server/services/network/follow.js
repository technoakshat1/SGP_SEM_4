export default function buildFollow(networkRepo){
    return async function follow(currentUserId,followingId){
        try {
            let networkRecord=await networkRepo.addFollowing(currentUserId,followingId);
            let following=await networkRepo.addFollowers(followingId,currentUserId);
            if(networkRecord && following){
                return {followed:true,nowFollowing:followingId};
            }
        } catch (error) {
            console.error(error);
            return {followed:false,Error:error};
        }
    }
}