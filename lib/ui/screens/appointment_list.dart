// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:imba/ui/widgets/custom_appbar.dart';
// import 'package:imba/ui/widgets/meetings_listview.dart';
// import 'package:imba/utilities/constants.dart';
//
// import '../widgets/appointment_listview.dart';
// import '../widgets/custom_textbutton.dart';
//
// class AppointmentsList extends StatefulWidget {
//   const AppointmentsList({Key? key}) : super(key: key);
//
//   @override
//   State<AppointmentsList> createState() => _AppointmentsListState();
// }
//
// class _AppointmentsListState extends State<AppointmentsList> {
//   bool isRequest = false;
//   bool isMeeting = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: const CustomAppBar(
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           physics: const NeverScrollableScrollPhysics(),
//           child: Column(children: [
//             Container(
//                 color: ColorConstants.yellow,
//                 height: 50,
//                 width: MediaQuery.of(context).size.width,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("APPOINTMENTS",
//                       style: TextStyle(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "Montserrat")),
//                 )),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       CustomTextButton(
//                         color: isMeeting ? ColorConstants.yellow : Colors.black,
//                         fontSize: 20,
//                         name: 'MEETINGS',
//                         onSubmit: () {
//                           setState(() {
//                             isMeeting = true;
//                             isRequest = false;
//                           });
//                         },
//                       ),
//                       SizedBox(
//                           width: 50,
//                           child: Divider(
//                               thickness: 5,
//                               color: isMeeting ? Colors.black : Colors.white)),
//                     ],
//                   ),
//                   const SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       CustomTextButton(
//                         color: isRequest ? ColorConstants.yellow : Colors.black,
//                         fontSize: 20,
//                         name: 'REQUESTS',
//                         onSubmit: () {
//                           setState(() {
//                             isRequest = true;
//                             isMeeting = false;
//                           });
//                         },
//                       ),
//                       SizedBox(
//                           width: 50,
//                           child: Divider(
//                               thickness: 5,
//                               color: isRequest ? Colors.black : Colors.white)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Visibility(
//                 visible: isMeeting,
//                 child: const SingleChildScrollView(child: MeetingsList(meetingsList: [],))),
//             Visibility(
//                 visible: isRequest,
//                 child:
//                     const SingleChildScrollView(child: AppointmentListView(requestsList: [],)))
//           ]),
//         ));
//   }
// }
