export default function buildGoogleUserExists(userDb){
    return async function googleUserExists(googleId){
        try{
            let user=await userDb.googleUserExists(googleId);
            if(user && user.username){
              return {exists:true,username:user.username};
            }else{
                return {exists:false};
            }
            
        }catch(err){
            return {exists:false,Error:err.message};
        }
    }
}