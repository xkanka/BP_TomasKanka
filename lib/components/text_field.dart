import 'package:flutter/material.dart';

import '../classes/main_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String Function(String?)? validator;
  final String initialValue;
  final TextInputType keyboardType;

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.initialValue = '',
    this.keyboardType = TextInputType.text,
  }) {
    controller.text = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      keyboardType: keyboardType,
      //initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: MainTheme.of(context).bodyText1.override(
              fontFamily: 'Lexend Deca',
              color: Color(0xFF95A1AC),
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
        hintText: hintText,
        hintStyle: MainTheme.of(context).bodyText1.override(
              fontFamily: 'Lexend Deca',
              color: Color(0xFF95A1AC),
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFDBE2E7),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x00000000),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x00000000),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x00000000),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
      ),
      style: MainTheme.of(context).bodyText1.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF14181B),
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
      validator: validator,
    );
  }
}
