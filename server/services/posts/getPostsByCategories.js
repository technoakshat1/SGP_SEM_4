export default function buildGetPostByCategories(postRepo){
    return async function getPostsByCategories(categories){
        try {
            let posts=await postRepo.getPostsByCategories(categories);
            if(posts){
                return {posts:posts,count:posts.length};
            }
            
        } catch (error) {
            console.error(error);
            return {posts:null};
        }
    }
}