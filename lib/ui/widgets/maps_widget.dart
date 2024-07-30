import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double longitude;
  final double latitude;

  const MapScreen({Key? key, required this.longitude, required this.latitude});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/images/marker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    LatLng initialLocation = LatLng(widget.latitude, widget.longitude);
    //  LatLng initialLocation =  const LatLng(-17.832346, 31.047680);
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("propertyLocation"),
            position: LatLng(widget.latitude, widget.longitude),
            draggable: true,
            onDragEnd: (value) {
              // value is the new position
            },
            // icon: markerIcon,
            icon: BitmapDescriptor.defaultMarker,
          ),
        },
      ),
    );
  }
}
