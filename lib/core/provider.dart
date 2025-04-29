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
    firebaseUser = FirebaseAuth.instance.currentUser;
    _loadBaseUrl();
    if (firebaseUser != null) {
      initUser();
    }
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

  initUser() async {
    usermodel = await FirebaseFunctions.ReadUserData();
    notifyListeners();
  }
}
