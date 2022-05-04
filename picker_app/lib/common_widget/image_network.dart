import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageNetwork extends StatelessWidget {
  static final String PLACE_HOLDER_ASSET =
      'assets/images/bg_product_detail_placeholder.png';
  final String url;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String? placeHolderAsset;
  final String? errorAsset;
  final double? aspectRatio;

  ImageNetwork({
    Key? key,
    required this.url,
    this.height,
    this.width,
    required this.fit,
    this.placeHolderAsset,
    this.errorAsset,
    this.aspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => aspectRatio != null
          ? AspectRatio(
              aspectRatio: aspectRatio!,
              child: _content(imageProvider),
            )
          : _content(imageProvider),
      placeholder: (context, url) => Image.asset(
        placeHolderAsset ?? 'assets/images/image_placeholder.png',
        fit: BoxFit.contain,
        height: height,
        width: width,
      ),
      errorWidget: (context, url, error) => Image.asset(
        errorAsset ?? 'assets/images/image_placeholder.png',
        fit: BoxFit.contain,
        height: height,
        width: width,
      ),
    );
  }

  Widget _content(ImageProvider<Object> imageProvider) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
        ),
      ),
    );
  }
}
