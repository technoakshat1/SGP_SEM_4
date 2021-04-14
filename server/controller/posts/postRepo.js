import escapeStringRegexp from "escape-string-regexp";
export default function buildPostRepo(Post){
    async function createPost(postData){
        let post=Post({
            ...postData,
            dateTime:Date.now(),
        });
        return await post.save();
    }

    async function getPostByUserId(userId){
        let post=await Post.findOne({userId:userId},null,{sort:{dateTime:-1}});
        //console.log(post);
        return post;
    }

    async function getLatestPostsByUserId(userId){
        let posts=await Post.find({userId:userId},null,{sort:{dateTime:-1}});
        return posts;
    }

    async function getLatestPostsByUserIds(userIds){
        let posts=await Post.find({userId:{$in:userIds}},null,{sort:{dateTime:-1}});
        return posts;
    }

    async function getPostsByCategories(categories){
        let posts=await Post.find({categories:{$in:categories}});
        return posts;
    }

    async function getPostsByFilters(filters){
        let posts=await Post.find({filters:{$in:filters}});
        return posts;
    }

    async function getPostsByCategoryAndFilters(category,filters){
        let posts=await Post.find({categories:{$in:category},filters:{$in:filters}});
        return posts;
    }

    async function getPostsByQuery(query){
        let $regex=escapeStringRegexp(query);
        let posts=await Post.find({title:{$regex,$options:"i"}});
        return posts;
    }

    return Object.freeze(
        {
            createPost:createPost,
            getPostByUserId:getPostByUserId,
            getLatestPostsByUserId:getLatestPostsByUserId,
            getLatestPostsByUserIds:getLatestPostsByUserIds,
            getPostsByCategories:getPostsByCategories,
            getPostsByFilters:getPostsByFilters,
            getPostsByQuery:getPostsByQuery,
            getPostsByCategoryAndFilters:getPostsByCategoryAndFilters,
        }
    )
}