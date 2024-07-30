import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

class CustomMultiLineTexField extends StatelessWidget {
  final int lines;
  final TextEditingController? controller;

  const CustomMultiLineTexField({
    Key? key,
    required this.lines,required  this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:controller ,
      keyboardType: TextInputType.multiline,
      maxLines: lines,
      decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          filled: true,
          fillColor: ColorConstants.grey //<-- SEE HERE
          // ),
          ),
    );
  }
}
