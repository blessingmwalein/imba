// Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: currentDate,
//         firstDate: DateTime.now(),
//         lastDate: DateTime(2050),
//             builder: (context, child) {
//       return Theme(
//         data: Theme.of(context).copyWith(
//           colorScheme: const ColorScheme.light(
//             primary: ColorConstants.yellow, // <-- SEE HERE
//             onPrimary: Colors.black, // <-- SEE HERE
//             onSurface: Colors.black, // <-- SEE HERE
//           ),
//           textButtonTheme: TextButtonThemeData(
//             style: TextButton.styleFrom(
//               primary: Colors.black, // button text color
//             ),
//           ),
//         ),
//         child: child!,
//       );
//     },);

//     if (pickedDate != null && pickedDate != currentDate) {
//       setState(() {
//         currentDate = pickedDate;
//       });
//     }
//   }

//   TimeOfDay _time = TimeOfDay(
//       hour: (DateTime(DateTime.now().hour).hour),
//       minute: (DateTime(DateTime.now().minute).minute));

//   void _selectTime() async {
//     final TimeOfDay? newTime = await showTimePicker(
//       context: context,
//       initialTime: _time,
//     );
//     if (newTime != null) {
//       setState(() {
//         _time = newTime;
//       });
//     }
//   }
// }
// class AlwaysDisabledFocusNode extends FocusNode {
//   @override
//   bool get hasFocus => false;
// }
