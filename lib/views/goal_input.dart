import 'package:flutter/material.dart';
import 'package:kanofit/classes/Utils.dart';
import 'package:kanofit/controllers/goal_input_controller.dart';
import 'package:kanofit/main.dart';

class GoalInput extends StatefulWidget {
  GoalInput({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _GoalInputState createState() => _GoalInputState();
}

class _GoalInputState extends State<GoalInput> {
  final _formKey = GlobalKey<FormState>();
  final _controller = GoalInputController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
        context: context,
        initialDate: _controller.goalDate,
        firstDate: DateTime.now().add(
          Duration(days: 1),
        ),
        lastDate: DateTime.now().add(
          Duration(days: 3650),
        )))!;
    if (picked != null && picked != _controller.goalDate)
      setState(() {
        _controller.goalDate = picked;
        _controller.goalDateController.text = "${_controller.goalDate.day}.${_controller.goalDate.month}.${_controller.goalDate.year}";
      });
  }

  Future<void> saveGoal() async {
    await _controller.saveGoal(_controller.goalDate, _controller.goalWeight!);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => NavBarPage(initialPage: 'silhouette'),
      ),
      (r) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
          child: Form(
              key: _formKey,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.monitor_weight, size: 32), hintText: 'Zadaj svoju cieľovú váhu (kg)', labelText: 'Cieľová váha'),
                      validator: (value) {
                        if (value!.isEmpty || !Utils.isNumericDouble(value)) {
                          return 'Zadajte celočíselmú hodnotu';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          _controller.goalWeight = value;
                        });
                      },
                      onSaved: (value) {},
                    ),
                  ),
                  TextFormField(
                      controller: _controller.goalDateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                          icon: const Icon(
                            Icons.accessibility,
                            size: 45,
                          ),
                          hintText: 'Zadaj cieľový dátum',
                          labelText: 'Dátum'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Zadajte datum";
                        }
                        return null;
                      },
                      onTap: () {
                        _selectDate(context);
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          saveGoal();
                        }
                      },
                      child: Text('Hotovo'),
                    ),
                  )
                ],
              ))),
    );
  }
}
