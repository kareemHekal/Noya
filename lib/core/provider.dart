import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:noya_app/data/models/user%20model.dart';
import 'package:noya_app/firebase/firebasefunctions.dart';
import 'shared_prefrnces.dart';
class DataProvider extends ChangeNotifier {
  Usermodel? usermodel;
  User? firebaseUser;

  String _baseUrl = "https://noya-backend.onrender.com";
  String get baseUrl => _baseUrl;

  DataProvider() {
    _loadBaseUrl();
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

  void _loadBaseUrl() async {
    final savedUrl = await SharedPrefsService.getBaseUrl();
    if (savedUrl != null) {
      _baseUrl = savedUrl;
      notifyListeners();
    }
  }

  Future<void> changeBaseUrl(String url) async {
    _baseUrl = url;
    await SharedPrefsService.saveBaseUrl(url);
    notifyListeners();
  }

  Future<void> initUser() async {
    print("Fetching user data...");
    usermodel = await FirebaseFunctions.ReadUserData();
    print("User data fetched: $usermodel");
    notifyListeners();
  }
}
