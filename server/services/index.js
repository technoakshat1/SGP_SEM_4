//controllers
import {jwtController,userDb} from '../controller/index.js';
//use-cases
import buildIsAuthenticated from './authentication/isAuth.js';
import buildCreateUser from './createUser/createUser.js';
import buildLogin from './authentication/login.js';

export const isAuthenticated=buildIsAuthenticated(jwtController,userDb);
export const createUser=buildCreateUser(userDb);
export const login=buildLogin(userDb);
