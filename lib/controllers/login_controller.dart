import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kanofit/auth/email_auth.dart';
import 'package:kanofit/models/users_record.dart';
import 'package:kanofit/views/first_login_info.dart';

import '../main.dart';

class LoginController {
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;

  TextEditingController? passwordController;
  bool passwordVisibility = false;
  String? Function(BuildContext, String?)? passwordControllerValidator;

  LoginController();

  void dispose() {
    emailAddressController?.dispose();
    passwordController?.dispose();
  }

  Future<void> login(BuildContext context) async {
    if (emailAddressController == null || passwordController == null) {
      return;
    }

    final user = await signInWithEmail(
      context,
      this.emailAddressController!.text,
      this.passwordController!.text,
    );
    if (user == null) {
      return;
    }

    final record = await UsersRecord.getDocument(FirebaseFirestore.instance.doc('comments/${user.uid}')).first;
    final hasGoalInfo = record.goalDate != null && record.goalWeight != null && record.birthDate != null && record.height != null;

    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => hasGoalInfo ? NavBarPage(initialPage: 'silhouette') : FirstLoginInfo(),
      ),
      (r) => false,
    );
  }
}
