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

  async function refreshGoogleAccessToken(oldToken,newToken){
    //console.log(oldToken+' '+newToken);
    let refreshedToken=await userModel.updateOne({googleAccessToken:oldToken},{googleAccessToken:newToken});
    return refreshedToken;
  }

  async function registerGoogleUser(user){
    let googleUser=await userModel.create(user);
    return googleUser;
  }

  return Object.freeze({
    register: register,
    exists: exists,
    login: login,
    getGoogleUser:getGoogleUser,
    refreshGoogleAccessToken:refreshGoogleAccessToken,
    registerGoogleUser:registerGoogleUser,
  });
}
