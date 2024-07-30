import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imba/bloc/upload/upload_bloc.dart';
import 'package:imba/bloc/upload/upload_event.dart';
import 'package:imba/ui/screens/uploads.dart';

import '../../bloc/upload/upload_state.dart';
import '../../utilities/constants.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/logo.dart';

class UploadImages extends StatefulWidget {
  final int houseId;
  final String type;
  final String homeAddress;

  const UploadImages(
      {Key? key,
      required this.houseId,
      required this.type,
      required this.homeAddress})
      : super(key: key);

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  bool isVisible = false;

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage(
        maxHeight: 200, maxWidth: 200, imageQuality: 50);
    if (selectedImages!.isNotEmpty) {
      setState(() {
        isVisible = true;
      });

      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

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
              width: 100,
              color: ColorConstants.grey,
              child: Text("UPLOAD PICTURES",
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(widget.houseId.toString(),
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      decoration: TextDecoration.none,
                      color: ColorConstants.yellow,
                    ))
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: const [
                    Text("Images",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ]),
                  Column(
                    children: [
                      CustomElevateButton(
                        name: 'Browse',
                        color: ColorConstants.yellow,
                        onSubmit: () {
                          selectImages();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Row(children: [
                imageFileList!.isEmpty
                    ? Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 400,
                                  width: MediaQuery.of(context).size.width,
                                  child: const Center(child: Text('NO IMAGES')))
                            ]),
                      )
                    : Expanded(
                        child: Visibility(
                          visible: isVisible,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: SizedBox(
                                height: 400,
                                width: MediaQuery.of(context).size.width,
                                child: GridView.builder(
                                    itemCount: imageFileList!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Stack(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 250.0,
                                              height: 320.0,
                                              child: Image.file(
                                                File(
                                                    imageFileList![index].path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              right: 5.0,
                                              child: InkWell(
                                                child: const Icon(
                                                  Icons.remove_circle,
                                                  size: 30,
                                                  color: Colors.red,
                                                ),
                                                // This is where the _image value sets to null on tap of the red circle icon
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      imageFileList
                                                          ?.removeAt(index);
                                                    },
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ),
                      ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                CustomElevateButton(
                  name: 'SKIP',
                  color: Colors.black,
                  onSubmit: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UploadsList()));
                  },
                ),
                SizedBox(
                  width: 150,
                  child: BlocListener<UploadBloc, UploadState>(
                    listener: (context, state) {
                      if (state is UploadHouseSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('success'),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UploadsList()));
                      }
                      if (state is UploadFailedState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('failed to upload pics'),
                          duration: const Duration(seconds: 1),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                      }
                    },
                    child: BlocBuilder<UploadBloc, UploadState>(
                        builder: (context, state) {
                      if (state is UploadLoadingState) {
                        return const LoadingIndicator();
                      }
                      if (state is UploadImagesSuccessState) {
                        SchedulerBinding.instance!.addPostFrameCallback((_) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UploadsList()));
                        });
                      }
                      return CustomElevateButton(
                        name: 'UPLOAD',
                        color: ColorConstants.yellow,
                        onSubmit: () {
                          BlocProvider.of<UploadBloc>(context).add(
                              UploadHousePicsEvent(
                                  houseId: widget.houseId,
                                  title: widget.type,
                                  description: widget.homeAddress,
                                  imagesPath: imageFileList!));
                        },
                      );
                    }),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
