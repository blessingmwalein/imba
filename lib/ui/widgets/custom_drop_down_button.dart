import 'package:flutter/material.dart';
import 'package:imba/utilities/constants.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<String>? items;
  String? dropDownValue;

  CustomDropDownButton(
      {Key? key, required this.items, required this.dropDownValue})
      : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Container(
        color: ColorConstants.grey,
        child: DropdownButton(
          isDense: true,
          hint: Text('Choose'),
          value: widget.dropDownValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: widget.items!.map((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              widget.dropDownValue = newValue.toString();
            });
          },
        ),
      ),
    );
  }
}
