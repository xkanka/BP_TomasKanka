import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MeasurementSummaryWidget extends StatelessWidget {
  final String bodyPartIconAssetPath;
  final double averageMeasurement;
  final IconData trendIcon;
  final String units;
  //On Tap fn
  final Function()? onTap;
  final EdgeInsets padding;
  final int iconSize;

  MeasurementSummaryWidget({
    required this.bodyPartIconAssetPath,
    required this.averageMeasurement,
    required this.trendIcon,
    this.onTap,
    this.units = 'cm',
    this.padding = const EdgeInsets.all(4.0),
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.25)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    bodyPartIconAssetPath,
                    height: this.iconSize.toDouble(),
                    width: this.iconSize.toDouble(),
                  )),
              Text('${averageMeasurement.toStringAsFixed(1)} $units',
                  style: TextStyle(fontSize: 12)),
              SizedBox(width: 4),
              Icon(trendIcon,
                  color: trendIcon == Icons.arrow_upward
                      ? Colors.green
                      : Colors.red,
                  size: 12),
            ],
          ),
        ),
      ),
    );
  }
}
