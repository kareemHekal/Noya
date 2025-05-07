  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/foundation.dart';
  import 'package:noya_app/data/models/user%20model.dart';
  import 'package:noya_app/firebase/firebasefunctions.dart';
  import 'shared_prefrnces.dart';

  class DataProvider extends ChangeNotifier {
    Usermodel? usermodel;
    User? firebaseUser;
    bool _isDarkMode = true;
    String _baseUrl = "https://noya-backend.onrender.com";

    String get baseUrl => _baseUrl;

    bool get isDarkMode => _isDarkMode;

    DataProvider() {
      _loadSettings();
      _init();
    }

    void _init() {
      Future.microtask(() async {
        firebaseUser = FirebaseAuth.instance.currentUser;
        if (firebaseUser != null) {
          print("Firebase user found: ${firebaseUser!.email}");
          await initUser();
        } else {
          print("Firebase user is null");
        }
      });
    }

    Future<void> _loadSettings() async {
      final savedUrl = await SharedPrefsService.getBaseUrl();
      final savedDarkMode = await SharedPrefsService.getDarkMode();

      if (savedUrl != null) _baseUrl = savedUrl;
      if (savedDarkMode != null) _isDarkMode = savedDarkMode;

      notifyListeners();
    }

    Future<void> changeBaseUrl(String url) async {
      _baseUrl = url;
      await SharedPrefsService.saveBaseUrl(url);
      notifyListeners();
    }

    Future<void> toggleTheme() async {
      _isDarkMode = !_isDarkMode;
      await SharedPrefsService.saveDarkMode(_isDarkMode);
      notifyListeners();
    }

    Future<void> initUser() async {
      print("Fetching user data...");
      usermodel = await FirebaseFunctions.ReadUserData();
      print("User data fetched: $usermodel");
      notifyListeners();
    }
  }
