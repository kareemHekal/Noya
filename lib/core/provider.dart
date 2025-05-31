import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:noya_app/data/models/user%20model.dart';
import 'package:noya_app/firebase/firebasefunctions.dart';

import 'shared_prefrnces.dart';

class DataProvider extends ChangeNotifier {
  Usermodel? userModel;
  User? firebaseUser;
  bool _isDarkMode = true;
  bool isLogged = false;
  String _baseUrl = "https://noya-backend.onrender.com";

  String get baseUrl => _baseUrl;

  bool get isDarkMode => _isDarkMode;

  DataProvider() {
    _loadSettings();
    _init();
  }

  void setLogged(bool value) {
    isLogged = value;
    SharedPrefsService.saveIsLogged(value); // <-- Save to SharedPreferences
    notifyListeners();
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

  void updateUserModel({
    String? firstName,
    String? email,
    String? address,
    String? phoneNumber,
    String? lastName,
  }) {
    userModel!.firstName = firstName ?? userModel!.firstName;
    userModel!.userAddress = address ?? userModel!.userAddress;
    userModel!.email = email ?? userModel!.email;
    userModel!.phoneNumber = phoneNumber ?? userModel!.phoneNumber;
    userModel!.lastName = lastName ?? userModel!.lastName;
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
    userModel = await FirebaseFunctions.ReadUserData();
    print("User data fetched: $userModel");
    notifyListeners();
  }
}
