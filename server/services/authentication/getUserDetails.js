export default function buildGetUserDetails(userDb){
    return async function getUserDetails(username,details){
        try {
            let userDetails=await userDb.getUserDetails(username,details);
            if(userDetails){
                return {user:userDetails};
            }
        } catch (error) {
            console.error(error);
            return {user:null};
        }
    }
}