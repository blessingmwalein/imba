import 'package:flutter/material.dart';

import '../../utilities/constants.dart';
import 'logo.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? elevation;

  const CustomAppBar({
    Key? key,
    required this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left, color: Colors.black),
        ),
        backgroundColor: ColorConstants.yellow,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: elevation!,
        title: const Logo(
            imageUrl: 'assets/images/search.png',
            color: Colors.black,
            height: 200,
            width: 100));
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
