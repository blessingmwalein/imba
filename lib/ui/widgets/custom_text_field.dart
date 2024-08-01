import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/utilities/constants.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType? type;
  final TextEditingController? controller;
  final String? errorText;

  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool readOnly;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.controller,
    this.errorText,
    this.type,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                labelText!,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          TextFormField(
            readOnly: readOnly,
            controller: controller,
            keyboardType: type ?? TextInputType.text,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              isDense: true,
              filled: true,
              fillColor: ColorConstants.grey.withOpacity(0.1),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
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
            ),
            validator: validator,
            onChanged: onChanged,
            focusNode: focusNode,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
