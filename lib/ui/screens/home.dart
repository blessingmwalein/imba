import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/bloc/upload/upload_event.dart';
import 'package:imba/bloc/upload/upload_state.dart';
import 'package:imba/bloc/user/user_bloc.dart';
import 'package:imba/bloc/user/user_event.dart';
import 'package:imba/ui/screens/search_page.dart';
import 'package:imba/ui/screens/upload_details.dart';

import '../../bloc/upload/upload_bloc.dart';
import '../../utilities/constants.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_home_drawer.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/logo.dart';
import '../widgets/opaque_container.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late UploadBloc uploadBloc;

  late UserBloc userBloc;
  List<String> types = [];
  List<String> classifications = [];
  var isSuccess = false;

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    uploadBloc = BlocProvider.of<UploadBloc>(context);
    uploadBloc.add(FetchTypesEvent());
    uploadBloc.add(FetchClassificationsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.yellow,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: ColorConstants.yellow,
      endDrawer:
          Visibility(visible: isSuccess, child: const CustomHomeDrawer()),
      body: Column(
        children: [
          const Expanded(
            flex: 4,
            child: SizedBox(
                child: Logo(
                    imageUrl: 'assets/images/home_icon.png',
                    color: Colors.black)),
          ),
          const Expanded(
              flex: 2,
              child: CustomOpaqueContainer(
                  // name: "IMBA",
                  name: "NYUMBA",
                  googleFontStyle: TextStyle(
                      fontFamily: 'Antreas',
                      fontSize: 80,
                      fontWeight: FontWeight.bold))),
          Visibility(
              visible: true,
              child: Container(
                child: BlocListener<UploadBloc, UploadState>(
                    listener: (context, state) {
                  if (state is TypesSuccessState) {
                    print("types" + state.types.toString());
                    types = state.types.types;
                  }

                  if (state is ClassificationsSuccessState) {
                    classifications = state.classifications.classifications;
                    setState(() {
                      isSuccess = true;
                    });
                  }
                }, child: BlocBuilder<UploadBloc, UploadState>(
                        builder: (context, state) {
                  if (state is UploadLoadingState) {
                    return const LoadingIndicator();
                  }
                  return const LoadingIndicator();
                })),
              )),
          Visibility(
            visible: isSuccess,
            child: Expanded(
              flex: 3,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomElevateButton(
                      name: 'Upload',
                      color: Colors.black,
                      onSubmit: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UploadDetails(
                                types: types,
                                classifications: classifications)));
                      },
                    ),
                    CustomElevateButton(
                      name: 'Search',
                      color: Colors.black,
                      onSubmit: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                    types: types,
                                    classifications: classifications)));
                      },
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
