import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class EditGoalsController {
  double? goalWeight = 0;
  DateTime? goalDate;
  TextEditingController textController = TextEditingController();
  String? Function(BuildContext, String?)? textControllerValidator;

  DocumentReference? get currentUserReference =>
      FirebaseAuth.instance.currentUser != null ? FirebaseFirestore.instance.doc('comments/${FirebaseAuth.instance.currentUser!.uid}') : null;

  Future<void> saveUserGoalData(DateTime? goalDate, String goalWeight) async {
    final usersUpdateData = {
      'goal_weight': goalWeight,
      'goal_date': goalDate,
    };
    await currentUserReference?.update(usersUpdateData);
  }
}
