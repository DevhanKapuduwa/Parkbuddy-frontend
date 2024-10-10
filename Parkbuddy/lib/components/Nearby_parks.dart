import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadius = 6371; // Radius of the Earth in kilometers
  final latDistance = _degreesToRadians(lat2 - lat1);
  final lonDistance = _degreesToRadians(lon2 - lon1);

  final a = sin(latDistance / 2) * sin(latDistance / 2) +
      cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
          sin(lonDistance / 2) * sin(lonDistance / 2);

  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadius * c; // Distance in kilometers
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

class LocationService { // location services
  // Check location permissions and request if needed
  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, do something (like showing a dialog)
      return Future.error('Location services are disabled.');
    }

    // Check for permission and request if necessary
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, handle accordingly
      return Future.error('Location permissions are permanently denied');
    }
  }

  // Get the current location
  Future<Position> getCurrentLocation() async {
    await _checkLocationPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}

Future<List<Object?>> getNearbyCarParks(double? userLat, double? userLon, double radiusInKm) async {
  // Get all car parks from Firestore
  final QuerySnapshot carParksSnapshot = await FirebaseFirestore.instance.collection('Car_Parks').get();

  List<Object?> nearbyCarParks = [];

  for (var doc in carParksSnapshot.docs) {
    print("#@:");
    print(doc.data());
    final carParkData = doc.data() as Map<String, dynamic>;
    final GeoPoint? carParkLocation = carParkData['location'];
    if(carParkLocation==null){
      print("Continued");
      continue;
    }
    final double carParkLat = carParkLocation.latitude;
    final double carParkLon = carParkLocation.longitude;

    // Calculate distance between user and car park
    double distance = calculateDistance(userLat??0, userLon??0, carParkLat, carParkLon);

    // If within the radius, add to the result list
    if (distance <= radiusInKm) {
      nearbyCarParks.add(doc.data());
    }
  }
  print("@@nearby:");
  print(nearbyCarParks);

  return nearbyCarParks;
}

class CarParkMap extends StatefulWidget {
  CarParkMap({super.key});

  @override
  _CarParkMapState createState() => _CarParkMapState();
}

class _CarParkMapState extends State<CarParkMap> {
  Position? Currentlocation;
  var carParks;
  late GoogleMapController _controller;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadNearbyCarParks();
    
  }

  Future<void> _loadNearbyCarParks() async {
    // Await the result of getNearbyCarParks
    LocationService newlocation=LocationService();
    Currentlocation=await newlocation.getCurrentLocation();
    print("&&");
    print(Currentlocation?.longitude);
    List<Object?> nearbyCarParks = await getNearbyCarParks(Currentlocation?.latitude, Currentlocation?.longitude, 4);


    setState(() {
      Currentlocation=Currentlocation;
      _moveCameraToCurrentLocation();
      carParks = nearbyCarParks; // Update the state with the list of car parks
      _loadMarkers(); // Call the marker loading function after updating the car parks
    });
  }

  void _moveCameraToCurrentLocation() {
    if (_controller != null && Currentlocation != null) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              Currentlocation!.latitude,
              Currentlocation!.longitude,
            ),
            zoom: 14, // Adjust zoom level
          ),
        ),
      );
    }
  }

  void _loadMarkers() {

    carParks.forEach((carPark) {
      print("!!");print(carPark['location'].latitude);
      GeoPoint point = carPark['location'];
      print(point.latitude);
      _markers.add(
        Marker(
          markerId: MarkerId("32312323"),
          position: LatLng(point.latitude, point.longitude),
          infoWindow: InfoWindow(
              title: carPark["Car_park_name"]), // Use your car park data here
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child:GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(Currentlocation?.latitude??0,Currentlocation?.longitude??0),
          zoom: 7,
        ),
        myLocationEnabled: true,
        markers: _markers,

        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          if(Currentlocation!=null){
            _moveCameraToCurrentLocation();
          }
        },
      ),
        height: 300,

      );
  }
}

