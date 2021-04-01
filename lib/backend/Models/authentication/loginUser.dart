class LoginUser {
  String name;
  String pass;

  LoginUser({String username, String password}) {
    this.name = username;
    this.pass = password;
  }
  
  String get username{
    return this.name;
  }

  String get password{
    return this.pass;
  }

  set password(String password) {
    this.pass=password;
  }

}
