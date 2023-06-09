import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_util.dart';

Future<User?> signInWithEmail(
    BuildContext context, String email, String password) async {
  final signInFunc = () => FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email.trim(), password: password);
  return signInOrCreateAccount(context, signInFunc, 'EMAIL');
}

Future<User?> createAccountWithEmail(
    BuildContext context, String email, String password) async {
  final createAccountFunc = () => FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email.trim(), password: password);
  return signInOrCreateAccount(context, createAccountFunc, 'EMAIL');
}

Future<bool> didEnterGoal() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return false; // User is not logged in
  }

  DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

  if (!userDoc.exists) {
    // Set the firstLogin flag and create the user document
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({'firstLogin': true});

    return true;
  } else {
    return userDoc['firstLogin'] ?? false;
  }
}
