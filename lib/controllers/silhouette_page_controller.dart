import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SilhouetteController {
  Future<List<Map<String, dynamic>>> fetchMeasurements() async {
    CollectionReference measurements = FirebaseFirestore.instance.collection('measurements');
    FirebaseAuth auth = FirebaseAuth.instance;

    QuerySnapshot querySnapshot = await measurements.where('uid', isEqualTo: auth.currentUser?.uid).orderBy('timestamp', descending: true).get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> fetchLastMeasurement() async {
    CollectionReference measurements = FirebaseFirestore.instance.collection('measurements');
    FirebaseAuth auth = FirebaseAuth.instance;

    QuerySnapshot querySnapshot = await measurements.where('uid', isEqualTo: auth.currentUser?.uid).orderBy('timestamp', descending: true).limit(1).get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> fetchMeasurementsWithinDuration(Duration duration) async {
    DateTime now = DateTime.now();
    DateTime startDate = now.subtract(duration);

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('measurements')
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  double calculateAverageMeasurement(List<Map<String, dynamic>> measurements, String fieldName) {
    if (measurements.isEmpty) {
      return 0.0;
    }

    double total = 0.0;
    measurements.forEach((measurement) {
      if (measurement[fieldName] != null) {
        total += measurement[fieldName];
      }
    });

    return total / measurements.length;
  }

  IconData calculateTrendIcon(List<Map<String, dynamic>> measurements, String fieldName) {
    if (measurements.length < 2) {
      return Icons.horizontal_rule; // No trend available
    }

    double totalChange = 0.0;
    for (int i = 0; i < measurements.length - 1; i++) {
      if (measurements[i][fieldName] != null && measurements[i + 1][fieldName] != null) {
        totalChange += measurements[i][fieldName] - measurements[i + 1][fieldName];
      }
    }
    double averageChange = totalChange / (measurements.length - 1);

    return averageChange > 0 ? Icons.arrow_upward : Icons.arrow_downward;
  }
}
