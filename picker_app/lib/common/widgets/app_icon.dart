import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:picker/constants/constants.dart';

class AppIcon extends StatelessWidget {
  final AppIcons icon;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  const AppIcon(
    this.icon, {
    Key? key,
    this.width,
    this.height,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon.toAssetName(),
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      color: color,
      semanticsLabel: icon.toString(),
    );
  }
}
