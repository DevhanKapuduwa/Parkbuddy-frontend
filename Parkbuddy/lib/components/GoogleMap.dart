import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapWidget extends StatefulWidget {
  final LatLng CarPark;

  const GoogleMapWidget({Key? key, required this.CarPark}) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Completer<GoogleMapController> _mapController = Completer();
  final Location _locationService = Location();
  LatLng? _currentLocation;
  late BitmapDescriptor? custom_park_Icon = null;
  List<LatLng> _polylineCoordinates = [];
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _createCustomMarkerIcon();
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
      _currentLocation =
          LatLng(locationData.latitude!, locationData.longitude!);
    });

    fetchRoute().then((route) {
      print("@@@: ");
      _addRoutePolyline(route);
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

  void _createCustomMarkerIcon() async {
    try {
      custom_park_Icon = await BitmapDescriptor.asset(
          ImageConfiguration(size: Size(20, 20)), // Adjust size as needed
          'lib/images/Carpark_image.png' // Change path as needed
          );
    } catch (e) {
      print("Error loading custom icon: $e");
    }
    setState(() {});
  }


  Future<List<LatLng>> fetchRoute() async {
    final String directionsUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentLocation!.latitude},${_currentLocation!.longitude}&destination=${widget.CarPark.latitude},${widget.CarPark.longitude}&key=AIzaSyBoBYa8xyeWwcFT6ZYmxL8LKnml4FJd3_s";

    final response = await http.get(Uri.parse(directionsUrl));

    // Parse the directions response and extract the route information
    if (response.statusCode == 200) {
      final directionsData = json.decode(response.body);
      print("@@@: " + directionsData.toString());

      // Check if routes are available
      if (directionsData['routes'].isNotEmpty) {
        final route = directionsData['routes'][0];
        final polyline = route['overview_polyline']['points'];

        // Decode the polyline string into LatLng points
        return decodePolyline(polyline);
      }
    }
    return [];
  }

// Helper function to decode encoded polyline
  List<LatLng> decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  void _addRoutePolyline(List<LatLng> route) {
    setState(() {
      _polylines.add(
        Polyline(
          polylineId: PolylineId("route"),
          points: route,
          color: Colors.blue,
          width: 5,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _currentLocation == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            height: 300, // You can adjust the height and width as needed
            width: double.infinity,
            child: GoogleMap(

              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: _currentLocation!,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("Parklocation"),
                  position: widget.CarPark,
                  icon: custom_park_Icon ?? BitmapDescriptor.defaultMarker,
                ),
              },
              polylines: _polylines,
              // Add polylines to the map
              myLocationEnabled: true,
              minMaxZoomPreference: MinMaxZoomPreference(18, 26),
              mapType: MapType.normal,
              compassEnabled: true,
            ),
          );
  }
}
