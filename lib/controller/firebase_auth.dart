import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_paws/views/home_screen.dart';
import 'package:happy_paws/views/login_scren.dart';

class FBAuth {
  // Check user logged in or not
  static handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (BuildContext context, snapshot) =>
          snapshot.hasData ? HomeScreen() : const LoginScreen(),
    );
  }

  static Future<UserCredential?> loginWithGoogle() async {
    // Auth flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"])
            .signIn()
            .catchError((error) {
      return null;
    });
    if (googleUser != null) {
      // Obtain the auth details from request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create new user credential
      final userCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // Pass this google login details to firebase auth instance

      return await FirebaseAuth.instance
          .signInWithCredential(userCredential)
          .catchError((error) {
        // ignore: avoid_print
        print('Error occured: $error');
      });
    }
    return null;
  }

  // Logout Functionality

  static logOutUser() async {
    FirebaseAuth.instance.signOut();
  }
}
