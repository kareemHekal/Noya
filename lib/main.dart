import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/provider.dart';
import 'package:noya_app/firebase/firebase_options.dart';
import 'package:noya_app/presentation/timer/view_model/cubit.dart';
import 'package:provider/provider.dart';
import 'core/api/api_manager.dart';
import 'core/di/di.dart';
import 'core/observer/bloc_observer.dart';
import 'my_app.dart';
import 'presentation/auth/view_model/cubit/auth_cubit.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  ApiManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authCubit = getIt<AuthCubit>();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DataProvider()),
          BlocProvider<AuthCubit>(create: (context) => authCubit),
          BlocProvider<TimerCubit>(create: (context) => TimerCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
  FlutterNativeSplash.remove();

}
