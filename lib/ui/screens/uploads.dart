import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/bloc/upload/upload_event.dart';
import 'package:imba/data/models/house_response.dart';

import '../../bloc/upload/upload_bloc.dart';
import '../../bloc/upload/upload_state.dart';
import '../../utilities/constants.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_listview.dart';
import '../widgets/loading_indicator.dart';

class UploadsList extends StatefulWidget {
  const UploadsList({Key? key}) : super(key: key);

  @override
  State<UploadsList> createState() => _UploadsListState();
}

class _UploadsListState extends State<UploadsList> {
  List<HouseResponse> resp = [];

  @override
  void initState() {
    BlocProvider.of<UploadBloc>(context).add(GetUploadsEvent());
    BlocProvider.of<UploadBloc>(context).add(ResetUploadsEvent());
    super.initState();
  }

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
                  "UPLOADS",
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
                BlocListener<UploadBloc, UploadState>(
                  listener: (context, state) {
                    if (state is GetUploadsSuccessState) {
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
                    if (state is UploadFailedState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('failed to load'),
                        duration: const Duration(seconds: 1),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      ));

                      BlocProvider.of<UploadBloc>(context)
                          .add(ResetUploadsEvent());
                    }
                  },
                  child: BlocBuilder<UploadBloc, UploadState>(
                      builder: (context, state) {
                    if (state is UploadLoadingState) {
                      return const LoadingIndicator();
                    }
                    if (state is GetUploadsSuccessState) {
                      resp = state.uploadsResponse;

                      return state.uploadsResponse.isEmpty
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
                              uploadsResponse: state.uploadsResponse,
                              isPage: "uploads");
                    }
                    if (state is UploadFailedState) {
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
                                  BlocProvider.of<UploadBloc>(context)
                                      .add(GetUploadsEvent());
                                },
                                color: ColorConstants.yellow,
                                name: "Retry")
                          ],
                        ),
                      );
                    }

                    return CustomListView(
                        uploadsResponse: resp, isPage: "uploads");
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
