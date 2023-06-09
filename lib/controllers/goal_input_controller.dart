import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class GoalInputController {
  String? goalWeight;
  DateTime goalDate = DateTime.now();
  TextEditingController goalDateController = TextEditingController();

  Future<void> saveGoal(DateTime goalDate, String goalWeight) async {
    CollectionReference usersComment = FirebaseFirestore.instance.collection('comments');
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await usersComment.where('uid', isEqualTo: auth.currentUser?.uid).limit(1).get().then((value) => {
            value.docs.forEach((element) {
              element.reference.update({
                'goalDate': goalDate,
                'goalWeight': double.parse(goalWeight),
              });
            })
          });
    } catch (e) {
      print('Failed to update a goal: $e');
    }
  }
}
