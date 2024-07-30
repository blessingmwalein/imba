// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:imba/bloc/upload/upload_bloc.dart';
// import 'package:imba/bloc/upload/upload_event.dart';
// import 'package:imba/bloc/upload/upload_state.dart';

// import '../../data/models/house_response.dart';
// import '../../utilities/constants.dart';
// import '../screens/edit_property.dart';
// import '../screens/property_details.dart';
// import '../screens/uploads.dart';
// import 'custom_elevated_button.dart';
// import 'loading_indicator.dart';
// import 'logo.dart';

// class CustomListView extends StatefulWidget {
//   final List<HouseResponse> uploadsResponse;
//    const CustomListView({
//     Key? key, required this.uploadsResponse,
//   }) : super(key: key);

//   @override
//   State<CustomListView> createState() => _CustomListViewState();
// }

// class _CustomListViewState extends State<CustomListView> {
//   @override
//   void initState() {

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {

//      var snackdemo =   const SnackBar(
//             content: Text('Activated'),
//             backgroundColor: ColorConstants.yellow,
//             elevation: 10,
//             behavior: SnackBarBehavior.floating,
//             margin: EdgeInsets.all(5),
//           );
//     return SizedBox(
//    height:MediaQuery.of(context).size.height ,
//     child: ListView.builder(
//        physics: const NeverScrollableScrollPhysics(),
//      shrinkWrap: true,
//         itemCount: widget.uploadsResponse.length,
//         itemBuilder: (BuildContext context, int index) {
//         return  _buildUploadsList(context, index, snackdemo, widget.uploadsResponse);
//         }),
//   );
//   }

//   Card _buildUploadsList(BuildContext context, int index, SnackBar snackdemo,List<HouseResponse> uploadsResponse ) {
//     return Card(
//        child: Row(
//    children: [
//      Expanded(
//        child: GestureDetector(
//         onTap:(){

//         Navigator.push(
// context,
// MaterialPageRoute(builder: (context) =>  PropertyDetails(type: uploadsResponse[index].type,
//  gspLocation:uploadsResponse[index].gpsLocation ,
//  houseAddress: uploadsResponse[index].houseAddress,
//  city: uploadsResponse[index].city,
//  area: uploadsResponse[index].area,
//  numberOfRooms: uploadsResponse[index].numberRooms.toString(),
//  extraDetails: uploadsResponse[index].extraDetails,
//  occupationdate:uploadsResponse[index].occupationDate.toString(),
//  isSolar: uploadsResponse[index].solar,
//  isBorehole: uploadsResponse[index].boreHole,
//  isWater: uploadsResponse[index].rentWaterInclusive,
//  isElectricity:uploadsResponse[index].rentElectricityInclusive ,
//  contact:  uploadsResponse[index].contact,
//  rent: uploadsResponse[index].rent.toString(),
//  isActive:uploadsResponse[index].activated

//  )));
//       },
//         child: Column(children:const [Logo(imageUrl: 'assets/images/houseicon.png',height:100, width: 100)]))),

//      Expanded(
//       child: GestureDetector(
//         onTap:(){

//         Navigator.push(
// context,
// MaterialPageRoute(builder: (context) =>  PropertyDetails(type: uploadsResponse[index].type,
//  gspLocation:uploadsResponse[index].gpsLocation ,
//  houseAddress: uploadsResponse[index].houseAddress,
//  city: uploadsResponse[index].city,
//  area: uploadsResponse[index].area,
//  numberOfRooms: uploadsResponse[index].numberRooms.toString(),
//  extraDetails: uploadsResponse[index].extraDetails,
//  occupationdate:uploadsResponse[index].occupationDate.toString(),
//  isSolar: uploadsResponse[index].solar,
//  isBorehole: uploadsResponse[index].boreHole,
//  isWater: uploadsResponse[index].rentWaterInclusive,
//  isElectricity:uploadsResponse[index].rentElectricityInclusive ,
//  contact:  uploadsResponse[index].contact,
//  rent: uploadsResponse[index].rent.toString(),
//  isActive:uploadsResponse[index].activated

//  )));

//       },
//          child: Column(children:  [
//            Text(uploadsResponse[index].type),
//            Text(uploadsResponse[index].area),
//            Text(uploadsResponse[index].city)

//          ]),
//        ),
//      ),

//      Expanded(
//       child: GestureDetector(
//         onTap:(){

//         Navigator.push(
// context,
// MaterialPageRoute(builder: (context) =>  PropertyDetails(type: uploadsResponse[index].type,
//  gspLocation:uploadsResponse[index].gpsLocation ,
//  houseAddress: uploadsResponse[index].houseAddress,
//  city: uploadsResponse[index].city,
//  area: uploadsResponse[index].area,
//  numberOfRooms: uploadsResponse[index].numberRooms.toString(),
//  extraDetails: uploadsResponse[index].extraDetails,
//  occupationdate:uploadsResponse[index].occupationDate.toString(),
//  isSolar: uploadsResponse[index].solar,
//  isBorehole: uploadsResponse[index].boreHole,
//  isWater: uploadsResponse[index].rentWaterInclusive,
//  isElectricity:uploadsResponse[index].rentElectricityInclusive ,
//  contact:  uploadsResponse[index].contact,
//  rent: uploadsResponse[index].rent.toString(),
//  isActive:uploadsResponse[index].activated

//  )));

//       }, child: Column(children: [Text((uploadsResponse[index].numberRooms).toString() +" rooms", style: const TextStyle(color: ColorConstants.yellow))]))),
//      Expanded(child: Column(
//       children: [ Text("\$${uploadsResponse[index].rent}", style: const TextStyle(color: ColorConstants.yellow)),

//       SizedBox(
//                         width: 150,
//                         child: BlocListener<UploadBloc, UploadState>(
//                           listener: (context, state) {
//                             if (state is ActivateHouseSuccess) {
//                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 content: const Text('Activated'),
//                                 duration: const Duration(seconds: 3),
//                                 action: SnackBarAction(
//                                   label: '',
//                                   onPressed: () {},
//                                 ),
//                               ));

//                             }
//                             if (state is ActivateFailedState) {
//                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 content: const Text('failed to activate house contact admin'),
//                                 duration: const Duration(seconds: 1),
//                                 action: SnackBarAction(
//                                   label: '',
//                                   onPressed: () {},
//                                 ),
//                               ));
//                             }
//                           },
// child: BlocBuilder<UploadBloc, UploadState>(
//     builder: (context, state) {
//   if (state is ActivateLoadingState) {
//     return const LoadingIndicator();
//   }
//                             return  CustomElevateButton(name: uploadsResponse[index].activated? "Edit":"Activate", color:Colors.black, fontSize: 10,
//       onSubmit:(){
//        uploadsResponse[index].activated ?
// WidgetsBinding.instance!.addPostFrameCallback((_) {
//         Navigator.push(
// context,
// MaterialPageRoute(builder: (context) =>    EditProperty(houseId:uploadsResponse[index].id, deposit: uploadsResponse[index].deposit,
//  occupationDate: uploadsResponse[index].occupationDate.toString(), occupied: uploadsResponse[index].occupied, rent: uploadsResponse[index].rent,)));}):
//        BlocProvider.of<UploadBloc>(context).add(
//                                     ActivateHouseEvent(
//                                         houseId: uploadsResponse[index].id
//                                ));

//       },);
//                           }),
//                         ),
//                       )

//      ]
//      ))
//    ]
//         ),
//       );
//   }
// }
