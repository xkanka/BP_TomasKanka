import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanofit/models/comments_record.dart';

import '../classes/backend.dart';
import 'firebase_user_provider.dart';

export 'email_auth.dart';

Future<User?> signInOrCreateAccount(
  BuildContext context,
  Future<UserCredential?> Function() signInFunc,
  String authProvider,
) async {
  try {
    final userCredential = await signInFunc();
    if (userCredential?.user != null) {
      await maybeCreateUser(userCredential!.user!);
    }
    return userCredential?.user;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.message!}')),
    );
    return null;
  }
}

Future signOut() {
  return FirebaseAuth.instance.signOut();
}

Future resetPassword({required String email, required BuildContext context}) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.message!}')),
    );
    return null;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Požiadavka na zmenu hesla bola odoslaná na email')),
  );
}

String get currentUserEmail => currentUserDocument?.email ?? currentUser?.user?.email ?? '';

String get currentUserUid => currentUser?.user?.uid ?? '';

String get currentUserDisplayName => currentUserDocument?.displayName ?? currentUser?.user?.displayName ?? '';

String get currentUserPhoto => currentUser?.user?.photoURL ?? '';

DocumentReference? get currentUserReference => currentUser?.user != null ? UserDataRecord.collection.doc(currentUser!.user!.uid) : null;

final authenticatedUserStream = FirebaseAuth.instance.authStateChanges().asBroadcastStream();

class AuthUserStreamWidget extends StatelessWidget {
  const AuthUserStreamWidget({Key? key, required this.builder}) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: authenticatedUserStream,
        builder: (context, _) => builder(context),
      );
}
