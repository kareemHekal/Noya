// ignore_for_file: must_be_immutable

part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


final class LoginSuccessState extends AuthState {
  LoginSuccessState();
}

final class LoginLoadingState extends AuthState {}

final class LoginErrorState extends AuthState {
  String? message;

  LoginErrorState({required this.message});
}



///  FORGOT PASSWORD STATES  ///

final class SendEmailVerificationSuccessState extends AuthState {
  bool isSent;

  SendEmailVerificationSuccessState({required this.isSent});
}

final class SendEmailVerificationLoadingState extends AuthState {
  SendEmailVerificationLoadingState();
}

final class SendEmailVerificationErrorState extends AuthState {
  String? message;

  SendEmailVerificationErrorState({required this.message});
}



final class RegisterViewModelLoading extends AuthState {}

final class RegisterViewModelSuccess extends AuthState {}

final class RegisterViewModelFailure extends AuthState {
  final String error;

  RegisterViewModelFailure({required this.error});
}





