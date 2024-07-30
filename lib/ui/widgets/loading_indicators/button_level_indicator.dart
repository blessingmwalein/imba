import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imba/utilities/constants.dart';

class ButtonLoadingIndicator extends StatelessWidget {
  const ButtonLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: const Center(
                child: SpinKitDoubleBounce(color: ColorConstants.yellow))));
  }
}
