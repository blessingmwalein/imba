import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utilities/constants.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/logo.dart';
import 'actions_options.dart';

class PropertyAction extends StatefulWidget {
  const PropertyAction({Key? key}) : super(key: key);

  @override
  State<PropertyAction> createState() => _PropertyActionState();
}

class _PropertyActionState extends State<PropertyAction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: const AssetImage("assets/images/house.jpeg"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(children: [
                            Text("Full House", style: GoogleFonts.montserrat()),
                            const Logo(
                                imageUrl: 'assets/images/address-location.png',
                                height: 50,
                                width: 50),
                          ]),
                          Column(children: [
                            Text("13 Salcombe Close\nBradfield\nBulawayo",
                                style: GoogleFonts.montserrat()),
                          ])
                        ],
                      ),
                      Column(children: [
                        Text("6 ROOMS",
                            style: GoogleFonts.montserrat(
                                color: ColorConstants.yellow, fontSize: 35)),
                        Text("Small family with no pets",
                            style: GoogleFonts.montserrat()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              ignoreGestures: true,
                              unratedColor: ColorConstants.grey,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
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
                        )
                      ]),
                      const SizedBox(height: 15),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Column(children: [
                          Text(
                            "OCCUPATION DATE",
                            style: GoogleFonts.montserrat(
                                color: ColorConstants.yellow, fontSize: 10),
                            textAlign: TextAlign.right,
                          ),
                          Text("01/01/2023",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(
                            "APPOINTMENT DATE",
                            style: GoogleFonts.montserrat(
                                color: ColorConstants.yellow, fontSize: 10),
                            textAlign: TextAlign.right,
                          ),
                          Text("20/10/2022  10:00am",
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
                              children: const [
                                Text("Solar"),
                                SizedBox(height: 10),
                                Text("Borehole"),
                                SizedBox(height: 10),
                                Text("Deposit required"),
                                SizedBox(height: 10),
                                Text("Rent Includes water"),
                                SizedBox(height: 10),
                                Text("Rent Includes electricity"),
                                SizedBox(width: 20),
                              ]),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Logo(
                                imageUrl: 'assets/images/phone.png',
                                color: Colors.blue,
                                height: 20,
                                width: 20),
                            Text("077777777")
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
                                  "\$450.00",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                CustomElevateButton(
                                  name: "ACTIONS",
                                  color: ColorConstants.yellow,
                                  onSubmit: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ActionsOptions()));
                                  },
                                ),
                              ],
                            )
                          ])
                    ],
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
