import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeasureData {
  MeasureData(this.date, this.value);

  final String date;
  final double value;
}

class StatisticsController {
  String selectedMeasurementField = 'currentWeight';
  List<Map<String, dynamic>> measurements = [];

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

  List<MeasureData> getChartData() {
    return measurements
        .map((measurement) => MeasureData(DateFormat.MMM().format(measurement['timestamp'].toDate()).toString(),
            measurement[selectedMeasurementField] != null ? double.tryParse(measurement[selectedMeasurementField].toString()) ?? 0.0 : 0.0))
        .toList();
  }
}
