import {loginUser} from '../../models/index.js';
export default function buildLogin(userDb){
  return async function login(httpBody){
        let user=loginUser({username:httpBody.username,password:httpBody.password});
        
        let token=await userDb.login(user);

        return token;
  }
}