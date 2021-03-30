//controllers
import {jwtController,userDb} from '../controller/index.js';
//use-cases
import buildIsAuthenticated from './authentication/isAuth.js';
import buildCreateUser from './createUser/createUser.js';
import buildLogin from './authentication/login.js';
import buildUsernameAvailable from './authentication/username_available.js';
import buildCreateGoogleUser from './createUser/createGoogleUser.js';
import buildLoginGoogleUser from './authentication/loginGoogleUser.js';
import buildGoogleUserExists from './authentication/googleUserExists.js';

import buildCreateFacebookUser from './createUser/createFacebookUser.js';
import buildLoginFacebookUser from './authentication/loginFacebookUser.js';
import buildFacebookUserExists from './authentication/facebookUserExists.js';

import buildRefreshAccessTokens from './authentication/refreshAccessTokens.js';
import buildRefreshFacebookAccessTokens from './authentication/refreshFacebookAccessTokens.js'

export const isAuthenticated=buildIsAuthenticated(jwtController,userDb);
export const createUser=buildCreateUser(userDb);
export const login=buildLogin(userDb);
export const usernameAvailable=buildUsernameAvailable(userDb);
export const createGoogleUser=buildCreateGoogleUser(jwtController,userDb);
export const loginGoogleUser=buildLoginGoogleUser(jwtController,userDb);
export const googleUserExists=buildGoogleUserExists(userDb);
export const createFacebookUser=buildCreateFacebookUser(jwtController,userDb);
export const loginFacebookUser=buildLoginFacebookUser(jwtController,userDb);
export const facebookUserExists=buildFacebookUserExists(userDb);

export const refreshAccessTokens=buildRefreshAccessTokens(jwtController,userDb);

export const refreshFacebookAccessTokens=buildRefreshFacebookAccessTokens(jwtController,userDb);