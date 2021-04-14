export default function buildGetLatestPostsByUserId(postRepo){
    return async function getLatestPostsByUserId(userId){
        try {
                let posts=await postRepo.getLatestPostsByUserId(userId);
                return {posts:posts,count:posts.length};
        } catch (error) {
            console.log(error);
            return {error:error.message};
        }
    }
}