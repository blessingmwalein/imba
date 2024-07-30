import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imba/bloc/lease/lease_state.dart';
import 'package:imba/data/models/lease_agreement.dart';
import 'package:imba/ui/widgets/property_error_widget.dart';

import '../../bloc/lease/lease_bloc.dart';
import '../../bloc/lease/lease_event.dart';
import '../../utilities/constants.dart';
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
  List<LeaseAgreement> resp = [];
  String message = "";

  @override
  void initState() {
    BlocProvider.of<LeaseBloc>(context).add(GetInterestsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "LEASE AGREEMENTS",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"),
                textAlign: TextAlign.start,
              ),
            ),
            const Divider(),
            BlocListener<LeaseBloc, LeaseState>(
              listener: (context, state) {
                if (state is LeaseSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('loaded'),
                    duration: const Duration(seconds: 1),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {},
                    ),
                  ));
                  // BlocProvider.of<UploadBloc>(context).add(ResetUploadsEvent());
                }
                if (state is LeaseFailedState) {
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PropertyError(errorMessage: state.message)));
                  });

                  BlocProvider.of<LeaseBloc>(context)
                      .add(InterestsResetEvent());
                }
              },
              child:
                  BlocBuilder<LeaseBloc, LeaseState>(builder: (context, state) {
                if (state is LeaseLoadingState) {
                  return const LoadingIndicator();
                }
                if (state is LeaseSuccessState) {
                  resp = state.leaseAgreement;

                  return state.leaseAgreement.isEmpty
                      ? Container(
                          height: 500,
                          width: 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Center(child: Text("Nothing here")),
                            ],
                          ),
                        )
                      // : CustomListView(
                      // uploadsResponse: state.uploadsResponse, isPage: "uploads");
                      : LeaseAgreementListview(
                          leaseAgreement: resp,
                        );
                }
                if (state is LeaseFailedState) {
                  message = state.message;
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PropertyError(errorMessage: state.message)));
                  });
                }

                return LeaseAgreementListview(
                  leaseAgreement: resp,
                );
              }),
            ),
            // const LeaseAgreementListview()
          ],
        )));
  }
}
