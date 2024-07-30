import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

class CustomOpaqueContainer extends StatelessWidget {
  final String name;
  final TextStyle googleFontStyle;

  const CustomOpaqueContainer({
    Key? key,
    required this.name,
    required this.googleFontStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Container(
            height: (MediaQuery.of(context).size.height) / 6,
            width: MediaQuery.of(context).size.width,
            color: ColorConstants.yellow,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height) / 6,
              alignment: Alignment.center,
              child: Text(name, style: googleFontStyle),
            ),
          ],
        ),
      ],
    );
  }
}
