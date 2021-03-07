class SignUpUser {
  SignUpUser(
      {String username,
      String firstName,
      String lastName,
      String email,
      String password}) {
    this.username = username;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.password = password;
  }

  String username;
  String firstName;
  String lastName;
  String email;
  String password;
}
