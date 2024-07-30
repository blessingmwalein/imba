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
import '../widgets/logo.dart';
import 'home.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  final SecureStorageManager _secureStorageManager = SecureStorageManager();

  late TermsBloc termsBloc;

  @override
  void initState() {
    termsBloc = BlocProvider.of<TermsBloc>(context);
    termsBloc.add(GetTermsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                color: ColorConstants.yellow,
                child: const Logo(
                    imageUrl: 'assets/images/home_icon.png',
                    color: Colors.black,
                    height: 100,
                    width: 100)),
            const SizedBox(height: 10),
            Text("TERMS AND CONDITIONS",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(child:
                      BlocBuilder<TermsBloc, TermsState>(
                          builder: (context, state) {
                    if (state is GetTermsLoadingState) {
                      return const LoadingIndicator();
                    } else if (state is GetTermsSuccessState) {
                      return Text(state.terms);
                    } else if (state is AcceptTermsSuccessState) {
                      _secureStorageManager.setIsAcceptedTerms(
                          isAccepted: "true");
                      WidgetsBinding.instance?.addPostFrameCallback((_) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      });
                    } else if (state is GetTermsFailedState) {
                      return CustomElevateButton(
                        name: 'Retry',
                        color: Colors.black,
                        onSubmit: () {
                          termsBloc.add(GetTermsEvent());
                        },
                      );
                    }
                    return const LoadingIndicator();
                  })),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            CustomElevateButton(
              name: 'ACCEPT',
              color: Colors.black,
              onSubmit: () {
                termsBloc.add(AcceptTermsEvent());
              },
            )
          ],
        ),
      )),
    );
  }
}
