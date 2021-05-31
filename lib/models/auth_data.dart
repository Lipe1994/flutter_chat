import 'dart:io';

enum AuthMode
{
  LOGIN,
  SIGNUP
}

class AuthData{
  String name;
  String email;
  String passsword;
  File file;
  AuthMode _mode = AuthMode.LOGIN;
  bool get isLogin {
    return _mode == AuthMode.LOGIN;
  }
  bool get isSignup {
    return _mode == AuthMode.SIGNUP;
  }

  void togleMode(){
    _mode = _mode == AuthMode.LOGIN ?  AuthMode.SIGNUP : AuthMode.LOGIN ;
  }
}

