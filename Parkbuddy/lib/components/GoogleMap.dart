import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({Key? key}) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Completer<GoogleMapController> _mapController = Completer();
  Location _locationService = Location();
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check if location service is enabled
    _serviceEnabled = await _locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationService.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Request permission to access location
    _permissionGranted = await _locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Get the current location and update the map
    LocationData locationData = await _locationService.getLocation();
    setState(() {
      _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    });

    // Continuously listen for location updates
    _locationService.onLocationChanged.listen((LocationData updatedLocation) {
      setState(() {
        _currentLocation =
            LatLng(updatedLocation.latitude!, updatedLocation.longitude!);
      });
      _moveCamera(_currentLocation!);
    });
  }

  Future<void> _moveCamera(LatLng location) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _currentLocation == null
        ? Center(
      child: CircularProgressIndicator(),
    )
        : Container(
      height: 300, // You can adjust the height and width as needed
      width: double.infinity,

        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
          initialCameraPosition: CameraPosition(
            target: _currentLocation!,
            zoom: 14,
          ),
          markers: {
            Marker(
              markerId: MarkerId("currentLocation"),
              position: _currentLocation!,
              icon: BitmapDescriptor.defaultMarker,
            ),
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
    );
  }
}
