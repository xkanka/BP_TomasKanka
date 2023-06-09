import 'package:flutter/material.dart';
import 'package:kanofit/controllers/silhouette_page_controller.dart';
import 'dart:core';

import '../../components/measurement_painter.dart';
import '../../components/measurement_summary.dart';

class SilhouetteWidget extends StatefulWidget {
  SilhouetteWidget({Key? key}) : super(key: key);

  @override
  _SilhouetteWidgetState createState() => _SilhouetteWidgetState();
}

class _SilhouetteWidgetState extends State<SilhouetteWidget> {
  final _controller = SilhouetteController();

  MeasurementSummaryWidget buildMeasurementSummaryWidget(List<Map<String, dynamic>> measurements, String fieldName, String iconPath, {String units = 'cm'}) {
    return MeasurementSummaryWidget(
      bodyPartIconAssetPath: iconPath,
      averageMeasurement: _controller.calculateAverageMeasurement(measurements, fieldName),
      trendIcon: _controller.calculateTrendIcon(measurements, fieldName),
      units: units,
    );
  }

  Widget buildSummaries(BuildContext context) {
    return FutureBuilder(
        future: _controller.fetchMeasurementsWithinDuration(Duration(days: 180)),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error fetching data');
          }
          List<Map<String, dynamic>>? fetchedMeasurements = snapshot.data;
          if (fetchedMeasurements == null || fetchedMeasurements.isEmpty) {
            return Center(child: Text('Prosím, pridajte si prvé meranie.'));
          }

          List<Map<String, dynamic>> measurements = snapshot.data!;

          return GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 3,
            children: [
              buildMeasurementSummaryWidget(measurements, 'beltCir', 'assets/images/waist.svg'),
              buildMeasurementSummaryWidget(measurements, 'chestCir', 'assets/images/chest.svg'),
              buildMeasurementSummaryWidget(measurements, 'handCir', 'assets/images/biceps.svg'),
              buildMeasurementSummaryWidget(measurements, 'thighCir', 'assets/images/thigh.svg'),
              buildMeasurementSummaryWidget(measurements, 'calfCir', 'assets/images/calf.svg'),
              buildMeasurementSummaryWidget(measurements, 'currentWeight', 'assets/images/scale.svg', units: 'kg'),
            ],
          );
        });
  }

  Widget buildSilhouette(BuildContext context, Map<String, dynamic> measurement) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
        child: buildSummaries(context),
      ),
      Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double containerWidth = constraints.maxWidth;
              double containerHeight = constraints.maxHeight;

              return Stack(children: [
                Center(
                  child: Image(
                      image: AssetImage('assets/images/man_silhouette.png'), width: containerWidth * 0.93, alignment: Alignment.center, fit: BoxFit.contain),
                ),
                /* BICEPS LEFT */
                CustomPaint(
                  painter: MeasurementPainter(
                      bodyPartPosition: Offset(containerWidth * 0.35, containerHeight * 0.21),
                      textPosition: Offset(containerWidth * 0.35, containerHeight * 0.135)),
                ),
                Positioned(
                  top: containerHeight * 0.1,
                  left: containerWidth * 0.28,
                  child: measurement['handCir'] != null ? Text(measurement['handCir'].toString() + " cm") : Text("0 cm"),
                ),
                /* WAIST */
                CustomPaint(
                  painter: MeasurementPainter(
                      bodyPartPosition: Offset(containerWidth * 0.47, containerHeight * 0.37),
                      textPosition: Offset(containerWidth * 0.28, containerHeight * 0.37)),
                ),
                Positioned(
                  child: measurement['beltCir'] != null ? Text(measurement['beltCir'].toString() + " cm") : Text("0 cm"),
                  top: containerHeight * 0.35,
                  left: containerWidth * 0.17,
                ),
                /* THIGH LEFT */
                CustomPaint(
                  painter: MeasurementPainter(
                      bodyPartPosition: Offset(containerWidth * 0.44, containerHeight * 0.58),
                      textPosition: Offset(containerWidth * 0.28, containerHeight * 0.58)),
                ),
                Positioned(
                  child: measurement['thighCir'] != null ? Text(measurement['thighCir'].toString() + " cm") : Text("0 cm"),
                  top: containerHeight * 0.56,
                  left: containerWidth * 0.17,
                ),
                /* CHEST */
                CustomPaint(
                  painter: MeasurementPainter(
                      bodyPartPosition: Offset(containerWidth * 0.5, containerHeight * 0.25),
                      textPosition: Offset(containerWidth * 0.68, containerHeight * 0.30)),
                ),
                Positioned(
                  child: measurement['chestCir'] != null ? Text(measurement['chestCir'].toString() + " cm") : Text("0 cm"),
                  top: containerHeight * 0.28,
                  left: containerWidth * 0.69,
                ),
                /* CALF RIGHT */
                CustomPaint(
                  painter: MeasurementPainter(
                      bodyPartPosition: Offset(containerWidth * 0.58, containerHeight * 0.77),
                      textPosition: Offset(containerWidth * 0.68, containerHeight * 0.77)),
                ),
                Positioned(
                  child: measurement['calfCir'] != null ? Text(measurement['calfCir'].toString() + " cm") : Text("0 cm"),
                  top: containerHeight * 0.75,
                  left: containerWidth * 0.69,
                ),
              ]);
            },
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _controller.fetchLastMeasurement(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('Prosím, pridajte si prvé meranie.'));
          }

          List<Map<String, dynamic>> lastMeasurement = snapshot.data!;

          return buildSilhouette(context, lastMeasurement[0]);
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text('Error fetching data');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
