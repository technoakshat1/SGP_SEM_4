export default function buildGoogleUserExists(userDb){
    return async function googleUserExists(httpBody){
        try{
            let user=await userDb.getGoogleUser(httpBody.googleId);
            if(user && user.username){
              return {exists:true,username:user.username};
            }else{
                return {exists:false};
            }
            
        }catch(err){
            console.log(err);
            return {exists:false,Error:err.message};
        }
    }
}