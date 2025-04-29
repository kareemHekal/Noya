///  Auth Intent ///
// ignore_for_file: non_constant_identifier_names, dangling_library_doc_comments

sealed class AuthIntent {}

class SignInIntent extends AuthIntent {
  final String email;
  final String userName;
  final String password;

  SignInIntent({
    required this.userName,
    required this.email,
    required this.password,
  });
}






class RegisterUserIntent extends AuthIntent {
  final String email;
  final String userName;
  final String password;

  RegisterUserIntent({
    required this.userName,
    required this.email,
    required this.password,
  });
}

class ForgetPassword extends AuthIntent {
  final String email;

  ForgetPassword({required this.email});
}

class LogoutIntent extends AuthIntent {

  LogoutIntent();
}