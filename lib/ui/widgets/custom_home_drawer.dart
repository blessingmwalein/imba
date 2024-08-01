import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/ui/screens/appointments_infinite.dart';
import 'package:imba/ui/screens/lease_agreements.dart';
import 'package:imba/ui/screens/uploads.dart';

import '../screens/register.dart';
import '../screens/viewed.dart';

class CustomHomeDrawer extends StatelessWidget {
  const CustomHomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    // User avatar
                    
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 35, // Adjust the size as needed
                      backgroundImage: AssetImage('assets/images/avatar.jpg',),
                    ),
                    const SizedBox(width: 10),
                    // User email and edit icon
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'First Name', // Replace with user's email
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'user@example.com', // Replace with user's email
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Appointments',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AppointmentInfinite()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.assignment_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Lease Agreements',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LeaseAgreements()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.cloud_upload_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Uploads',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadsList()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.visibility_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Views',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Viewed()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                title: Text(
                  'Profile',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Register()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
