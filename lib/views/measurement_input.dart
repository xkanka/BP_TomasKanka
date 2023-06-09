import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kanofit/classes/utils.dart';
import 'package:kanofit/controllers/measure_input_controller.dart';

class MeasurementInput extends StatefulWidget {
  MeasurementInput({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MeasurementInputState createState() => _MeasurementInputState();
}

class _MeasurementInputState extends State<MeasurementInput> {
  final _formKey = GlobalKey<FormState>();
  MeasureInputController _measureInputController = MeasureInputController();

  List<String> hintTexts = [
    'Zadaj aktuálnu váhu (kg)',
    'Zadaj obvod ruky (cm)',
    'Zadaj obvod stehna (cm)',
    'Zadaj obvod pásu (cm)',
    'Zadaj obvod hrudníka (cm)',
    'Zadaj obvod lýtok (cm)',
  ];

  List<String> labelTexts = [
    'Váha',
    'Ruka',
    'Stehno',
    'Pás',
    'Hrudník',
    'Lýtko',
  ];

  List<String> svgIcons = [
    'assets/images/scale.svg',
    'assets/images/biceps.svg',
    'assets/images/thigh.svg',
    'assets/images/waist.svg',
    'assets/images/chest.svg',
    'assets/images/calf.svg',
  ];

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
                  ...hintTexts
                      .asMap()
                      .entries
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: SizedBox(
                                  width: 32,
                                  child: SvgPicture.asset(
                                    svgIcons[e.key],
                                    height: 32,
                                    width: 32,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  decoration: InputDecoration(
                                    hintText: hintTexts[e.key],
                                    labelText: labelTexts[e.key],
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty || !Utils.isNumericDouble(value)) {
                                      return 'Zadajte celočíselmú hodnotu';
                                    }
                                    return null;
                                  },
                                  onChanged: (String value) {
                                    setState(() {
                                      switch (e.key) {
                                        case 0:
                                          _measureInputController.currentWeight = value;
                                          break;
                                        case 1:
                                          _measureInputController.handCir = value;
                                          break;
                                        case 2:
                                          _measureInputController.thighCir = value;
                                          break;
                                        case 3:
                                          _measureInputController.beltCir = value;
                                          break;
                                        case 4:
                                          _measureInputController.chestCir = value;
                                          break;
                                        case 5:
                                          _measureInputController.calfCir = value;
                                          break;
                                      }
                                    });
                                  },
                                  onSaved: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _measureInputController.saveMeasurement(context);
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
