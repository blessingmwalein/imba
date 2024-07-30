import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/bloc/activate/activate_state.dart';
import 'package:imba/bloc/upload/upload_bloc.dart';
import 'package:imba/bloc/upload/upload_state.dart';
import 'package:imba/data/models/house_response.dart';
import 'package:imba/data/models/payment_response.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/activate/activate_bloc.dart';
import '../../bloc/activate/activate_event.dart';
import '../../bloc/upload/upload_event.dart';
import '../../utilities/constants.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/logo.dart';
import '../widgets/maps_widget.dart';
import '../widgets/property_error_widget.dart';
import 'actions_options.dart';
import 'edit_property.dart';

class PropertyDetails extends StatefulWidget {
  final int id;
  final String flag;

  const PropertyDetails({Key? key, required this.id, required this.flag})
      : super(key: key);

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  late PageController _pageController;

  @override
  void initState() {
    BlocProvider.of<ActivateBloc>(context)
        .add(ActivationResetEvent());
    BlocProvider.of<UploadBloc>(context)
        .add(GetHouseByIdEvent(houseId: widget.id));

    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }
  List<String> images=[];
  void _processImageUrls(List<Pics> pics){
    if(pics.isNotEmpty){
      for (var element in pics) {
        images.add("http://api.codiebutterfly.com/house/${element.id}/image/download");
      }}
  }


  List<String> placeholders=['assets/images/placeholder1.jpg',
    'assets/images/placeholder2.jpg',
    'assets/images/placeholder3.jpg',
    'assets/images/placeholder4.jpg',
    'assets/images/placeholder5.jpg'];


  var isActivated = false;
  late PaymentResponse houseDetails;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadBloc, UploadState>(builder: (context, state) {
      if (state is GetHouseByIdSuccess) {
        isActivated = state.houseResponse.house!.activated!;
        houseDetails = state.houseResponse;
        List<Pics>  pics=state.houseResponse.pics!;
        _processImageUrls(pics);

        return Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height*1.5,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: CarouselSlider(
                      carouselController: CarouselController(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: MediaQuery.of(context).size.height * 0.4,
                        enlargeCenterPage: true,
                        onPageChanged: (position, reason) {
                          print(reason);
                          print(CarouselPageChangedReason.controller);
                        },
                        enableInfiniteScroll: false,
                      ),
                      items:images.isNotEmpty? images.map<Widget>((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.5,
                                // margin: EdgeInsets.all(10),
                                child: Image.network(
                                  i,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.4,
                                )
                            );
                          },
                        );
                      }).toList():
                      placeholders.map<Widget>((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.5,
                                // margin: EdgeInsets.all(10),
                                child: Image.asset(
                                  i,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.4,
                                )
                            );
                          },
                        );
                      }).toList()
                      ,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(children: [
                                  Text(state.houseResponse.house!.type!,
                                      style: GoogleFonts.montserrat()),
                                  GestureDetector(
                                      onTap: () {
                                        print(state.houseResponse.house!.gpsLocation);
                                        List<String> result = state
                                            .houseResponse.house!.gpsLocation!
                                            .split(',');
                                        // MapUtils.openMap(double.parse(result[0]),double.parse(result[1]));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MapScreen(
                                                    latitude:
                                                        double.parse(result[0]),
                                                    longitude: double.parse(
                                                        result[1]))));
                                      },
                                      child: const Logo(
                                          imageUrl:
                                              'assets/images/address-location.png',
                                          height: 50,
                                          width: 50)),
                                ]),
                                Column(children: [
                                  Text(
                                      "${state.houseResponse.house!.houseAddress}\n${state.houseResponse.house!.area}\n${state.houseResponse.house!.city}",
                                      style: GoogleFonts.montserrat()),
                                ])
                              ],
                            ),
                            Column(children: [
                              Text("${state.houseResponse.house!.numberRooms} Rooms",
                                  style: GoogleFonts.montserrat(
                                      color: ColorConstants.yellow,
                                      fontSize: 35)),
                              Text(state.houseResponse.house!.extraDetails!,
                                  style: GoogleFonts.montserrat())
                            ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  unratedColor: ColorConstants.grey,
                                  initialRating:
                                      state.houseResponse.house!.rate!.toDouble(),
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  //  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 10.sp,
                                  ),
                                  onRatingUpdate: (initialRating) {
                                    print(initialRating);
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(children: [
                                    Text(
                                      "OCCUPATION DATE",
                                      style: GoogleFonts.montserrat(
                                          color: ColorConstants.yellow,
                                          fontSize: 10),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                        DateFormat.yMMMMd('en_US').format(
                                            DateTime.parse(state
                                                .houseResponse.house!.occupationDate
                                                .toString())),
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold))
                                  ]),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(state.houseResponse.house!.solar!
                                          ? "Solar"
                                          : ""),
                                      SizedBox(
                                          height:
                                              state.houseResponse.house!.solar! ? 10 : 0),
                                      Text(state.houseResponse.house!.boreHole!
                                          ? "Borehole"
                                          : ""),
                                      SizedBox(
                                          height: state.houseResponse.house!.boreHole!
                                              ? 10
                                              : 0),
                                      Text(state.houseResponse.house!.rentWaterInclusive!
                                          ? "Rent Includes water"
                                          : ""),
                                      SizedBox(
                                          height: state.houseResponse.house!
                                                  .rentWaterInclusive!
                                              ? 10
                                              : 0),
                                      Text(state.houseResponse.house!
                                              .rentElectricityInclusive!
                                          ? "Rent Includes electricity"
                                          : ""),
                                      SizedBox(
                                          height: state.houseResponse.house!
                                                  .rentElectricityInclusive!
                                              ? 10
                                              : 0),
                                      Text(state.houseResponse.house!.gated!
                                          ? "Gated"
                                          : ""),
                                      SizedBox(
                                          height:
                                              state.houseResponse.house!.gated! ? 10 : 0),
                                      Text(state.houseResponse.house!.tiled!
                                          ? "Tiled"
                                          : ""),
                                      SizedBox(
                                          height:
                                              state.houseResponse.house!.tiled! ? 10 : 0),
                                      Text(state.houseResponse.house!.walled!
                                          ? "Walled"
                                          : ""),
                                      SizedBox(
                                          height: state.houseResponse.house!.walled!
                                              ? 20
                                              : 0),
                                    ]),
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: ()=> launch(state.houseResponse.house!.contact!),
                                    child: const Logo(
                                        imageUrl: 'assets/images/phone.png',
                                        color: Colors.blue,
                                        height: 20,
                                        width: 20),
                                  ),
                                  Text(state.houseResponse.house!.contact!)
                                ]),
                            const SizedBox(height: 15),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "RENT",
                                        style: GoogleFonts.montserrat(
                                            color: ColorConstants.yellow,
                                            fontSize: 10),
                                      ),
                                      Text(
                                        "${state.houseResponse.house!.currency}${state.houseResponse.house!.rent!}",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      BlocBuilder<ActivateBloc, ActivateState>(
                                          builder: (context, state) {
                                        if (state is ActivateLoadingState) {
                                          return const LoadingIndicator();
                                        }
                                        if (state is ActivateHouseSuccess) {
                                          if (state.isActivated == true) {
                                            isActivated = true;
                                            BlocProvider.of<ActivateBloc>(context)
                                                .add(ActivationResetEvent());

                                          }
                                          if (state.isActivated == false) {
                                            SchedulerBinding.instance!
                                                .addPostFrameCallback((_) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PropertyError(
                                                              errorMessage:
                                                                  'Failed to activate contact admin')));
                                            });

                                            BlocProvider.of<ActivateBloc>(context)
                                                .add(ActivationResetEvent());
                                          }
                                        }
                                        print("++++++" + isActivated.toString());
                                        if (state is ActivateFailedState) {
                                          if (state.message
                                              .contains("not registered")) {
                                            SchedulerBinding.instance!
                                                .addPostFrameCallback((_) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PropertyError(
                                                              errorMessage:
                                                                  'Set up profile first')));
                                            });
                                            BlocProvider.of<ActivateBloc>(context)
                                                .add(ActivationResetEvent());
                                          } else {
                                            SchedulerBinding.instance!
                                                .addPostFrameCallback((_) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                           PropertyError(
                                                              errorMessage:
                                                                  state.message)));
                                            });
                                          }
                                        }

                                        return widget.flag == "actions"
                                            ? CustomElevateButton(
                                                onSubmit: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ActionsOptions(
                                                                houseId:
                                                                    widget.id,
                                                              )));
                                                },
                                                name: "Actions",
                                                color: ColorConstants.yellow,
                                              )
                                            : CustomElevateButton(
                                                name: isActivated
                                                    ? 'EDIT'
                                                    : 'ACTIVATE',
                                                color: ColorConstants.yellow,
                                                onSubmit: () {
                                                  isActivated
                                                      ? Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditProperty(
                                                                    houseId:
                                                                        widget.id,
                                                                    deposit:
                                                                        houseDetails.house!
                                                                            .deposit!,
                                                                    occupationDate:
                                                                        houseDetails.house!.
                                                                            occupationDate
                                                                            .toString(),
                                                                    occupied:
                                                                        houseDetails.house!
                                                                            .occupied!,
                                                                    rent:
                                                                        houseDetails.house!
                                                                            .rent!,
                                                                  )))

                                                      : BlocProvider.of<
                                                                  ActivateBloc>(
                                                              context)
                                                          .add(ActivateHouseEvent(
                                                              houseId:
                                                                  widget.id));
                                                  // BlocProvider.of<UploadBloc>(context).add(GetUploadsEvent());
                                                  // widget.flag=="viewed"?"":Navigator.pop(context);
                                                },
                                              );
                                      })
                                    ],
                                  )
                                ])
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
      }
      return const LoadingIndicator();
    });
  }
}