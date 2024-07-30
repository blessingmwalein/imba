import 'package:flutter/material.dart';

import '../../utilities/constants.dart';
import 'custom_elevated_button.dart';
import 'logo.dart';

class CustomSearchListView extends StatelessWidget {
  final bool isSearch;

  const CustomSearchListView({Key? key, required this.isSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: null,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(children: [
                Expanded(
                    child: Column(children: const [
                  Logo(
                      imageUrl: 'assets/images/houseicon.png',
                      height: 100,
                      width: 100)
                ])),
                Expanded(
                  child: Column(children: const [
                    Text("Cottage",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("Bradfield"),
                    Text("Bulawayo")
                  ]),
                ),
                Expanded(
                    child: Column(children: const [
                  Text("2 Rooms",
                      style: TextStyle(color: ColorConstants.yellow))
                ])),
                Expanded(
                    child: Column(children: [
                  const Text("\$200",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  CustomElevateButton(
                    name: isSearch ? "VIEW" : "RESERVE",
                    color: Colors.black,
                    fontSize: 10,
                    onSubmit: () {
                      //         Navigator.push(
                      // context,
                      // MaterialPageRoute(builder: (context) => isSearch? const PropertyDetails(): const Appointment(action: 'CREATE',)));
                    },
                  )
                ]))
              ]),
            );
          }),
    );
  }
}
