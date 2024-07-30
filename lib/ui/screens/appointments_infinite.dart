import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:imba/bloc/appointment/appointment_bloc.dart';
import 'package:imba/bloc/appointment/appointment_event.dart';
import 'package:imba/bloc/appointment/appointment_state.dart';
import 'package:imba/data/models/meeting_request_response.dart';
import 'package:imba/ui/screens/appointment.dart';
import 'package:imba/ui/screens/view_house.dart';

import '../../data/models/search_response_model.dart';
import '../../secure_storage/secure_storage_manager.dart';
import '../../utilities/constants.dart';
import '../widgets/appointment_listview.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_textbutton.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/meetings_listview.dart';

class AppointmentInfinite extends StatefulWidget {
  const AppointmentInfinite({
    Key? key,
  }) : super(key: key);

  @override
  State<AppointmentInfinite> createState() => _AppointmentInfiniteState();
}

class _AppointmentInfiniteState extends State<AppointmentInfinite> {
  bool isRequest = false;
  bool isMeeting = true;
  var resp;

  @override
  void initState() {
    BlocProvider.of<AppointmentBloc>(context).add(GetMeetingsAndRequestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(children: [
            Container(
                color: ColorConstants.yellow,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("APPOINTMENTS",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat")),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextButton(
                        color: isMeeting ? ColorConstants.yellow : Colors.black,
                        fontSize: 20,
                        name: 'MEETINGS',
                        onSubmit: () {
                          BlocProvider.of<AppointmentBloc>(context)
                              .add(GetMeetingsAndRequestEvent());

                          setState(() {
                            isMeeting = true;
                            isRequest = false;
                          });
                        },
                      ),
                      SizedBox(
                          width: 50,
                          child: Divider(
                              thickness: 5,
                              color: isMeeting ? Colors.black : Colors.white)),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextButton(
                        color: isRequest ? ColorConstants.yellow : Colors.black,
                        fontSize: 20,
                        name: 'REQUESTS',
                        onSubmit: () {
                          BlocProvider.of<AppointmentBloc>(context)
                              .add(GetMeetingsAndRequestEvent());

                          setState(() {
                            isRequest = true;
                            isMeeting = false;
                          });
                        },
                      ),
                      SizedBox(
                          width: 50,
                          child: Divider(
                              thickness: 5,
                              color: isRequest ? Colors.black : Colors.white)),
                    ],
                  ),
                ],
              ),
            ),

            BlocListener<AppointmentBloc, AppointmentState>(
              listener: (context, state) {
                if (state is MeetingsAndRequestsSuccessState) {
                  //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content: const Text('loaded'),
                  //   duration: const Duration(seconds: 1),
                  //   action: SnackBarAction(
                  //     label: '',
                  //     onPressed: () {},
                  //   ),
                  // ));
                  // BlocProvider.of<UploadBloc>(context).add(ResetUploadsEvent());
                }
                if (state is AppointmentFailedState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('failed to load'),
                    duration: const Duration(seconds: 1),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {},
                    ),
                  ));
                }
              },
              child: BlocBuilder<AppointmentBloc, AppointmentState>(
                  builder: (context, state) {
                if (state is AppointmentLoadingState) {
                  return const LoadingIndicator();
                }
                if (state is MeetingsAndRequestsSuccessState) {
                  resp = state.meetingRequestsResponse;
                  return Column(children: [
                    Visibility(
                        visible: isMeeting,
                        child: SingleChildScrollView(
                            child: MeetingsList(
                          meetingsList: state.meetingRequestsResponse.meetings!,
                        ))),
                    Visibility(
                        visible: isRequest,
                        child: SingleChildScrollView(
                            child: AppointmentListView(
                                requestsList:
                                    state.meetingRequestsResponse.requests!)))
                  ]);
                }
                if (state is AppointmentFailedState) {
                  return Container(
                    height: 500,
                    width: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text(state.message)),
                        CustomElevateButton(
                            onSubmit: () {
                              BlocProvider.of<AppointmentBloc>(context)
                                  .add(GetMeetingsAndRequestEvent());
                            },
                            color: ColorConstants.yellow,
                            name: "Retry")
                      ],
                    ),
                  );
                }
                return Container();
              }),
            ),
            // Column(
            //         children:[
            //       Visibility(
            //           visible: isMeeting,
            //           child: const SingleChildScrollView(child: MeetingsList(meetingsList: [],))),
            //       Visibility(
            //           visible: isRequest,
            //           child:
            //           const SingleChildScrollView(child: AppointmentListView()))])
          ]),
        ));
  }
}
