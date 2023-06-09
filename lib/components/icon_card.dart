import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconCardWidget extends StatelessWidget {
  final String bodyPartIconAssetPath;
  //On Tap fn
  final Function()? onTap;
  final EdgeInsets padding;
  final int iconSize;
  final bool isSelected;

  IconCardWidget({
    required this.bodyPartIconAssetPath,
    this.onTap,
    this.padding = const EdgeInsets.all(4.0),
    this.iconSize = 24,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? Color(0xFFEE8B60) : null,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.25)),
        child: Padding(
          padding: this.padding,
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
            ],
          ),
        ),
      ),
    );
  }
}
