import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/utilities/constants.dart';

class CustomElevateButton extends StatelessWidget {
  final Function onSubmit;
  final String name;
  final Color color;
  final double? fontSize;

  const CustomElevateButton(
      {Key? key,
      required this.onSubmit,
      required this.name,
      required this.color,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text(name,
            style: GoogleFonts.montserrat(
                color: color == ColorConstants.yellow
                    ? Colors.black
                    : ColorConstants.yellow,
                fontSize: fontSize?.sp ?? 20.sp)),
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
        ),
        onPressed: () => onSubmit());
  }
}
