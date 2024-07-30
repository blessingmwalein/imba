import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imba/bloc/user/user_bloc.dart';
import 'package:imba/bloc/user/user_event.dart';
import 'package:imba/ui/screens/appointments_infinite.dart';
import 'package:imba/ui/screens/lease_agreements.dart';
import 'package:imba/ui/screens/uploads.dart';

import '../screens/appointment_list.dart';
import '../screens/register.dart';
import '../screens/viewed.dart';
import 'custom_textbutton.dart';

class CustomHomeDrawer extends StatelessWidget {
  const CustomHomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.black,
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(
              //   flex:1,
              //   child: Column(
              //     children: const [

              //         // Logo(imageUrl: 'assets/images/houseicon.png', height:100, width: 100),
              //     ],
              //   ),
              // ),
              Expanded(
                flex: 3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CustomTextButton(
                        color: Colors.white,
                        fontSize: 16.sp,
                        name: 'Appointments',
                        onSubmit: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AppointmentInfinite()));
                        },
                      ),
                      CustomTextButton(
                        color: Colors.white,
                        fontSize: 16.sp,
                        name: 'Lease Agreements',
                        onSubmit: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LeaseAgreements()));
                        },
                      ),
                      CustomTextButton(
                        color: Colors.white,
                        fontSize: 16.sp,
                        name: 'Uploads',
                        onSubmit: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UploadsList()));
                        },
                      ),
                      CustomTextButton(
                        color: Colors.white,
                        fontSize: 16.sp,
                        name: 'Views',
                        onSubmit: () {
                                Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => const Viewed()));
                        },
                      ),
                      CustomTextButton(
                        color: Colors.white,
                        fontSize: 16.sp,
                        name: 'Profile',
                        onSubmit: () {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        },
                      ),
                    ]),
              ),
            ],
          ),
        ));
  }
}
