import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imba/bloc/lease/lease_bloc.dart';
import 'package:imba/bloc/lease/lease_event.dart';
import 'package:imba/data/models/lease_agreement.dart';

import '../../bloc/appointment/appointment_bloc.dart';
import '../../utilities/constants.dart';
import '../screens/lease_agreement_edit.dart';
import 'custom_elevated_button.dart';
import 'logo.dart';

class LeaseAgreementListview extends StatefulWidget {
  final List<LeaseAgreement> leaseAgreement;
  const LeaseAgreementListview({Key? key, required this.leaseAgreement}) : super(key: key);

  @override
  State<LeaseAgreementListview> createState() => _LeaseAgreementListviewState();
}

class _LeaseAgreementListviewState extends State<LeaseAgreementListview> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding:  const EdgeInsets.fromLTRB(0,0,0, 24.0),
        child:widget.leaseAgreement.isNotEmpty? ListView.builder(
            shrinkWrap: true,
            itemCount: widget.leaseAgreement.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Row(children: [
                  Expanded(
                      child: Column(children: [
                    Logo(
                        imageUrl: 'assets/images/paper.png',
                        color: Colors.black,
                        width: 70.sp,
                        height: 70)
                  ])),
                  Expanded(
                    child: Column(children: [
                      Text("${widget.leaseAgreement[index].house?.id.toString()}" +" "+"${widget.leaseAgreement[index].house?.area}\n ${widget.leaseAgreement[index].house?.city}",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              color: ColorConstants.yellow)),
                    ]),
                  ),
                  Expanded(
                      child: Column(children: [
                    Text("${widget.leaseAgreement[index].leaseId}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat")),
                    CustomElevateButton(
                      name: "GENERATE",
                      color: Colors.black,
                      fontSize: 15.sp,
                      onSubmit: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                     LeaseAgreementEdit(leaseId:widget.leaseAgreement[index].leaseId!,noticeTerms: widget.leaseAgreement[index].noticeTerms!, maintenanceTerms: widget.leaseAgreement[index].maintenanceTerms!,rentPaymentTerms: widget.leaseAgreement[index].rentPaymentTerms!,
                                        leasePeriod: widget.leaseAgreement[index].leasePeriod!, houseId: widget.leaseAgreement[index].house!.id!, landLordPhone: widget.leaseAgreement[index].landLord!, tenantPhone: widget.leaseAgreement[index].tenant!,)));
                        BlocProvider.of<LeaseBloc>(context).add(InterestsResetEvent());
                      },
                    )
                  ])),
                ]),
              );
            }):const Center(child: Text("Nothing here")),
      ),
    );
  }
}
