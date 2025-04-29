import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/app_theme.dart';
import 'package:noya_app/core/provider.dart';
import 'package:provider/provider.dart';
import 'core/utils/routes_manager.dart';
import 'presentation/auth/forget_password/view/forget_password_screen.dart';
import 'presentation/auth/login/login_screen.dart';
import 'presentation/auth/register/view/register_screen.dart';
import 'presentation/main_screen/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var dataprovider = Provider.of<DataProvider>(context);

    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: MyTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        RouteManager.mainScreen: (context) => MainScreen(),
        RouteManager.loginScreen: (context) => const SignInScreen(),
        RouteManager.registerScreen: (context) =>  const RegisterScreen(),
        RouteManager.forgetPasswordScreen:
            (context) =>  const ForgetPasswordScreen(),
      },
      initialRoute:
          dataprovider.firebaseUser != null
              ? RouteManager.mainScreen
              : RouteManager.loginScreen,
    );
  }
}
