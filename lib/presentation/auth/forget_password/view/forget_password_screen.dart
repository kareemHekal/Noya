import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/validator.dart';
import 'package:noya_app/core/utils/routes_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/presentation/auth/view_model/cubit/auth_cubit.dart';
import 'package:noya_app/presentation/auth/view_model/cubit/auth_intent.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().doIntent(
        ForgetPassword(email: emailController.text),
      );
      print('Password reset request for email: ${emailController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true),
      backgroundColor: ColorManager.white10,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SendEmailVerificationSuccessState) {
            Navigator.pushReplacementNamed(context, RouteManager.loginScreen);
            toastMessage(
              message: AppStrings.messageSentSuccessfully,
              tybeMessage: TybeMessage.positive,
            );
            toastMessage(
              message:
              AppStrings.resetPasswordInstruction,
              tybeMessage: TybeMessage.positive,
            );
          }
          if (state is SendEmailVerificationErrorState) {
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
                                  color: ColorManager.white60,
                                  thickness: 2,
                                ),
                              ),
                              Expanded(
                                child: Image.asset("assets/images/logo.png"),
                              ),
                              const Expanded(
                                child: Divider(
                                  color: ColorManager.white60,
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ),
                           Text(
                            AppStrings.forgotYourPassword,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.black,
                            ),
                          ),
                           Text(
                             AppStrings.enterEmailToResetPassword,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.white70,
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
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: emailController,
                                      validator: Validator.email,
                                      decoration:  InputDecoration(
                                        hintText: AppStrings.emailHint,
                                      ),
                                      cursorColor: Colors.black,
                                    ),
                                    const SizedBox(height: 35),
                                  ],
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
                                            state
                                                    is SendEmailVerificationLoadingState
                                                ? AppStrings.sendingMessage
                                                : AppStrings.sendButton, // Show loading text
                                        onPressed:
                                            state
                                                    is SendEmailVerificationLoadingState
                                                ? null
                                                : () {
                                                  _validateAndSubmit();
                                                },
                                        isLoading:
                                            state
                                                is SendEmailVerificationLoadingState,
                                      ),
                                    ),
                                  ],
                                ),
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
