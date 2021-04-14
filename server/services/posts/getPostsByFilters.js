export default function buildGetPostsByFilters(postRepo){
    return async function getPostsByFilters(filters) {
        try {
            let posts=await postRepo.getPostsByFilters(filters);
            return {posts:posts,count:posts.length};
        } catch (error) {
            console.error(error);
            return {posts:null};
        }
    }
}