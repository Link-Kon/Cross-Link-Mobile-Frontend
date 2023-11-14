import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Once signed in, return the UserCredential
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOutWithGoogle() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> reAuthenticate() async {
    Timer.periodic(const Duration(minutes: 58), (timer) async { //Every hour
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        debugPrint('User is currently signed out');

      } else {
        GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();
        GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
        String accessToken = googleAuth.accessToken!;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: accessToken,
        );
        await user.reauthenticateWithCredential(credential);

        debugPrint('User reAuthenticated!');
      }
    });
  }

}