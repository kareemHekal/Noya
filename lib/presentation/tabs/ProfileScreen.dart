import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/routes_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.green,

    body: Center(child: TextButton(onPressed: (){
      FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, RouteManager.loginScreen, (route) => false);
    }, child: Text("Logout"),),),
    );
  }
}
