export default function buildUserDb(userModel,jwtController){

      async function register(rawUser,password){
        //console.log(password);
         let user = userModel(rawUser);
         await userModel.register(user,password);
         await user.save();
         const token=await jwtController.sign(user);
         return {token:token};
       }

       async function login(loginUser){ 
       //console.log(loginUser);   
       const authenticatedUser = await userModel.authenticate()(loginUser.username, loginUser.password);
       //console.log(authenticatedUser);
       const token=await jwtController.sign(authenticatedUser.user);
       return token;
       }

       async function exists(username){
         let query=await userModel.findOne({username:username}).exec();
         //console.log(query);{
  // _id: 6027adbcf712ea4ffce79c97,
  // username: 'test5',
  // email: 'test@test.com',
  // firstName: 'Akshat',
  // lastName: 'chhaya',
  // photoUrl: '',
  // googleId: '',
  // facebookId: '',
  // __v: 0
//
         if(query){
           return true;
         }
         return false;
       }

        return Object.freeze({
         register:async(user,password)=>await register(user,password),
         exists:async(username)=>await exists(username),
         login:async(loginUser)=>await login(loginUser)
       });
}