// ignore_for_file: unnecessary_import, non_constant_identifier_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noya_app/firebase/firebasefunctions.dart';
import 'auth_intent.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  @factoryMethod
  String? startRoute;

  AuthCubit() : super(AuthInitial());

  void doIntent(AuthIntent authIntent) {
    switch (authIntent) {
      case SignInIntent():
        _SignIn(intent: authIntent);
        break;
      case ForgetPassword():
        _ForgetPassword(intent: authIntent);
        break;
      case RegisterUserIntent():
        _register(intent: authIntent);
        break;
      case LogoutIntent():
        FirebaseAuth.instance.signOut();
        break;
    }
  }

  static AuthCubit get(context) => BlocProvider.of(context);

  bool? isguest = false;

  _SignIn({required SignInIntent intent}) async {
    emit(LoginLoadingState());
    FirebaseFunctions.login(
      Username: intent.userName,
      emailAddress: intent.email,
      password: intent.password,
      onEror: (eror) => emit(LoginErrorState(message: eror)),
      onSucsses: () => emit(LoginSuccessState()),
    );
  }

  _ForgetPassword({required ForgetPassword intent}) async {
    emit(SendEmailVerificationLoadingState());
    FirebaseFunctions.passwordReset(
      emailAddress: intent.email,
      onError: (error) => emit(SendEmailVerificationErrorState(message: error)),
      onSuccess: () => emit(SendEmailVerificationSuccessState(isSent: true)),
    );
  }

  _register({required RegisterUserIntent intent}) async {
    emit(RegisterViewModelLoading());
    FirebaseFunctions.createAccount(
      phoneNumber: intent.phoneNumber,
      emailAddress: intent.email,
      password: intent.password,
      Username: intent.userName,
      onEror: (eror) => emit(RegisterViewModelFailure(error: eror)),
      onSucsses: () => emit(RegisterViewModelSuccess()),
    );
  }
}
