import 'package:flutter/material.dart';
import 'package:kanofit/components/icon_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/statistics_controller.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final StatisticsController _controller = StatisticsController();

  @override
  void initState() {
    super.initState();
    _controller.fetchMeasurementsWithinDuration(Duration(days: 180)).then((value) {
      setState(() {
        _controller.measurements = value;
      });
    });
  }

  IconCardWidget buildIconCardWidget(String iconPath, Function() onTap, bool isSelected) {
    return IconCardWidget(
      bodyPartIconAssetPath: iconPath,
      onTap: onTap,
      padding: EdgeInsets.all(8.0),
      isSelected: isSelected,
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

          return GridView.count(
            crossAxisCount: 6,
            childAspectRatio: 1,
            children: [
              buildIconCardWidget('assets/images/waist.svg', () {
                setState(() {
                  _controller.selectedMeasurementField = 'beltCir';
                });
              }, _controller.selectedMeasurementField == 'beltCir'),
              buildIconCardWidget('assets/images/chest.svg', () {
                setState(() {
                  _controller.selectedMeasurementField = 'chestCir';
                });
              }, _controller.selectedMeasurementField == 'chestCir'),
              buildIconCardWidget('assets/images/biceps.svg', () {
                setState(() {
                  _controller.selectedMeasurementField = 'handCir';
                });
              }, _controller.selectedMeasurementField == 'handCir'),
              buildIconCardWidget('assets/images/thigh.svg', () {
                setState(() {
                  _controller.selectedMeasurementField = 'thighCir';
                });
              }, _controller.selectedMeasurementField == 'thighCir'),
              buildIconCardWidget('assets/images/calf.svg', () {
                setState(() {
                  _controller.selectedMeasurementField = 'calfCir';
                });
              }, _controller.selectedMeasurementField == 'calfCir'),
              buildIconCardWidget('assets/images/scale.svg', () {
                setState(() {
                  _controller.selectedMeasurementField = 'currentWeight';
                });
              }, _controller.selectedMeasurementField == 'currentWeight'),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.measurements.isEmpty) {
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

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              // title: ChartTitle(text: 'Progress for the last 6 months'),
              // Enable legend
              legend: Legend(
                isVisible: false,
              ),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<MeasureData, String>>[
                LineSeries<MeasureData, String>(
                  dataSource: _controller.getChartData().toList().reversed.toList(),
                  xValueMapper: (MeasureData data, _) => data.date,
                  yValueMapper: (MeasureData data, _) => double.tryParse(data.value.toString()),
                  name: 'Value',
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
          Container(
            height: 100, // Set a fixed height for the summaries container
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: buildSummaries(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
