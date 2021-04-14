export default function buildGetPostsByQuery(postRepo){
    return async function getPostsByQuery(query){
        try {
            let posts=await postRepo.getPostsByQuery(query);
            return {posts:posts,count:posts.length};
        } catch (error) {
            console.error(error);
            return {posts:null};
        }
    }
}