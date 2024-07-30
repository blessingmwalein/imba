import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

class HouseDetails extends StatefulWidget {
  final String text1;
  final String text2;
  final bool isText1;
  final bool isText2;
  final Function(bool?) onChanged1;
  final Function(bool?) onChanged2;

  const HouseDetails(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.onChanged1,
      required this.onChanged2,
      required this.isText1,
      required this.isText2})
      : super(key: key);

  @override
  State<HouseDetails> createState() => _HouseDetailsState();
}

class _HouseDetailsState extends State<HouseDetails> {
  //  bool isText1 = false;
  //  bool isText2 = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.text1),
              Checkbox(
                activeColor: ColorConstants.yellow,
                checkColor: ColorConstants.yellow,
                value: widget.isText1,
                onChanged: widget.onChanged1,
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.text2),
              Checkbox(
                activeColor: ColorConstants.yellow,
                checkColor: ColorConstants.yellow,
                value: widget.isText2,
                onChanged: widget.onChanged2,
                // onChanged: (bool? value) {
                //   setState(() {
                //     isText2 = value!;
                //   });
                // },
              )
            ],
          ),
        )
      ],
    );
  }
}
