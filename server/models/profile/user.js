export default function buildMakeUser() {
  return function makeUser({
    username,
    email,
    firstName,
    lastName,
    photoUrl = "",
    googleId = "",
    facebookId = "",
    postsRecordId,
    networkRepoId,
  }) {
    //console.log(lastName+email);
    if (!username) {
      throw new Error("username_empty");
    }

    if (username.length < 2) {
      throw new Error("username_empty");
    }

    if (username.length > 10) {
      throw new Error("username_outOfRange");
    }

    if (!email) {
      throw new Error("email_empty");
    }

    if (email.length < 2) {
      throw new Error("email_empty");
    }

    if (!firstName) {
      throw new Error("firstname_empty");
    }

    if (firstName.length < 2) {
      throw new Error("firstname_empty");
    }

    if (firstName.length > 10) {
      throw new Error("firstname_outOfRange");
    }

    if (!lastName) {
      throw new Error("lastname_empty");
    }

    if (lastName.length < 2) {
      throw new Error("lastname_empty");
    }

    if (lastName.length > 10) {
      throw new Error("lastname_outOfRange");
    }

    let displayName=firstName+" "+lastName;

    return Object({
      username,
      email,
      displayName,
      photoUrl,
      googleId,
      facebookId,
      postsRecordId,
      networkRepoId,
    });
  };
}
