export default function buildGetLatestPostsByUserIds(postRepo,networkRepo){
    return async function getLatestPostsByUserIds(currentUserId){
        try {
            let userIds=await networkRepo.getNetworkRepo(currentUserId);
            if(userIds && userIds.following.length!==0){
                //console.log(userIds.following);
                let posts=await postRepo.getLatestPostsByUserIds(userIds.following);
                if(posts){
                    return {posts:posts,count:posts.length};
                }
            }
        } catch (error) {
            console.error(error);
            return {posts:null};
        }
    }
}