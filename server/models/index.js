import buildMakeUser from "./profile/user.js";
import buildExtractToken from "./token/token.js";
import buildLoginUser from "./profile/login_user.js";

export const makeUser = buildMakeUser();
export const extractToken = buildExtractToken();
export const loginUser = buildLoginUser();

export default function models() {
  return Object.freeze({
    makeUser,
    extractToken,
    loginUser,
  });
}
