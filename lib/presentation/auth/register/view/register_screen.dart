// ignore_for_file: library_private_types_in_public_api
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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> formKey = GlobalKey();
  String? selectedGender;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _validateAndRegister(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().doIntent(
        RegisterUserIntent(
          phoneNumber: phoneController.text,
          email: emailController.text,
          password: passwordController.text,
          userName: firstNameController.text,
        ),
      );
      print(
        'Registering user: ${firstNameController.text}, ${emailController.text}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterViewModelSuccess) {
            Navigator.pushReplacementNamed(context, RouteManager.loginScreen);
            toastMessage(
              message: AppStrings.createdAccountSuccessfully,
              tybeMessage: TybeMessage.positive,
            );
            toastMessage(
              message: AppStrings.verificationEmailSent,
              tybeMessage: TybeMessage.positive,
            );
          }
          if (state is RegisterViewModelFailure) {
            toastMessage(
              message: state.error.toString(),
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
                            AppStrings.welcomeTitle,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.white70,
                            ),
                          ),
                          Text(
                            AppStrings.createAccountTitle,
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
                          // rounded corners for a smooth look
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              // light shadow
                              spreadRadius: 2,
                              // how much the shadow will spread
                              blurRadius: 8,
                              // how blurry the shadow is
                              offset: const Offset(
                                0,
                                4,
                              ), // position of the shadow
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
                                      controller: firstNameController,
                                      validator: Validator.firstName,
                                      decoration: InputDecoration(
                                        hintText: AppStrings.firstNameHint,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: lastNameController,
                                      validator: Validator.lastName,
                                      decoration: InputDecoration(
                                        hintText: AppStrings.lastNameHint,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: emailController,
                                      validator: Validator.email,
                                      decoration: InputDecoration(
                                        hintText: AppStrings.emailHint,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: passwordController,
                                      validator: Validator.password,
                                      obscureText: !_isPasswordVisible,
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
                                    TextFormField(
                                      controller: rePasswordController,
                                      validator: (value) {
                                        if (value != passwordController.text) {
                                          return AppStrings.passwordsDoNotMatch;
                                        }
                                        return null;
                                      },
                                      obscureText: !_isPasswordVisible,
                                      decoration: InputDecoration(
                                        hintText:
                                            AppStrings.reenterPasswordHint,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: phoneController,
                                      validator: Validator.phoneNumber,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(),
                                      decoration: InputDecoration(
                                        hintText: AppStrings.phoneNumberHint,
                                      ),
                                    ),

                                    const SizedBox(height: 15),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: MyButton(
                                            label:
                                                state is RegisterViewModelLoading
                                                    ? AppStrings
                                                        .creatingAccountLoading
                                                    : AppStrings.signUp,
                                            onPressed:
                                                state is RegisterViewModelLoading
                                                    ? null
                                                    : () {
                                                      _validateAndRegister(
                                                        context,
                                                      );
                                                    },
                                            isLoading:
                                                state
                                                    is RegisterViewModelLoading,
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          RouteManager.loginScreen,
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            AppStrings.alreadyHaveAccount,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorManager.white70,
                                              // Lighter color
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            AppStrings.signInButton,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorManager.black,
                                              // Darker color for emphasis
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
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
