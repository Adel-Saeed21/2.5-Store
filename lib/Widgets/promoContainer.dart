// ignore_for_file: file_names

import 'package:flutter/material.dart';


class PromoContainer extends StatelessWidget {
  const PromoContainer({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    required this.applyImage,
    this.border,
    required this.background,
    this.fit,
    this.padding,
    required this.isNetworkImage,
    this.onpressd,
    required this.borderRediuss
  });
  final double? width, height;
  final String imageUrl;
  final bool applyImage;
  final BoxBorder? border;
  final Color background;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onpressd;
  final double borderRediuss;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressd,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: background,
          borderRadius: BorderRadius.circular(borderRediuss),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRediuss),
          child: Image(
              fit: fit,
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider),
        ),
      ),
    );
  }
}
