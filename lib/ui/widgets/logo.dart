import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final String? imageUrl;

  const Logo({
    Key? key,
    this.height,
    this.width,
    this.color,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(imageUrl!, color: color, width: width, height: height);
  }
}
