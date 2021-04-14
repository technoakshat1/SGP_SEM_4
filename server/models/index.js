import buildMakeUser from "./profile/user.js";
import buildExtractToken from "./token/token.js";
import buildLoginUser from "./profile/login_user.js";
import buildGoogleUser from "./profile/googleUser.js";
import buildFacebookUser from "./profile/facebookUser.js";
import buildPostsModel from "./posts/postModel.js";

export const makeUser = buildMakeUser();
export const extractToken = buildExtractToken();
export const loginUser = buildLoginUser();
export const makeGoogleUser = buildGoogleUser();
export const makeFacebookUser = buildFacebookUser();
export const postModel = buildPostsModel();

export default function models() {
  return Object.freeze({
    makeUser,
    extractToken,
    loginUser,
    makeGoogleUser,
    makeFacebookUser,
    postModel,
  });
}
