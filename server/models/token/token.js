export default function buildExtractToken() {
  return function extractToken(authorization) {
    if (!authorization) {
      throw new Error("Authorization cannot be empty");
    }

    if (authorization.length < 2) {
      throw new Error("Authorization cannot be less than 2 characters");
    }

    let token = authorization.split(" ")[1];

    return token;
  };
}
