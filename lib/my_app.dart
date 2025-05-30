import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:lottie/lottie.dart';
import 'package:noya_app/core/app_theme.dart';
import 'package:noya_app/core/provider.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'core/utils/routes_manager.dart';
import 'presentation/auth/forget_password/view/forget_password_screen.dart';
import 'presentation/auth/login/login_screen.dart';
import 'presentation/auth/register/view/register_screen.dart';
import 'presentation/main_screen/main_screen.dart';

class MyApp extends StatelessWidget {
  final bool isLogged;

  const MyApp({required this.isLogged, super.key});

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    return MaterialApp(
      themeMode: dataProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      routes: {
        RouteManager.mainScreen: (context) => const MainScreen(),
        RouteManager.loginScreen: (context) => const SignInScreen(),
        RouteManager.registerScreen: (context) => const RegisterScreen(),
        RouteManager.forgetPasswordScreen:
            (context) => const ForgetPasswordScreen(),
      },
      home: AnimatedSplashScreen(
        animationDuration: const Duration(seconds: 1),
        duration: 3000,
        splash: Image.asset(
          'assets/images/my_animation.gif',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        nextScreen:
            isLogged == true ? const MainScreen() : const SignInScreen(),

        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        backgroundColor: ColorManager.lightSand,
      ),
    );
  }
}
