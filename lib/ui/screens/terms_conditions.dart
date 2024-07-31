import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imba/bloc/terms_conditions/terms_events.dart';
import 'package:imba/ui/widgets/loading_indicator.dart';
import 'package:imba/utilities/constants.dart';

import '../../bloc/terms_conditions/terms_bloc.dart';
import '../../bloc/terms_conditions/terms_state.dart';
import '../../secure_storage/secure_storage_manager.dart';
import '../widgets/custom_elevated_button.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  final SecureStorageManager _secureStorageManager = SecureStorageManager();

  late TermsBloc _termsBloc;

  @override
  void initState() {
    super.initState();
    _termsBloc = BlocProvider.of<TermsBloc>(context);
    _termsBloc.add(GetTermsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.h),
                child: Icon(
                  Icons.article, // Icon representing terms and conditions
                  size: 100.sp,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Terms and Conditions",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Please read and accept our terms and conditions to proceed.",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BlocBuilder<TermsBloc, TermsState>(
                    builder: (context, state) {
                      if (state is GetTermsLoadingState) {
                        return const LoadingIndicator();
                      } else if (state is GetTermsSuccessState) {
                        return SingleChildScrollView(
                          child: Text(
                            state.terms,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                        );
                      } else if (state is AcceptTermsSuccessState) {
                        _secureStorageManager.setIsAcceptedTerms(
                            isAccepted: "true");
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushReplacementNamed(context, '/home');
                        });
                      } else if (state is GetTermsFailedState) {
                        return Center(
                          child: CustomElevateButton(
                            name: 'Retry',
                            color: Colors.black,
                            onSubmit: () {
                              _termsBloc.add(GetTermsEvent());
                            },
                          ),
                        );
                      }
                      return const LoadingIndicator();
                    },
                  ),
                ),
              ),
              // SizedBox(height: 20.h),
              CustomElevateButton(
                name: 'ACCEPT',
                color: Colors.black,
                onSubmit: () {
                  _termsBloc.add(AcceptTermsEvent());
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
