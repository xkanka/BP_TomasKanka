import 'package:flutter/material.dart';
import 'package:kanofit/auth/auth_util.dart';
import 'package:kanofit/auth/firebase_user_provider.dart';

class FirstLoginInfoController {
  TextEditingController textController = TextEditingController();
  String? Function(BuildContext, String?)? textControllerValidator;
  TextEditingController textControllerSecond = TextEditingController();
  String? Function(BuildContext, String?)? textControllerSecondValidator;
  DateTime? goalDate;
  DateTime? birthDate;
  int? height;
  double? goalWeight;

  init() {
    textController = TextEditingController(
      text: currentUserDocument?.goalWeight.toString(),
    );
    textControllerSecond = TextEditingController(
      text: currentUserDocument?.height.toString(),
    );
    goalDate = currentUserDocument?.goalDate ?? DateTime.now().add(Duration(days: 1));
    goalDate = goalDate!.isAfter(DateTime.now().add(Duration(days: 1))) ? goalDate : DateTime.now().add(Duration(days: 1));
    birthDate = currentUserDocument?.birthDate ?? DateTime(1990);
    height = currentUserDocument?.height ?? 180;
    goalWeight = currentUserDocument?.goalWeight ?? 70;
  }

  onSavePressed() async {
    final usersUpdateData = {
      'goal_weight': textController.text,
      'goal_date': goalDate,
      'birth_date': birthDate,
      'height': textControllerSecond.text,
    };

    await currentUserReference?.update(usersUpdateData);
  }
}
