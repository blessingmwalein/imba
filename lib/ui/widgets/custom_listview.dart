import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/ui/screens/appointment.dart';

import '../../bloc/upload/upload_bloc.dart';
import '../../bloc/upload/upload_event.dart';
import '../../data/models/house_response.dart';
import '../../utilities/constants.dart';
import '../screens/edit_property.dart';
import '../screens/property_details.dart';
import 'custom_elevated_button.dart';
import 'logo.dart';

class CustomListView extends StatefulWidget {
  final List<HouseResponse> uploadsResponse;
  final String? isPage;

  const CustomListView({
    Key? key,
    required this.uploadsResponse,
    this.isPage

  }) : super(key: key);

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var snackdemo = const SnackBar(
      content: Text('Activated'),
      backgroundColor: ColorConstants.yellow,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.uploadsResponse.length,
          itemBuilder: (BuildContext context, int index) {
            return buildUploadsList(
                context, index, snackdemo, widget.uploadsResponse, widget.isPage!);
          }),
    );
  }
}

Card buildUploadsList(BuildContext context, int index, SnackBar snackdemo,
    List<HouseResponse> uploadsResponse, String isPage) {
  return Card(
    child: Row(children: [
      Expanded(
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PropertyDetails(
                            id: uploadsResponse[index].id, flag: "viewed"),
                        settings: const RouteSettings(
                          name: 'SecondPage',
                        ))).then((value) => BlocProvider.of<UploadBloc>(context)
                    .add(GetUploadsEvent()));
              },
              child: Column(children: const [
                Logo(
                    imageUrl: 'assets/images/houseicon.png',
                    height: 100,
                    width: 100)
              ]))),
      Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PropertyDetails(
                        id: uploadsResponse[index].id,
                        flag: "viewed"))).then((value) =>
                BlocProvider.of<UploadBloc>(context).add(GetUploadsEvent()));
          },
          child: Column(children: [
            Text(uploadsResponse[index].type),
            Text(uploadsResponse[index].area),
            Text(uploadsResponse[index].city)
          ]),
        ),
      ),
      Expanded(
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PropertyDetails(
                            id: uploadsResponse[index].id, flag: "viewed"),
                        settings: const RouteSettings(
                          name: 'SecondPage',
                        ))).then((value) => BlocProvider.of<UploadBloc>(context)
                    .add(
                        GetHouseByIdEvent(houseId: uploadsResponse[index].id)));
              },
              child: Column(children: [
                Text((uploadsResponse[index].numberRooms).toString() + " rooms",
                    style: const TextStyle(color: ColorConstants.yellow))
              ]))),
      Expanded(
          child: Column(children: [
        Text("${uploadsResponse[index].currency}${uploadsResponse[index].rent}",
            style: const TextStyle(color: ColorConstants.yellow)),

       isPage=="viewed"?
       CustomElevateButton(
         name: "Reserve",
         color: Colors.black,
         fontSize: 10,
         onSubmit: () {
           WidgetsBinding.instance!.addPostFrameCallback((_) {
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) =>
                         Appointment(
                             houseId: uploadsResponse[index].id,
                             action: "UPDATE"
                         )));
           });
         }
       )
           :
        CustomElevateButton(
          name: uploadsResponse[index].activated ? "Edit" : "Activate",
          color: Colors.black,
          fontSize: 10,
          onSubmit: () {
            uploadsResponse[index].activated
                ? WidgetsBinding.instance!.addPostFrameCallback((_) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProperty(
                                  houseId: uploadsResponse[index].id,
                                  deposit: uploadsResponse[index].deposit,
                                  occupationDate: uploadsResponse[index]
                                      .occupationDate
                                      .toString(),
                                  occupied: uploadsResponse[index].occupied,
                                  rent: uploadsResponse[index].rent,
                                )));
                  })
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PropertyDetails(
                            id: uploadsResponse[index].id, flag: "viewed"),
                        settings: const RouteSettings(
                          name: 'SecondPage',
                        ))).then((value) => BlocProvider.of<UploadBloc>(context)
                    .add(
                        GetHouseByIdEvent(houseId: uploadsResponse[index].id)));
          },
        )
      ]))
    ]),
  );
}
