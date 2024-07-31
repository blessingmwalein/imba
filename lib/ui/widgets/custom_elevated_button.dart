import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/utilities/constants.dart';

class CustomElevateButton extends StatelessWidget {
  final VoidCallback onSubmit;
  final String name;
  final Color color;
  final double? fontSize;
  final bool isOutline;
  final Color? backgroundColor;

  const CustomElevateButton({
    Key? key,
    required this.onSubmit,
    required this.name,
    required this.color,
    this.fontSize,
    this.isOutline = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSubmit,
      style: ElevatedButton.styleFrom(
        backgroundColor: isOutline ? backgroundColor : color,
        side: isOutline ? BorderSide(color: color) : BorderSide.none,
        elevation: isOutline ? 0 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
      child: Text(
        name,
        style: GoogleFonts.montserrat(
          color: isOutline ? color : Colors.white,
          fontSize: fontSize?.sp ?? 20.sp,
        ),
      ),
    );
  }
}
