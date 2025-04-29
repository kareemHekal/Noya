import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:noya_app/data/models/user%20model.dart';
import 'package:noya_app/firebase/firebasefunctions.dart';

class DataProvider extends ChangeNotifier {
  Usermodel? usermodel;
  User? firebaseUser;

  DataProvider(){
    firebaseUser =FirebaseAuth.instance.currentUser;
    if (firebaseUser != null){
      initUser();
    }
  }
  initUser() async{
    usermodel= await FirebaseFunctions.ReadUserData();
    notifyListeners();
  }

}
