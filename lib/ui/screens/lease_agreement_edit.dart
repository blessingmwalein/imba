import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/bloc/lease/lease_bloc.dart';
import 'package:imba/bloc/lease/lease_event.dart';
import 'package:imba/bloc/lease/lease_state.dart';
import 'package:imba/ui/widgets/custom_elevated_button.dart';

import '../../utilities/constants.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/logo.dart';
import '../widgets/multiline_textfiled.dart';
import '../widgets/property_error_widget.dart';

class LeaseAgreementEdit extends StatefulWidget {
  final String maintenanceTerms;
  final String noticeTerms;
  final String leasePeriod;
  final String rentPaymentTerms;
  final String tenantPhone;
  final String landLordPhone;
  final int leaseId;
  final int houseId;

  const LeaseAgreementEdit(
      {Key? key,
      required this.maintenanceTerms,
      required this.noticeTerms,
      required this.leasePeriod,
      required this.rentPaymentTerms,
      required this.leaseId,
      required this.houseId,
      required this.tenantPhone,
      required this.landLordPhone})
      : super(key: key);

  @override
  State<LeaseAgreementEdit> createState() => _LeaseAgreementEditState();
}

class _LeaseAgreementEditState extends State<LeaseAgreementEdit> {
  final _maintenanceController = TextEditingController();
  final _noticeController = TextEditingController();
  final _periodController = TextEditingController();
  final _feesController = TextEditingController();
  final _landlordController = TextEditingController();
  final _tenantController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _maintenanceController.text = widget.maintenanceTerms;
    _noticeController.text = widget.noticeTerms;
    _feesController.text = widget.rentPaymentTerms;
    _periodController.text = widget.leasePeriod;

    _landlordController.text = widget.landLordPhone;
    _tenantController.text = widget.tenantPhone;
    super.initState();
  }

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Container(
                width: 300,
                color: ColorConstants.grey,
                child: Text("LEASE AGREEMENT",
                    style: GoogleFonts.montserrat(
                        fontSize: 20.sp,
                        decoration: TextDecoration.none,
                        color: ColorConstants.yellow))),
            actions: [
              IconButton(
                icon: const Logo(
                  imageUrl: 'assets/images/houseicon.png',
                ),
                iconSize: 100,
                onPressed: () {},
              )
            ]),
        body: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 1000,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.leaseId.toString(),
                        style: TextStyle(
                            color: ColorConstants.yellow,
                            fontSize: 20.sp,
                            fontFamily: 'Montserrat'),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text("Maintenance",
                            style: GoogleFonts.montserrat(
                                fontSize: 14.sp, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        CustomMultiLineTexField(
                          controller: _maintenanceController,
                          lines: 3,
                        ),
                        SizedBox(height: 10.sp),
                        Text("Notice",
                            style: GoogleFonts.montserrat(
                                fontSize: 14.sp, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        CustomMultiLineTexField(
                          controller: _noticeController,
                          lines: 2,
                        ),
                        SizedBox(height: 10.sp),
                        Text("Period",
                            style: GoogleFonts.montserrat(
                                fontSize: 14.sp, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _periodController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              filled: true,
                              fillColor: ColorConstants.grey),
                        ),
                        const SizedBox(height: 10),
                        Text("Fees",
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        CustomMultiLineTexField(
                          controller: _feesController,
                          lines: 2,
                        ),
                      ]),
                  const SizedBox(height: 30),
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: Text("Landlord",
                            style: GoogleFonts.montserrat(
                                fontSize: 14.sp, fontWeight: FontWeight.bold))),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        readOnly: true,
                        controller: _landlordController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            filled: true,
                            fillColor: ColorConstants.grey),
                      ),
                    )
                  ]),
                  const SizedBox(height: 30),
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: Text("Tenant",
                            style: GoogleFonts.montserrat(
                                fontSize: 14.sp, fontWeight: FontWeight.bold))),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        readOnly: true,
                        controller: _tenantController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            filled: true,
                            fillColor: ColorConstants.grey),
                      ),
                    )
                  ]),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocListener<LeaseBloc, LeaseState>(
                        listener: (context, state) {
                          if (state is LeaseUpdateSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Lease info updated'),
                              duration: const Duration(seconds: 3),
                              action: SnackBarAction(
                                label: '',
                                onPressed: () {},
                              ),
                            ));
                          }
                          if (state is UpdateFailedState) {
                            if (state.message.contains("not registered")) {
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
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PropertyError(
                                          errorMessage: state.message)));
                            }
                          }
                        },
                        child: BlocBuilder<LeaseBloc, LeaseState>(
                            builder: (context, state) {
                          if (state is UpdateLoadingState) {
                            return const LoadingIndicator();
                          }
                          if (state is LeaseUpdateSuccessState) {
                            BlocProvider.of<LeaseBloc>(context)
                                .add(GetInterestsEvent());
                            // BlocProvider.of<LeaseBloc>(context).add(InterestsResetEvent());
                          }
                          return CustomElevateButton(
                              onSubmit: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<LeaseBloc>(context)
                                      .add(UpdateLeaseEvent(
                                    maintenance: _maintenanceController.text,
                                    notice: _noticeController.text,
                                    period: _periodController.text,
                                    fees: _feesController.text,
                                    landLordPhone: _landlordController.text,
                                    tenantPhone: _tenantController.text,
                                    houseId: widget.houseId,
                                    leaseId: widget.leaseId,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        const Text('Fill out missing fields'),
                                    duration: const Duration(seconds: 2),
                                    action: SnackBarAction(
                                      label: '',
                                      onPressed: () {},
                                    ),
                                  ));
                                }
                              },
                              name: 'CREATE',
                              color: ColorConstants.yellow);
                        }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
