import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noya_app/data/models/user%20model.dart';

class FirebaseFunctions {
  // =============================== Authentication Functions ===============================

  /// Creates a new account in Firebase and saves the user data
  static createAccount(
      String emailAddress,
      String password, {
        required Function onSucsses,
        required Function onEror,
        required String Username,
      }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      credential.user?.sendEmailVerification();
      Usermodel user = Usermodel(
        id: credential.user!.uid,
        name: Username,
        email: emailAddress,
      );
      addUser(user);
      onSucsses();
    } on FirebaseAuthException catch (e) {
      onEror(e.message);
    }
  }

  /// Logs in the user and verifies their email
  static login({
    required String emailAddress,
    required String password,
    required String Username,
    required Function onSucsses,
    required Function onEror,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (credential.user?.emailVerified == true) {
        onSucsses();
      }
    } on FirebaseAuthException catch (e) {
      onEror(e.message);
    }
  }

  /// Resets the user's password and sends a reset email
  static passwordReset({
    required String emailAddress,
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    }
  }

  /// Reads user data from the `users` collection
  static Future<Usermodel?> ReadUserData() async {
    var collection = getUsersCollection();
    DocumentSnapshot<Usermodel> docUser =
    await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docUser.data();
  }

  /// Adds a new user to the `users` collection
  static addUser(Usermodel user) {
    var collection = getUsersCollection();
    var docref = collection.doc(user.id);
    docref.set(user);
  }

  /// Returns a reference to the `users` collection
  static CollectionReference<Usermodel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<Usermodel>(
      fromFirestore: (snapshot, _) => Usermodel.fromJson(snapshot.data()!),
      toFirestore: (value, _) => value.tojson(),
    );
  }
}
