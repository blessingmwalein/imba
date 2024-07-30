import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/bloc/views/views_state.dart';

import '../../bloc/views/views_bloc.dart';
import '../../bloc/views/views_event.dart';
import '../../data/models/house_response.dart';
import '../../utilities/constants.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_listview.dart';
import '../widgets/loading_indicator.dart';

class Viewed extends StatefulWidget {
  const Viewed({Key? key}) : super(key: key);

  @override
  State<Viewed> createState() => _ViewedState();
}

class _ViewedState extends State<Viewed> {
  @override
  void initState() {
    BlocProvider.of<ViewedBloc>(context).add(GetViewedEvent());
    super.initState();
  }

  List<HouseResponse> resp = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Viewed",
                  style: GoogleFonts.montserrat(
                      fontSize: 20.sp,
                      decoration: TextDecoration.none,
                      color: ColorConstants.yellow,
                      fontWeight: FontWeight.bold),
                ),
                Stack(children: const [
                  Divider(),
                  SizedBox(
                      width: 50,
                      child: Divider(thickness: 5, color: Colors.black))
                ]),
                BlocListener<ViewedBloc, ViewedState>(
                  listener: (context, state) {
                    if (state is ViewedSuccessState) {
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
                    if (state is ViewedFailedState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('failed to load'),
                        duration: const Duration(seconds: 1),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      ));

                      BlocProvider.of<ViewedBloc>(context)
                          .add(ViewedResetEvent());
                    }
                  },
                  child: BlocBuilder<ViewedBloc, ViewedState>(
                      builder: (context, state) {
                    if (state is ViewedLoadingState) {
                      return const LoadingIndicator();
                    }
                    if (state is ViewedSuccessState) {
                      resp = state.viewedResponse;

                      return state.viewedResponse.isEmpty
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
                          : CustomListView(
                              uploadsResponse: state.viewedResponse,
                              isPage: "viewed");
                    }
                    if (state is ViewedFailedState) {
                      return Container(
                        height: 500,
                        width: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text(state.message)),
                            CustomElevateButton(
                                onSubmit: () {
                                  BlocProvider.of<ViewedBloc>(context)
                                      .add(GetViewedEvent());
                                },
                                color: ColorConstants.yellow,
                                name: "Retry")
                          ],
                        ),
                      );
                    }

                    return CustomListView(
                        uploadsResponse: resp, isPage: "viewed");
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
