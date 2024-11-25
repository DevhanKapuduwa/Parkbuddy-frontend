// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:plz/components/Google_Maps_Functions.dart';
// import 'package:plz/components/connect_firebase.dart';
// import 'package:plz/components/user.dart';
//
// import '../../Pages/shop.dart';
//
// void Cancel_booking(BuildContext context) {
//   Navigator.pop(context);
// }
//
// class Booking_clicked extends StatefulWidget {
//   final Booking Current_booking;
//   const Booking_clicked({super.key,required this.Current_booking});
//
//   @override
//   State<Booking_clicked> createState() => _Booking_clickedState();
//
// }
//
//
//
// class _Booking_clickedState extends State<Booking_clicked> {
//   Park? _currentpark;
//   var _distance,_duration="Calculating.....";
//
//
//   void getPark_details(String ParkId) async{
//     var _park=await getCarParkById(ParkId);
//     setState(() {
//       _currentpark=_park;
//     });
//
//     print("@@");
//     print(_currentpark?.location.longitude);
//
//     var distance_location=await getDistanceAndDuration(_currentpark?.location.latitude??0, _currentpark?.location.longitude??0);
//     setState(() {
//       _distance=distance_location?["distance"];
//       _duration=distance_location?["duration"];
//     });
//
//
//
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getPark_details(widget.Current_booking.parkLotId);
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(
//       backgroundColor: Colors.orange,
//       bottomOpacity: 0.1,
//     ),
//       body: _currentpark==null || _distance==null? Center(child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(),
//           SizedBox(height: 5,),
//           Text("Loading booking data....")
//         ],
//       )): Container(
//         height: context.height,
//             width: context.width,
//             decoration: BoxDecoration(
//                color: Colors.black12
//             ),
//
//
//
//             child:Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//
//                       Center(
//                           child: Text(
//                               widget.Current_booking.parkName,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 27
//                             ),
//                           )
//                       ),
//
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Image.asset(_currentpark?.imagePath??"default",height: context.height/5,),
//                       ),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Center(
//
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("Distance to Park: "),
//                             Text(_distance.toString())
//                           ],
//
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("Estimated time to Travel: "),
//                           Text(_duration.toString())
//                         ],
//
//                       ),
//                       SizedBox(
//                         height: 50,
//                       )
//
//
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () => Cancel_booking(context),
//                       child: const Text("Go to Park",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
//                       style: ButtonStyle(
//                         fixedSize: WidgetStateProperty.all(Size(200,30)),
//                         padding: WidgetStateProperty.all(
//                           const EdgeInsets.symmetric(horizontal: 10),
//                         ),
//                         backgroundColor: WidgetStateProperty.all(Colors.green),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () => Cancel_booking(context),
//                       child: const Text("Cancel Booking",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
//                       style: ButtonStyle(
//                         fixedSize: WidgetStateProperty.all(Size(200,30)),
//                         padding: WidgetStateProperty.all(
//                           const EdgeInsets.symmetric(horizontal: 10),
//                         ),
//                         backgroundColor: WidgetStateProperty.all(Colors.redAccent),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//
//         ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plz/components/Google_Maps_Functions.dart';
import 'package:plz/components/connect_firebase.dart';
import 'package:plz/components/user.dart';

import '../../Pages/shop.dart';
import '../GoogleMap.dart';

void Cancel_booking(BuildContext context) {
  Navigator.pop(context);
}

class Booking_clicked extends StatefulWidget {
  final Booking Current_booking;

  const Booking_clicked({super.key, required this.Current_booking});

  @override
  State<Booking_clicked> createState() => _Booking_clickedState();
}

class _Booking_clickedState extends State<Booking_clicked> {
  Park? _currentPark;
  double? _latitude, _longitude;
  var _distance, _duration = "Calculating...";
  GoogleMapController? _mapController;

  void getParkDetails(String parkId) async {
    var park = await getCarParkById(parkId);
    setState(() {
      _currentPark = park;
      _latitude = park?.location.latitude;
      _longitude = park?.location.longitude;
    });

    if (_latitude != null && _longitude != null) {
      var distanceLocation =
          await getDistanceAndDuration(_latitude!, _longitude!);
      setState(() {
        _distance = distanceLocation?["distance"];
        _duration = distanceLocation?["duration"];
      });
    }
  }



  @override
  void initState() {
    getParkDetails(widget.Current_booking.parkLotId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        bottomOpacity: 0.1,
      ),
      body: _currentPark == null || _distance == null
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 5),
                  Text("Loading booking data..."),
                ],
              ),
            )
          : Container(
              height: context.height,
              width: context.width,
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            widget.Current_booking.parkName,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 27,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            _currentPark?.imagePath ?? "default",
                            height: context.height / 5,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Distance to Park: "),
                              Text(_distance.toString())
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Estimated time to Travel: "),
                            Text(_duration.toString())
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: ()=>{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMapWidget(CarPark: LatLng(_latitude??0,_longitude??0),)))
                        },
                        child: const Text(
                          "Go to Park",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(Size(200, 30)),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.green),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Cancel_booking(context),
                        child: const Text(
                          "Cancel Booking",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(Size(200, 30)),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
