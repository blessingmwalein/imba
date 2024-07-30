import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/meeting_request_response.dart';
import '../../utilities/constants.dart';
import 'logo.dart';

class MeetingsList extends StatefulWidget {
  final List<Meetings> meetingsList;

  const MeetingsList({Key? key, required this.meetingsList}) : super(key: key);

  @override
  State<MeetingsList> createState() => _MeetingsListState();
}

class _MeetingsListState extends State<MeetingsList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child:widget.meetingsList.isNotEmpty?ListView.builder(
          shrinkWrap: true,
          itemCount: widget.meetingsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(
                    flex: 1,
                    child: Column(children: [
                      Logo(
                          imageUrl: 'assets/images/houseicon.png',
                          width: 110.sp,
                          height: 110.sp)
                    ])),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text("FROM: ${widget.meetingsList[index].startDate}",
                     Text( "FROM:"+DateTime.parse(widget.meetingsList[index].startDate!).toLocal().toString(),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Montserrat")),
                                  Text("TO: "+DateTime.parse(widget.meetingsList[index].endDate!).toLocal().toString(),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Montserrat")),
                                ]),
                          ),
                          Expanded(
                            child: Column(children: [
                              Text("${widget.meetingsList[index].house!.id}\n${widget.meetingsList[index].house!.area}\n${widget.meetingsList[index].house!.city}",
                                  style: TextStyle(
                                      color: ColorConstants.yellow,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat")),
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                              color: ColorConstants.grey,
                              child: Text(widget.meetingsList[index].approved! ?"APPROVED" :"PENDING"  ,
                                  style: TextStyle(fontSize: 15.sp)))
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ]),
            );
          }):const Text("No meetings"),
    );
  }
}
