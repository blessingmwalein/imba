import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUploadDetailsHeaders extends StatelessWidget {
  final String header;

  const CustomUploadDetailsHeaders({
    Key? key,
    required this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: TextStyle(fontSize: 20.sp),
      textAlign: TextAlign.start,
    );
  }
}
