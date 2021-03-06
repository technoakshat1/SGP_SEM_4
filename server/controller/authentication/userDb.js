export default function buildUserDb(userModel, jwtController) {
  async function register(rawUser, password) {
    //console.log(password);
    let user = new userModel(rawUser);
    try {
      await userModel.register(user, password);
      const token = await jwtController.sign(user.username);
      user.save();
      return token;
    } catch (err) {
      user.deleteOne({ username: user.username });
      throw err;
    }
  }

  async function exists(username) {
    let isAvailable = await userModel.exists({ username: username });
    return isAvailable;
  }

  async function login(loginUser) {
    //console.log(loginUser);
    let authenticatedUser;

    try {
      authenticatedUser = await userModel.authenticate()(
        loginUser.username,
        loginUser.password
      );
      

      if (authenticatedUser.user) {
        const token = await jwtController.sign(authenticatedUser.user.username);
        return token;
      } else {
        throw authenticatedUser.error;
      }
    } catch (err) {
      throw err;
    }
  }

  async function getGoogleUser(googleId){
    let exists=await userModel.findOne({googleId:googleId});
    return exists;
  }

  async function registerGoogleUser(user){
    let googleUser=await userModel.create(user);
    return googleUser;
  }
  async function getFacebookUser(facebookId){
    let exists=await userModel.findOne({facebookId:facebookId});
    return exists;
  }

  async function registerFacebookUser(user){
    let facebookUser=await userModel.create(user);
    return facebookUser;
  }

  async function getNetworkRepoId(username){
    let networkRepoId=await userModel.findOne({username:username},'networkRepoId');
    return networkRepoId;
  }

  async function getPostsRecordId(username){
    let postsRecordId=await userModel.findOne({username:username},'postsRecordId');
    return postsRecordId;
  }

  async function getUserDetails(username,details){
    let user=await userModel.findOne({username:username},details);
    return user;
  }

  return Object.freeze({
    register: register,
    exists: exists,
    login: login,
    getGoogleUser:getGoogleUser,
    getFacebookUser:getFacebookUser,
    registerGoogleUser:registerGoogleUser,
    registerFacebookUser:registerFacebookUser,
    getNetworkRepoId:getNetworkRepoId,
    getPostsRecordId:getPostsRecordId,
    getUserDetails:getUserDetails,
  });
}
