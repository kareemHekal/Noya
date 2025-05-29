import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noya_app/data/models/user%20model.dart';

class FirebaseFunctions {
  // =============================== Authentication Functions ===============================

  /// Creates a new account in Firebase and saves the user data
  static createAccount({
    required String emailAddress,
    required String password,
    required String phoneNumber,
    required Function onSucsses,
    required Function onError,
    required String firstName,
    required String lastName,
    String? userAddress,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      credential.user?.sendEmailVerification();
      Usermodel user = Usermodel(
        userAddress: userAddress,
        phoneNumber: phoneNumber,
        id: credential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        email: emailAddress,
      );
      addUser(user);
      onSucsses();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
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

  /// Changes the user's password after re-authenticating with the current password
  static changePassword({
    required String currentPassword,
    required String newPassword,
    required Function onSuccess,
    required Function(String? errorMessage) onError,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.email == null) {
        onError('User not logged in');
        return;
      }

      // Re-authenticate the user
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        onError('Current password is incorrect');
      } else if (e.code == 'weak-password') {
        onError('The new password is too weak');
      } else if (e.code == 'requires-recent-login') {
        onError('Please log in again and try');
      } else {
        onError(e.message);
      }
    } catch (e) {
      onError('Something went wrong: ${e.toString()}');
    }
  }
}
