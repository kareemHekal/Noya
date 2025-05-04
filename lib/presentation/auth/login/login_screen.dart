import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/resuable_comp/validator.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/routes_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/presentation/auth/view_model/cubit/auth_cubit.dart';
import 'package:noya_app/presentation/auth/view_model/cubit/auth_intent.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void _validateAndLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().doIntent(
        SignInIntent(
          email: emailController.text,
          password: passwordController.text,
          userName: userNameController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, RouteManager.mainScreen);
            toastMessage(
              message: AppStrings.loginSuccessfully,
              tybeMessage: TybeMessage.positive,
            );
          }
          if (state is LoginErrorState) {
            toastMessage(
              message: state.message.toString(),
              tybeMessage: TybeMessage.negative,
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: ColorManager.mutedSageGreen,
                                  thickness: 2,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset("assets/images/logoo.png"),
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  color: ColorManager.mutedSageGreen,
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            AppStrings.hello,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.mutedSageGreen,
                            ),
                          ),
                          Text(
                            AppStrings.welcomeBack,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.white40,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey, // Attach the form key here
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    context.locale == const Locale('en')
                                        ? const EdgeInsets.only(left: 20)
                                        : const EdgeInsets.only(right: 20),
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      validator: Validator.email,
                                      controller: emailController,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        hintText: AppStrings.emailHint,
                                      ),
                                    ),
                                    const SizedBox(height: 35),
                                    TextFormField(
                                      validator: Validator.password,
                                      controller: passwordController,
                                      obscureText: !_isPasswordVisible,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        hintText: AppStrings.passwordHint,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isPasswordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isPasswordVisible =
                                                  !_isPasswordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              ),
                              Column(
                                spacing: 10,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteManager.forgetPasswordScreen,
                                      );
                                    },
                                    child: Text(
                                      AppStrings.forgotPassword,
                                      style: const TextStyle(
                                        color: ColorManager.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: MyButton(
                                            label:
                                                state is LoginLoadingState
                                                    ? AppStrings.loggingIn
                                                    : AppStrings.logIn,
                                            // Show loading text
                                            onPressed:
                                                state is LoginLoadingState
                                                    ? null
                                                    : () {
                                                      _validateAndLogin(
                                                        context,
                                                      );
                                                    },
                                            isLoading:
                                                state is LoginLoadingState,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        RouteManager.registerScreen,
                                      );
                                    },
                                    child: Text(
                                      AppStrings.signUp,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
