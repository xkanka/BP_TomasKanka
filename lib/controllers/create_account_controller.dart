import 'package:flutter/material.dart';

class CreateAccountController {
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  TextEditingController? passwordController;
  bool passwordVisibility = false;
  String? Function(BuildContext, String?)? passwordControllerValidator;

  void dispose() {
    emailAddressController?.dispose();
    passwordController?.dispose();
  }
}
