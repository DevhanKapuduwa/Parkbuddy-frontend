import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plz/components/user.dart';

import '../Pages/shop.dart';


var Park_lot_status={};

// Future<MobileUser> getUser(String userId) async {
//   final db = FirebaseFirestore.instance;
//
//   final docRef = db.collection("Users").doc(userId);
//   final Vehicle_ref=db.collection("Users").doc(userId).collection("vehicles");
//
//   try {
//     DocumentSnapshot doc = await docRef.get();
//
//     var cur_instance_user= MobileUser.fromDocument(doc);
//
//     print(cur_instance_user.Useremail);
//     return cur_instance_user;
//   } catch (e) {
//     print("Error getting user: $e");
//     rethrow;
//   }
// }
Future<MobileUser> getUser(String userId) async {
  final db = FirebaseFirestore.instance;

  final docRef = db.collection("Users").doc(userId);
  final vehicleRef = db.collection("Users").doc(userId).collection("vehicles");
  final bookingRef = db.collection("Users").doc(userId).collection("bookings");

  try {
    // Fetch user document
    DocumentSnapshot doc = await docRef.get();
    QuerySnapshot vehicleSnapshot = await vehicleRef.get();
    QuerySnapshot bookingSnapshot = await bookingRef.get();
    var curInstanceUser = MobileUser.fromDocument(doc,vehicleSnapshot,bookingSnapshot);
    return curInstanceUser;
    // return MobileUser(Username: "Username", Useremail: "Useremail", Ownedvehicles: [], Bookings: []);
  } catch (e) {
    print("Error getting user or vehicles: $e");
    rethrow;
  }
}


Future<List<Park>> getParks() async {
  final db = FirebaseFirestore.instance;
  final collectionRef = db.collection("Car_Parks");
  List<Park> parks = [];

  try {
    QuerySnapshot querySnapshot = await collectionRef.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      parks.add(Park.fromDocument(doc));
      print(parks);
    }
  } catch (e) {
    print("Error getting documents: $e");
  }


  return parks;
}

Future<List<Park>> SearchPark(String searchQuery) async {
    print("Searching for $searchQuery");
    final db = FirebaseFirestore.instance;
    final collectionRef = db.collection("Car_Parks");
    List<Park> parks = [];

    try {
      // Fetch all car park documents
      QuerySnapshot querySnapshot = await collectionRef.get();

      // Convert the user input to lowercase for case-insensitive comparison
      String lowercaseQuery = searchQuery.toLowerCase();

      // Loop through the documents and compare the car park names in lowercase
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String carParkName = doc['Car_park_name'].toString().toLowerCase();
        if (carParkName.contains(lowercaseQuery)) {
          parks.add(Park.fromDocument(doc));
        }
      }
    } catch (e) {
      print("Error getting documents: $e");
    }

    return parks;

}


get_info_about_Car_park() async{//this function should be upgraded as taking parameters of user id of carpark, time that user planning to park and output hhow many of them are occupied
  final db = FirebaseFirestore.instance;
  await db.collection("Car_Parks").doc("bandu@gmail.com").collection("UserLots").get().then(
        (querySnapshot) async {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        await db.collection("Car_Parks").doc("bandu@gmail.com").collection("UserLots").doc(docSnapshot.id).collection('lot_events').get().then(
                (nextsnapshot){//nextsnapshot is lot events collection
              if(nextsnapshot.docs.isEmpty){
                Park_lot_status={docSnapshot.id:"free",...Park_lot_status};
              }
              else{
                print("${docSnapshot.id}  have any events");
                for (var i=0;i<nextsnapshot.docs.length;i++) {//newdocSnapshot is each event that arent empty
                  var newdocSnapshot=nextsnapshot.docs[i];
                  var temp_obj= {...newdocSnapshot.data()};
                  var start_str=temp_obj["start"];
                  var end_str=temp_obj['end'];

                  DateTime start = DateTime.parse(start_str);
                  DateTime end = DateTime.parse(end_str);
                  DateTime now = DateTime.now();

                  if(now.isAfter(start) && now.isBefore(end)){
                    Park_lot_status={docSnapshot.id:"Occupied",...Park_lot_status};
                    break;

                  }
                  else if(i==nextsnapshot.docs.length-1) {
                    Park_lot_status={docSnapshot.id:"free",...Park_lot_status};
                  }
                }
              }
            }
        );
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
  print('Final status: ${Park_lot_status}');
}

void addevent(String Username,DateTime start,DateTime end,String Vehicle_type,String Vehicle_number) async{
  await get_info_about_Car_park();

}



