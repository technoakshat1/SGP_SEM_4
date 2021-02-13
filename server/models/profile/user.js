export default function buildMakeUser() {
  return function makeUser({
    username,
    email,
    firstName,
    lastName,
    photoUrl = "",
    googleId = "",
    facebookId = "",
  }) {
    //console.log(lastName+email);
    if (!username) {
      throw new Error("Username cannot be empty");
    }

    if (username.length < 2) {
      throw new Error("Username cannot be less than 2 characters");
    }

    if (username.length > 10) {
      throw new Error("Username cannot be more than 10 characters");
    }

    if (!email) {
      throw new Error("Email cannot be empty");
    }

    if (email.length < 2) {
      throw new Error("Email cannot be less than 2 characters");
    }

    if (!firstName) {
      throw new Error("First cannot be empty");
    }

    if (firstName.length < 2) {
      throw new Error("FirstName cannot be less than 2 characters");
    }

    if (firstName.length > 10) {
      throw new Error("FirstName cannot be greater than 10 characters");
    }

    if (!lastName) {
      throw new Error("LastName cannot be empty");
    }

    if (lastName.length < 2) {
      throw new Error("LastName cannot be less than 2 characters");
    }

    if (lastName.length > 10) {
      throw new Error("LastName cannot be greater than 2 characters");
    }

    return Object.freeze({
      username,
      email,
      firstName,
      lastName,
      photoUrl,
      googleId,
      facebookId,
    });
  };
}
