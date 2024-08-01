import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),

      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: GoogleFonts.montserrat(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
            flex: 1,
            child: TextFormField(
              controller: minController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: ColorConstants.yellow),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: ColorConstants.yellow),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: ColorConstants.yellow)),
        
                // labelText: labelText,
                hintText: minHint,
                filled: true,
                fillColor: ColorConstants.grey.withOpacity(0.1),
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
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: ColorConstants.yellow),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: ColorConstants.yellow),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: ColorConstants.yellow)),
        
                // labelText: labelText,
                hintText: maxHint,
                filled: true,
                fillColor: ColorConstants.grey.withOpacity(0.1),
              ),
              onChanged: onChanged,
            ),
          ),
        ])
      ]),
    );
  }
}
