import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

class SearchRangeTextfield extends StatelessWidget {
  final String maxHint;
  final String minHint;
  final String name;
  final TextEditingController? maxController;
  final TextEditingController? minController;
  final String? Function(String?)? validator;

  final Function(String)? onChanged;

  const SearchRangeTextfield(
      {Key? key,
      required this.maxHint,
      required this.name,
      required this.minHint,
      required this.maxController,
      required this.minController,
      this.validator,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name),
        const SizedBox(height: 10),
        SizedBox(
          height: 30,
          child: Row(children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: minController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,

                  // labelText: labelText,
                  hintText: minHint,
                  filled: true,
                  fillColor: ColorConstants.grey,
                ),
                onChanged: onChanged,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: maxController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

                    // labelText: labelText,
                    hintText: maxHint,
                    filled: true,
                    fillColor: ColorConstants.grey),
                onChanged: onChanged,
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
