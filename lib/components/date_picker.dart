import 'package:flutter/material.dart';

import '../classes/main_theme.dart';

class CustomDatePicker extends StatefulWidget {
  final String labelText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime?)? onDateChanged;

  CustomDatePicker({
    required this.labelText,
    this.initialDate,
    this.onDateChanged,
    this.firstDate,
    this.lastDate,
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? goalDate;
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String _labelText = '';

  @override
  void initState() {
    super.initState();
    _labelText = widget.labelText;
    goalDate = widget.initialDate;
    _controller.text = goalDate != null ? '${goalDate!.day}.${goalDate!.month}.${goalDate!.year}' : '';
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _selectDate(context);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode()); // Add this line
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: goalDate ?? DateTime(1990),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2005),
    );
    if (picked != null && picked != goalDate) {
      setState(() {
        goalDate = picked;
        _controller.text = '${goalDate!.day}.${goalDate!.month}.${goalDate!.year}';
        widget.onDateChanged?.call(goalDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: _controller,
      decoration: InputDecoration(
        labelText: _labelText,
        labelStyle: MainTheme.of(context).bodyText1.override(
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
      readOnly: true,
      style: TextStyle(
        fontFamily: 'Lexend Deca',
        color: Color(0xFF2B343A),
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
