import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanofit/models/comments_record.dart';
import 'package:kanofit/models/users_record.dart';
import 'package:kanofit/classes/main_theme.dart';
import 'package:kanofit/importers/CaloriesImporter.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kanofit/importers/SamsungCaloriesImporter.dart';

class KcalCalculator extends StatefulWidget {
  KcalCalculator({Key? key}) : super(key: key);

  @override
  _KcalCalculatorState createState() => _KcalCalculatorState();
}

class _KcalCalculatorState extends State<KcalCalculator> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController caloriesTextController = new TextEditingController();
  TextEditingController intakeTextController = new TextEditingController();

  double caloriesDifference = 0;
  List<Exercise> exerciseList = [];

  Future<Map<String, dynamic>> fetchLastMeasurement() async {
    CollectionReference measurements = FirebaseFirestore.instance.collection('measurements');
    FirebaseAuth auth = FirebaseAuth.instance;

    QuerySnapshot querySnapshot = await measurements.where('uid', isEqualTo: auth.currentUser?.uid).orderBy('timestamp', descending: true).limit(1).get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList()[0];
  }

  Future<void> runCalculation() async {
    Map<String, dynamic> lastMeasurement = await fetchLastMeasurement();
    UserDataRecord? userRecord = await UserDataRecord.getDocumentOnce(UserDataRecord.collection.doc(FirebaseAuth.instance.currentUser?.uid));

    double calorieIntake = double.tryParse(intakeTextController.text) ?? 0;
    int caloriesBurned = int.tryParse(caloriesTextController.text) ?? 0;

    CaloriesController caloriesController = CaloriesController();
    CalculationResult result = caloriesController.calculate(userRecord, lastMeasurement, calorieIntake, caloriesBurned);

    List<Exercise> exerciseTimes = caloriesController.getExerciseTimes(result);

    print(exerciseTimes);

    setState(() {
      caloriesDifference = result.caloriesDifference;
      exerciseList = exerciseTimes;
    });
  }

  Widget buildResults(BuildContext context) {
    if (exerciseList.length == 0) {
      return Container();
    }

    return (Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(text: 'Na dosiahnutie cieľovej váhy v stanovenom čase potrebuješ oproti tvojmu aktuálnemu priemeru denne prijať o ', children: [
            TextSpan(
              text: caloriesDifference.toStringAsFixed(0),
              style: TextStyle(fontWeight: FontWeight.bold, color: MainTheme.of(context).primaryColor),
            ),
            TextSpan(
              text: ' kcal menej.',
            )
          ])),
          SizedBox(height: 6),
          Text(
            'Tento rozdiel v kcal môžeš dosiahnuť aj:',
          ),
          //Render list of exercise times after calculation
          ListView.builder(
            shrinkWrap: true,
            itemCount: exerciseList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(exerciseList[index].name),
                subtitle: Text('${(exerciseList[index].time * 60).toStringAsFixed(0)} minút denne'),
              );
            },
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder<UsersRecord?>(
            stream: UsersRecord.getDocument(FirebaseFirestore.instance.doc('comments/${FirebaseAuth.instance.currentUser!.uid}')),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              UsersRecord? user = snapshot.data;

              return FutureBuilder<Map<String, dynamic>?>(
                  future: fetchLastMeasurement(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 24),
                                  Text('Najprv musíš zadať aspoň jedno meranie'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return Form(
                        key: _formKey,
                        child: new ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                "Zisti akú aktivitu by si mal vykonávať, aby si dosiahol svojich stanovených cieľov! Zadaj svoj priemerný denný príjem v kcal. Svoj priemerný denný výdaj zadaj buď manuálne, alebo použi import súboru z fitness aplikácie Samsung Health.",
                                style: TextStyle(fontSize: 13, color: MainTheme.of(context).primaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                "Dnešný dátum: ${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}",
                                style: TextStyle(fontSize: 15, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                "Cieľový dátum: ${user?.goalDate?.day}.${user?.goalDate?.month}.${user?.goalDate?.year}",
                                style: TextStyle(fontSize: 15, color: Colors.white),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: intakeTextController,
                              decoration: const InputDecoration(labelText: 'Priemerný denný príjem kcal'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Prázdna hodnota';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: caloriesTextController,
                              decoration: const InputDecoration(hintText: 'Kcal', labelText: 'Priemerný denný výdaj kcal'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Prázdna hodnota';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                            ),
                            FutureBuilder(
                              future: fetchLastMeasurement(),
                              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }
                                Map<String, dynamic> lastMeasurement = snapshot.data!;

                                return TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Váha z posledného merania', suffixText: 'kg', labelStyle: TextStyle(color: Colors.grey)),
                                  controller: TextEditingController(text: lastMeasurement['currentWeight'].toString()),
                                  readOnly: true,
                                  style: TextStyle(color: Colors.grey),
                                );
                              },
                            ),
                            TextFormField(
                              readOnly: true,
                              decoration: const InputDecoration(labelText: 'Cieľová váha', suffixText: 'kg', labelStyle: TextStyle(color: Colors.grey)),
                              controller: TextEditingController(text: user?.goalWeight.toString()),
                              //Make it look like a disabled field
                              style: TextStyle(color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            await runCalculation();
                                          },
                                          child: Text("Vypočítať"))),
                                  SizedBox(width: 30),
                                  Expanded(
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            //TODO: move to controller or something

                                            FilePickerResult? result = await FilePicker.platform.pickFiles();

                                            if (result == null || result.files[0].path == null) return;

                                            File file = new File(result.files[0].path!);
                                            String type = await CaloriesImporter.getFileType(file);
                                            int kcal = 0;
                                            if (type == "Samsung") {
                                              SamsungCaloriesImporter importer = new SamsungCaloriesImporter(file);
                                              kcal = await importer.getCaloriesAverage(DateTime.now().subtract(Duration(days: 180)));
                                            }
                                            setState(() {
                                              caloriesTextController.text = kcal.toString();
                                            });
                                          },
                                          child: Text("Import"))),
                                ],
                              ),
                            ),
                            buildResults(context)
                          ],
                        ));
                  });
            }));
  }
}

class Exercise {
  final String name;
  final double met;
  double time = 0;

  Exercise({required this.name, required this.met, this.time = 0});

  @override
  String toString() {
    return 'Exercise{name: $name, met: $met, time: $time}';
  }
}

class CalculationResult {
  int caloriesBurned;
  double calorieIntake;
  double bmrCalories;
  double neededBurnedPerDayToReachGoal;
  bool isMen;
  int age;
  int height;
  double currentWeight;
  int daysLeftToGoalDate;
  double caloriesDifference;

  CalculationResult({
    required this.caloriesBurned,
    required this.calorieIntake,
    required this.bmrCalories,
    required this.neededBurnedPerDayToReachGoal,
    required this.isMen,
    required this.age,
    required this.height,
    required this.currentWeight,
    required this.daysLeftToGoalDate,
    required this.caloriesDifference,
  });
}

class CaloriesController {
  final int caloriesPerKg = 7000;

  final List<Exercise> exercises = [
    Exercise(name: 'Chôdza/Pilates', met: 2.5),
    Exercise(name: 'Rychlejšia chôdza/pomale kračanie do schodov/power yoga', met: 4.0),
    Exercise(name: 'Intenzívna turistika/Beh/Veslovanie', met: 6.0),
  ];

  CalculationResult calculate(UserDataRecord userRecord, Map<String, dynamic> lastMeasurement, double calorieIntake, int caloriesBurned) {
    int age = ((userRecord.birthDate?.difference(DateTime.now()).inDays ?? 365) / 365).round().abs();
    int height = userRecord.height ?? 0;
    double currentWeight = double.tryParse(lastMeasurement['currentWeight'].toString()) ?? 0;
    bool isMen = userRecord.gender == 'Muž' ? true : false;

    double bmrCalories = (10 * currentWeight) + (6.25 * height) - (5 * age);

    bmrCalories = isMen ? bmrCalories + 5 : bmrCalories - 161;

    int daysLeftToGoalDate = userRecord.goalDate?.difference(DateTime.now()).inDays ?? 0;
    double neededBurnedPerDayToReachGoal = (currentWeight - userRecord.goalWeight!.toDouble()) * caloriesPerKg / daysLeftToGoalDate;
    double caloriesDifference = neededBurnedPerDayToReachGoal + (calorieIntake - (bmrCalories + caloriesBurned));

    return CalculationResult(
      caloriesBurned: caloriesBurned,
      calorieIntake: calorieIntake,
      bmrCalories: bmrCalories,
      neededBurnedPerDayToReachGoal: neededBurnedPerDayToReachGoal,
      isMen: isMen,
      age: age,
      height: height,
      currentWeight: currentWeight,
      daysLeftToGoalDate: daysLeftToGoalDate,
      caloriesDifference: caloriesDifference,
    );
  }

  List<Exercise> getExerciseTimes(CalculationResult result) {
    List<Exercise> exerciseWithTimes = [];
    for (var exercise in exercises) {
      double time = result.caloriesDifference / (exercise.met * result.currentWeight);
      exerciseWithTimes.add(Exercise(name: exercise.name, met: exercise.met, time: time));
    }

    return exerciseWithTimes;
  }
}
