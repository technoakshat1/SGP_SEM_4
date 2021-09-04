export default function buildSetGoogleUsername(userDb, jwtController) {
  return async function setGoogleUsername(username, googleId, token) {
    try {
      let tGoogleId = await jwtController.verify(token);

      if (tGoogleId === googleId) {
        let updated = await userDb.findUserAndUpdate(
          { googleId: googleId },
          { username: username }
        );

        if (updated) {
          let token = await jwtController.sign(username);
          if (token) {
            return { updated: true, token: token };
          }
        }
      }

      return { updated: false, token: null };
    } catch (err) {
      console.error(err);
      return { updated: false, token: null };
    }
  };
}
