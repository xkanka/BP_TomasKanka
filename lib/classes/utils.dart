import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

export 'dart:math' show min, max;
export 'dart:typed_data' show Uint8List;
export 'dart:convert' show jsonEncode, jsonDecode;

export 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference, FirebaseFirestore;
export 'package:page_transition/page_transition.dart';

T valueOrDefault<T>(T? value, T defaultValue) => (value is String && value.isEmpty) || value == null ? defaultValue : value;

enum FormatType {
  decimal,
  percent,
  scientific,
  compact,
  compactLong,
  custom,
}

enum DecimalType {
  automatic,
  periodDecimal,
  commaDecimal,
}

DateTime get getCurrentTimestamp => DateTime.now();

extension DateTimeComparisonOperators on DateTime {
  bool operator <(DateTime other) => isBefore(other);
  bool operator >(DateTime other) => isAfter(other);
  bool operator <=(DateTime other) => this < other || isAtSameMomentAs(other);
  bool operator >=(DateTime other) => this > other || isAtSameMomentAs(other);
}

bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isWeb => kIsWeb;

extension FFTextEditingControllerExt on TextEditingController? {
  String get text => this == null ? '' : this!.text;
  set text(String newText) => this?.text = newText;
}

extension IterableExt<T> on Iterable<T> {
  List<S> mapIndexed<S>(S Function(int, T) func) => toList().asMap().map((index, value) => MapEntry(index, func(index, value))).values.toList();
}

extension StringDocRef on String {
  DocumentReference get ref => FirebaseFirestore.instance.doc(this);
}

class Utils {
  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    try {
      int.tryParse(s);
    } catch (e) {
      return false;
    }
    return true;
  }

  static bool isNumericDouble(String? s) {
    if (s == null) {
      return false;
    }
    try {
      double.tryParse(s);
    } catch (e) {
      return false;
    }
    return true;
  }
}
