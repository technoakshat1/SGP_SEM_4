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

  async function getUser(id){
    let user=await userModel.findOne({_id:id});
    return user;
  }

  async function findOrRegisterGoogleUser(user){
    let foundOrCreatedUser=await userModel.findOrCreate({googleId:user.googleId},user);
    return foundOrCreatedUser;
  }

  async function findOrRegisterFacebookUser(user){
    let foundOrCreatedUser=await userModel.findOrCreate({facebookId:user.facebookId},user);
    return foundOrCreatedUser.doc;
  }

  async function findUserAndUpdate(conditions,fieldsToUpdate){
    let updatedUser=await userModel.findOneAndUpdate(conditions,fieldsToUpdate);
    return updatedUser;
  }

  return Object.freeze({
    register: register,
    exists: exists,
    login: login,
    getUser:getUser,
    getGoogleUser:getGoogleUser,
    getFacebookUser:getFacebookUser,
    registerGoogleUser:registerGoogleUser,
    registerFacebookUser:registerFacebookUser,
    getNetworkRepoId:getNetworkRepoId,
    getPostsRecordId:getPostsRecordId,
    getUserDetails:getUserDetails,
    findOrRegisterFacebookUser:findOrRegisterFacebookUser,
    findOrRegisterGoogleUser:findOrRegisterGoogleUser,
    findUserAndUpdate:findUserAndUpdate,
  });
}
