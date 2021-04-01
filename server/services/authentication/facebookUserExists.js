export default function buildFacebookUserExists(userDb){
    return async function facebookUserExists(facebookId){
        try {
            let user=await userDb.getFacebookUser(facebookId);
            if(user && user.username){
                return {exists:true, username:user.username};
            }else{
                return {exists:false};
            }
        } catch (err) {
            console.log(err);
            return {exists:false,Error:err.message};
        }
    }
}