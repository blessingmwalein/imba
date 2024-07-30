import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utilities/constants.dart';
import 'logo.dart';

class PropertyError extends StatelessWidget {
  final String errorMessage;

  const PropertyError({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Logo(
              imageUrl: 'assets/images/houseicon.png', height: 200, width: 200),
          Text("ERROR !",
              style: TextStyle(
                  color: ColorConstants.yellow,
                  fontFamily: "Montserrat",
                  fontSize: 25.sp)),
          const SizedBox(height: 10),
          Text(errorMessage,
              style: TextStyle(fontFamily: "Montserrat", fontSize: 10.sp))
        ]),
      ),
    );
  }
}
