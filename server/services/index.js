//controllers
import {
  jwtController,
  userDb,
  googleAuthController,
  facebookAuthController,
  networkController,
  postsRecordController,
  postRepo,
  likesController,
} from "../controller/index.js";
//use-cases
import buildIsAuthenticated from "./authentication/isAuth.js";
import buildCreateUser from "./createUser/createUser.js";
import buildLogin from "./authentication/login.js";
import buildUsernameAvailable from "./authentication/username_available.js";
import buildCreateGoogleUser from "./createUser/createGoogleUser.js";
import buildLoginGoogleUser from "./authentication/loginGoogleUser.js";
import buildGoogleUserExists from "./authentication/googleUserExists.js";

import buildCreateFacebookUser from "./createUser/createFacebookUser.js";
import buildLoginFacebookUser from "./authentication/loginFacebookUser.js";
import buildFacebookUserExists from "./authentication/facebookUserExists.js";

import buildCreatePost from "./posts/createPost.js";
import buildGetPostByUserId from "./posts/getPostByUserId.js";
import buildGetLatestPostsByUserId from "./posts/getLatestPostsByUserId.js";
import buildGetLatestPostsByUserIds from "./posts/getLatestPostsByUserIds.js";
import buildGetPostsByQuery from "./posts/getPostsByQuery.js";
import buildGetPostsByCategories from "./posts/getPostsByCategories.js";
import buildGetPostsByFilters from "./posts/getPostsByFilters.js";
import buildGetPostsByCategoryAndFilters from "./posts/getPostsByCategoryAndFilters.js";

import buildFollow from "./network/follow.js";
import buildUnfollow from "./network/unfollow.js";

import buildLike from "./likes/like.js";
import buildUnlike from "./likes/unLike.js";
import buildGetLikedBy from "./likes/getLikedBy.js";


export const isAuthenticated = buildIsAuthenticated(jwtController, userDb);
export const createUser = buildCreateUser(
  userDb,
  networkController,
  postsRecordController
);
export const login = buildLogin(userDb);
export const usernameAvailable = buildUsernameAvailable(userDb);
export const createGoogleUser = buildCreateGoogleUser(
  jwtController,
  userDb,
  googleAuthController,
  networkController,
  postsRecordController
);
export const loginGoogleUser = buildLoginGoogleUser(
  jwtController,
  userDb,
  googleAuthController
);
export const googleUserExists = buildGoogleUserExists(userDb);
export const createFacebookUser = buildCreateFacebookUser(
  jwtController,
  userDb,
  facebookAuthController,
  networkController,
  postsRecordController
);
export const loginFacebookUser = buildLoginFacebookUser(
  jwtController,
  userDb,
  facebookAuthController
);
export const facebookUserExists = buildFacebookUserExists(userDb);

export const createPost=buildCreatePost(postRepo,postsRecordController,likesController);
export const getPostByUserId=buildGetPostByUserId(postRepo);
export const getLatestPostsByUserId=buildGetLatestPostsByUserId(postRepo);
export const getLatestPostsByUserIds=buildGetLatestPostsByUserIds(postRepo,networkController);
export const getPostsByQuery=buildGetPostsByQuery(postRepo);
export const getPostsByFilters=buildGetPostsByFilters(postRepo);
export const getPostsByCategories=buildGetPostsByCategories(postRepo);
export const getPostsByCategoryAndFilters=buildGetPostsByCategoryAndFilters(postRepo);

export const follow=buildFollow(networkController);
export const unfollow=buildUnfollow(networkController);

export const like=buildLike(likesController);
export const unlike=buildUnlike(likesController);
export const getLikedBy=buildGetLikedBy(likesController);