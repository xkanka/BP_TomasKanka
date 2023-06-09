import 'package:flutter/material.dart';

class RegisterPageController {
  TextEditingController? inputNormalController;
  String? Function(BuildContext, String?)? inputNormalControllerValidator;

  TextEditingController? passwordTextController;
  bool passwordVisibility1 = false;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;

  TextEditingController? confirmPasswordTextController;
  bool passwordVisibility2 = false;
  String? Function(BuildContext, String?)? confirmPasswordTextControllerValidator;

  void dispose() {
    inputNormalController?.dispose();
    passwordTextController?.dispose();
    confirmPasswordTextController?.dispose();
  }
}
