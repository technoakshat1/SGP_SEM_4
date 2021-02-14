export default function buildExtractToken() {
  return function extractToken(authorization) {
    if (!authorization) {
      throw new Error("authorization_empty");
    }

    if (authorization.length < 2) {
      throw new Error("authorization_empty");
    }

    let token = authorization.split(" ")[1];

    return token;
  };
}
