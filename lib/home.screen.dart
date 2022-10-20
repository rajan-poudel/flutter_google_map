import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

const LatLng currentLocation = LatLng(27.7172, 85.3240);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _googleMapController;
  final Map<String, Marker> _marker = {};
  LocationData? locationData;

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      locationData = location;
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: currentLocation,
          zoom: 14.0,
        ),
        onMapCreated: (controller) {
          _googleMapController = controller;
          addMarker("test", currentLocation);
        },
        markers: _marker.values.toSet(),
      ),
    );
  }

  void addMarker(String id, LatLng location) {
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: const InfoWindow(
            title: "Current location", snippet: "description"));
    _marker[id] = marker;
    setState(() {});
  }
}
