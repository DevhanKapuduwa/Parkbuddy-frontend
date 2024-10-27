import 'dart:math';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plz/Pages/shop.dart';
import 'package:plz/components/List_tiles/Park_tile_info_window.dart';
import 'package:plz/components/user.dart';

import '../Pages/park_details.dart';



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
  return nearbyCarParks;
}

class CarParkMap extends StatefulWidget {
  final List<Park> CarPark_list;
  LatLng? Input_location;
  MobileUser CurrentUser;

  CarParkMap({super.key,required this.Input_location,required this.CarPark_list,required this.CurrentUser});

  @override
  _CarParkMapState createState() => _CarParkMapState();
}

class _CarParkMapState extends State<CarParkMap> {
  Position? Currentlocation;
  var carParks;
  late GoogleMapController _controller;
  Set<Marker> _markers = {};
  final custom_info_window_controller=CustomInfoWindowController();

  @override
  void initState() {
    super.initState();
    _loadNearbyCarParks();
    
  }

  Future<void> _loadNearbyCarParks() async {
    // Await the result of getNearbyCarParks
    print("^^");
    if(widget.Input_location==null){
      print("Null find");
      LocationService newlocation=LocationService();
      Currentlocation=await newlocation.getCurrentLocation();

    }else{
      print("Not null");

      try{
        Currentlocation= Position(longitude: widget.Input_location?.longitude??0, latitude: widget.Input_location?.latitude??0, timestamp: DateTime.now(), accuracy: 0, altitude: 0, altitudeAccuracy: 0, heading: 0, headingAccuracy: 0, speed: 0, speedAccuracy: 0);
      }
      catch(e){
        print("^^%"+e.toString());
      }

      print("iii");
      print(widget.Input_location.toString());

    }

    print("&&");
    print(Currentlocation?.longitude);
    List<Object?> nearbyCarParks = await getNearbyCarParks(Currentlocation?.latitude, Currentlocation?.longitude, 15);
    print("%%");
    print(nearbyCarParks);


    setState(() {

      Currentlocation=Currentlocation;
      _moveCameraToCurrentLocation();
      print("^!^^!^");
      carParks = nearbyCarParks; // Update the state with the list of car parks

      _loadMarkers(nearbyCarParks);

    });
  }


  void _moveCameraToCurrentLocation() async {
    print("Current locations:"+Currentlocation.toString());

    if (_controller != null && Currentlocation != null) {

      await _controller.animateCamera(
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
    print("****!!");
    return;
  }

  void _loadMarkers(CarParls) {
    print("^^^^^");
    // _markers.clear(); // Clear previous markers to avoid duplication


    CarParls.forEach((carPark) {
      GeoPoint point = carPark['location'];
      LatLng position = LatLng(point.latitude, point.longitude);


      _markers.add(
        Marker(
          markerId: MarkerId(carPark['Car_park_id'].toString()), // Use a unique marker ID
          position: position,
          onTap: () {
            print("@@^^"+carPark.toString());

            custom_info_window_controller.addInfoWindow!(
              Info_window(carPark: carPark,carParkList: this.widget.CarPark_list,Current_user: widget.CurrentUser,),
              position, // Position of the marker where the info window should appear
            );
          },
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(child:Stack(children: [ GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(Currentlocation?.latitude??0,Currentlocation?.longitude??0),
        zoom: 7,
      ),
        myLocationEnabled: true,
        markers: _markers,

        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          custom_info_window_controller.googleMapController=controller;
          if(Currentlocation!=null){
            _moveCameraToCurrentLocation();
          }

        },
        onTap: (location){
          custom_info_window_controller.hideInfoWindow!();
        },
      onCameraMove: (position){
          custom_info_window_controller.onCameraMove!();
      },

      )
      ,
      CustomInfoWindow(controller: custom_info_window_controller,height: 200,width: 300,offset: 50,)
    ]
    ),
        height: double.infinity
      ,

      );
  }
}

class Info_window extends StatelessWidget {
  final Map<String, dynamic> carPark;
  final List<Park> carParkList;
  final MobileUser Current_user;
  const Info_window({
    super.key,
    required this.carPark,
    required this.carParkList,
    required this.Current_user
  });



  @override
  Widget build(BuildContext context) {
    Park Showing_park=Park(imagePath: "imagePath", name: "name", price: "price", rating: "rating", description: "description", extension: "extension", id: "id",location: GeoPoint(6.917547106356931, 79.85492520678427 ));
    for (var park in carParkList) {
      if(park.name==carPark["Car_park_name"]) {
        Showing_park=park;
        break;
      }
    }

    return SizedBox(
      height: 100,
      width: 200,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10),
          ],
        ),
        // child: Center(child: Text(carPark["Car_park_name"], style: TextStyle(fontSize: 16,color: Colors.black))),
        child: ParkTile_map(park: Showing_park,onTap: ()=>{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ParkDetailsPage(park: Showing_park, current_User: Current_user)))

        },),
      ),
    );
  }
}

