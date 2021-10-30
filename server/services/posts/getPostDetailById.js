export default function buildGetPostById(
    postRepo,
  ){
      return async function getPostById(postId){
          try {
              let post=await postRepo.getPostDetailsById(postId);
              if(post){
                  return post;
              }
          } catch (error) {
              console.error(error);
              return {post:null};
          }
      }
  }