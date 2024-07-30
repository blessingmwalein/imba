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

  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.labelText,
      this.controller,
      this.errorText,
      this.type,
      this.validator,
      this.onChanged,
      this.focusNode, required this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        // height:30,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(labelText!, style: GoogleFonts.montserrat())),
            Expanded(
              flex: 2,
              child: TextFormField(
                readOnly: readOnly,
                // style:TextStyle(fontSize:10),
                controller: controller,

                keyboardType: type ?? TextInputType.text,

                decoration: InputDecoration(

                    isDense: true,
                    errorText: errorText,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: hintText,
                    filled: true,
                    fillColor: ColorConstants.grey),
                validator: validator,
                onChanged: onChanged,
                focusNode: focusNode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
