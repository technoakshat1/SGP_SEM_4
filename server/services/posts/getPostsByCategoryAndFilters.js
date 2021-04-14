export default function buildGetPostsByCategoryAndFilters(postRepo){
    return async function getPostsByCategoryAndFilters(category,filters){
        try {
            let posts=await postRepo.getPostsByCategoryAndFilters(category,filters);
            if(posts){
                return {posts:posts,count:posts.length};
            }
        } catch (error) {
            console.error(error);
            return {posts:null};
        }
    }
}