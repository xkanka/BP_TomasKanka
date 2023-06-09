import 'package:flutter/material.dart';

class ChangePasswordController {
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;

  void initState(BuildContext context) {}

  void dispose() {
    emailAddressController?.dispose();
  }
}
