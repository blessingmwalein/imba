import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Function onSubmit;
  final String name;
  final Color color;
  final double? fontSize;

  const CustomTextButton({
    Key? key,
    required this.onSubmit,
    required this.name,
    required this.color,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(
          name,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontFamily: "Montserrat",
          ),
          textAlign: TextAlign.right,
        ),
        onPressed: () => onSubmit());
  }
}
