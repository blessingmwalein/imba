import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:imba/bloc/lease/lease_bloc.dart';
import 'package:imba/bloc/lease/lease_event.dart';
import 'package:imba/bloc/lease/lease_state.dart';
import 'package:imba/data/models/lease_agreement.dart';
import 'package:imba/ui/layouts/home_layout.dart';
import 'package:imba/ui/widgets/property_error_widget.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/lease_agreements_listview.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/logo.dart';

class LeaseAgreements extends StatefulWidget {
  const LeaseAgreements({Key? key}) : super(key: key);

  @override
  State<LeaseAgreements> createState() => _LeaseAgreementsState();
}

class _LeaseAgreementsState extends State<LeaseAgreements> {
  List<LeaseAgreement> leaseAgreements = [];
  String errorMessage = "";

  @override
  void initState() {
    BlocProvider.of<LeaseBloc>(context).add(GetInterestsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
      hasBack: true,
      title: "Lease Agreements",

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         
            BlocListener<LeaseBloc, LeaseState>(
              listener: (context, state) {
                if (state is LeaseSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Loaded successfully'),
                    duration: Duration(seconds: 1),
                  ));
                } else if (state is LeaseFailedState) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyError(
                          errorMessage: state.message,
                        ),
                      ),
                    );
                  });
                  BlocProvider.of<LeaseBloc>(context).add(InterestsResetEvent());
                }
              },
              child: BlocBuilder<LeaseBloc, LeaseState>(
                builder: (context, state) {
                  if (state is LeaseLoadingState) {
                    return const LoadingIndicator();
                  } else if (state is LeaseSuccessState) {
                    leaseAgreements = state.leaseAgreement;
                    if (leaseAgreements.isEmpty) {
                      return _buildEmptyState();
                    } else {
                      return LeaseAgreementListview(
                        leaseAgreement: leaseAgreements,
                      );
                    }
                  } else if (state is LeaseFailedState) {
                    errorMessage = state.message;
                    return _buildErrorState(errorMessage);
                  }

                  return LeaseAgreementListview(
                    leaseAgreement: leaseAgreements,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return  SizedBox(
      height: 500,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.hourglass_empty_outlined, size: 100, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            "Nothing here",
            style:GoogleFonts.montserrat(
              color: Colors.grey,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 100, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomElevateButton(
            onSubmit: () {
              BlocProvider.of<LeaseBloc>(context).add(GetInterestsEvent());
            },
            color: Colors.yellow,
            name: "Retry",
          ),
        ],
      ),
    );
  }
}
