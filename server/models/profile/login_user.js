export default function buildLoginUser() {
  return function loginUser({ username, password }) {
    if (!username) {
      throw new Error("Username cannot be empty");
    }

    if (!password) {
      throw new Error("Password cannot be empty");
    }

    return Object.freeze({
      username,
      password,
    });
  };
}
