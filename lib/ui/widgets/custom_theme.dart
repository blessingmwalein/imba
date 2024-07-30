import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utilities/constants.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      primaryColor: ColorConstants.yellow,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
      //3
      buttonTheme: ButtonThemeData(
        // 4
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Colors.black,
      ),
      textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
    );
  }
}
