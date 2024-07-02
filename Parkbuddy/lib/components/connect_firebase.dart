import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

var Park_lot_status={};

getuser() async{
  final db = FirebaseFirestore.instance;
  final docRef = db.collection("Car_Parks").doc("bandu@gmail.com");
  await docRef.get().then(
        (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      print("Current data: ");
      print(data);
    },
    onError: (e) => print("Error getting document: $e"),
  );
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

void addUser(String Username,DateTime start,DateTime end,String Vehicle_type,String Vehicle_number) async{
  await get_info_about_Car_park();





}



