export default function buildUsernameAvailable(userDb) {
  return async function usernameAvailable(username) {
    if (username) {
      let isAvailable = await userDb.exists(username);
      return { isAvailable };
    }
    return {isAvailable: false}
  };
}
