import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(33.8547, 35.8623);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        onTap: (argument) {
          //print(argument.latitude);
        },
        initialCameraPosition: CameraPosition(target: _center, zoom: 11),
        markers: {
          Marker(
            markerId: MarkerId("1"),
            position: _center,
            infoWindow: InfoWindow(title: 'hanan', snippet: 'hello hanan'),
            onTap: () => {},
          ),
        },
      ),
    );
  }
}
