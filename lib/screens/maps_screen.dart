import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:go_frontend_mobile/providers/destination_provider.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController mapController;
  final LatLng _defaultCenter = const LatLng(33.8547, 35.8623);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DestinationProvider>(
        context,
        listen: false,
      ).fetchAllDestinations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final destinationProvider = Provider.of<DestinationProvider>(context);
    final Set<Marker> markers = {};

    for (var destination in destinationProvider.destinations) {
      final latStr = destination["latitude"];
      final lngStr = destination["longitude"];

      if (latStr != null && lngStr != null) {
        final double? lat = double.tryParse(latStr.toString());
        final double? lng = double.tryParse(lngStr.toString());

        if (lat != null && lng != null) {
          markers.add(
            Marker(
              markerId: MarkerId(destination["id"].toString()),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(
                title: destination["business_name"] ?? "Unknown",
                snippet: destination["category_name"] ?? "No category info",
                onTap: () {
                  log("InfoWindow tapped: ${destination["business_name"]}");
                  context.go(
                    ConfigRoutes.detailedDestination,
                    extra: {
                      "imageUrl":
                          destination["main_img"] ??
                          "https://images.unsplash.com/photo-1726064855757-ac8720008fe0?q=80",
                      "name": destination["business_name"] ?? "Unknown",
                      "description":
                          destination["description"] ??
                          "No description available",
                      "rating":
                          (destination["rating"] as num?)?.toDouble() ?? 0.0,
                      "district": destination["district"] ?? "",
                      "userid": destination["user_id"],
                    },
                  );
                },
              ),
            ),
          );
        }
      }
    }

    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(target: _defaultCenter, zoom: 11),
        markers: markers,
      ),
    );
  }
}
