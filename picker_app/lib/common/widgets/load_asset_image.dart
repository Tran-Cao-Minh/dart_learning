import 'package:flutter/material.dart';

class LoadAssetImage extends StatelessWidget {
  LoadAssetImage(
    this.image, {
    Key? key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.customImage,
    this.filterQuality,
  })  : assert(customImage != null || (customImage == null && image != null),
            'Must provide at least one.'),
        super(key: key);

  final String? image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final AssetImage? customImage;
  final FilterQuality? filterQuality;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: customImage ?? AssetImage(image!),
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      excludeFromSemantics: true,
      filterQuality: filterQuality ?? FilterQuality.low,
    );
  }
}
