export default function buildLoginUser() {
  return function loginUser({ username, password }) {
    if (!username) {
      throw new Error("username_empty");
    }

    if (!password) {
      throw new Error("password_empty");
    }

    return Object.freeze({
      username,
      password,
    });
  };
}
