import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imba/utilities/constants.dart';

class LoadingIndicator extends StatelessWidget {
  final String? page;

  const LoadingIndicator({Key? key, this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: page == "splash"
                ? const Text("Initializing...")
                : const Center(
                    child: SpinKitFadingCircle(color: ColorConstants.yellow))));
  }
}
