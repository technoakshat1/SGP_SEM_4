export default function buildPostsRecordController(PostsRecord){
    async function createPostsRecord(userId){
        let postsRecord=PostsRecord({
           userId:userId,
           posts:[],
        });

        return await postsRecord.save();
    }

    async function getRecord(userId){
        let postRecord=await PostsRecord.findOne({userId:userId});
        return postRecord;
    }

    async function addPost(userId,postId){
        let postsRecord=await PostsRecord.updateOne({userId:userId},{$push:{posts:[postId]}});
        return postsRecord;
    }

    async function removePost(userId,postId){
        let postsRecord=await PostsRecord.updateOne({userId:userId},{$pull:{posts:[postId]}});
        return postsRecord;
    }

    return Object.freeze({
        createPostsRecord:createPostsRecord,
        addPost:addPost,
        removePost:removePost,
        getRecord:getRecord,
    });
}