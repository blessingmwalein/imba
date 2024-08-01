import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/ui/screens/appointment.dart';

import '../../bloc/upload/upload_bloc.dart';
import '../../bloc/upload/upload_event.dart';
import '../../data/models/house_response.dart';
import '../../utilities/constants.dart';
import '../screens/edit_property.dart';
import '../screens/property_details.dart';
import 'custom_elevated_button.dart';
import 'logo.dart';

class CustomListView extends StatelessWidget {
  final List<HouseResponse> uploadsResponse;
  final String? isPage;

  const CustomListView({Key? key, required this.uploadsResponse, this.isPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: uploadsResponse.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildUploadsList(context, index, uploadsResponse, isPage);
        },
      ),
    );
  }

  Widget _buildUploadsList(
    BuildContext context, int index, List<HouseResponse> uploadsResponse, String? isPage) {
  final house = uploadsResponse[index];

  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0), // Rounded corners
      border: Border.all(color: Colors.grey.withOpacity(0.6), width: 0.8),  // Grey outline
    ),
    child: Row(
      children: [
        _buildImageColumn(context, house),
        _buildDetailsColumn(context, house),
        _buildActionColumn(context, house, isPage),
      ],
    ),
  );
}


  Widget _buildImageColumn(BuildContext context, HouseResponse house) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _navigateToPropertyDetails(context, house),
        child: const Logo(
          imageUrl: 'assets/images/houseicon.png',
          height: 100,
          width: 100,
        ),
      ),
    );
  }

  Widget _buildDetailsColumn(BuildContext context, HouseResponse house) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _navigateToPropertyDetails(context, house),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(house.type, style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w700)),
            SizedBox(height: 5),

            Text(house.area, style: GoogleFonts.montserrat(color: Colors.black54, fontSize: 15)),
            const SizedBox(height: 5),
            Text(house.city, style: GoogleFonts.montserrat(color: Colors.black54, fontSize: 15)),
            const SizedBox(height: 5),
            Text("${house.numberRooms} rooms", style: GoogleFonts.montserrat(color: Colors.orange, fontSize: 15)),

          ],
        ),
      ),
    );
  }


  Widget _buildActionColumn(BuildContext context, HouseResponse house, String? isPage) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("${house.currency}${house.rent}", style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700)),
            _buildActionButton(context, house, isPage),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, HouseResponse house, String? isPage) {
    if (isPage == "viewed") {
      return CustomElevateButton(
        name: "Reserve",
        color: Colors.black,
        fontSize: 10,
        onSubmit: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Appointment(
                  houseId: house.id,
                  action: "UPDATE",
                ),
              ),
            );
          });
        },
      );
    }

    return CustomElevateButton(
      name: house.activated ? "Edit" : "Activate",
      color: Colors.black,
      fontSize: 10,
      onSubmit: () {
        house.activated ? _navigateToEditProperty(context, house) : _navigateToPropertyDetails(context, house);
      },
    );
  }

  void _navigateToPropertyDetails(BuildContext context, HouseResponse house) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyDetails(id: house.id, flag: "viewed"),
        settings: const RouteSettings(name: 'SecondPage'),
      ),
    ).then((value) => BlocProvider.of<UploadBloc>(context).add(GetHouseByIdEvent(houseId: house.id)));
  }

  void _navigateToEditProperty(BuildContext context, HouseResponse house) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProperty(
            houseId: house.id,
            deposit: house.deposit,
            occupationDate: house.occupationDate.toString(),
            occupied: house.occupied,
            rent: house.rent,
          ),
        ),
      );
    });
  }
}
