//controllers
import {jwtController,userDb,googleAuthController,facebookAuthController} from '../controller/index.js';
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

export const isAuthenticated=buildIsAuthenticated(jwtController,userDb);
export const createUser=buildCreateUser(userDb);
export const login=buildLogin(userDb);
export const usernameAvailable=buildUsernameAvailable(userDb);
export const createGoogleUser=buildCreateGoogleUser(jwtController,userDb,googleAuthController);
export const loginGoogleUser=buildLoginGoogleUser(jwtController,userDb,googleAuthController);
export const googleUserExists=buildGoogleUserExists(userDb);
export const createFacebookUser=buildCreateFacebookUser(jwtController,userDb,facebookAuthController);
export const loginFacebookUser=buildLoginFacebookUser(jwtController,userDb,facebookAuthController);
export const facebookUserExists=buildFacebookUserExists(userDb);