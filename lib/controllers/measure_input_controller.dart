import 'package:flutter/material.dart';
import 'package:kanofit/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MeasureInputController {
  String? currentWeight;
  String? handCir;
  String? thighCir;
  String? beltCir;
  String? chestCir;
  String? calfCir;

  Future<void> saveMeasurement(BuildContext context) async {
    CollectionReference measurements = FirebaseFirestore.instance.collection('measurements');
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await measurements.add({
        'uid': auth.currentUser?.uid,
        'currentWeight': double.parse(currentWeight!),
        'handCir': double.parse(handCir!),
        'thighCir': double.parse(thighCir!),
        'beltCir': double.parse(beltCir!),
        'chestCir': double.parse(chestCir!),
        'calfCir': double.parse(calfCir!),
        'timestamp': DateTime.now(),
      });

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => NavBarPage(initialPage: 'silhouette'),
        ),
        (r) => false,
      );
    } catch (e) {
      print('Failed to add user measurements: $e');
    }
  }
}
