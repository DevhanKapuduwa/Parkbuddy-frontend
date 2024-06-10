import 'package:flutter/material.dart';
import 'package:plz/Pages/profile.dart';
import 'homepage.dart';
import 'notifications.dart';

class ParkDetailsPage extends StatelessWidget {
  final Park park;

  ParkDetailsPage({required this.park});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(park.name),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomePage())),
                child: Icon(Icons.home)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Notifications())),
                child: Icon(Icons.notifications)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Profile())),
                child: Icon(Icons.person)),
            label: '',
          ),
        ],
      ),

      body: Column(
          children: [
            Image.asset(park.imagePath),
            Text(
              park.name,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Rs. ' + park.price + ' / hr',
              style: TextStyle(fontSize: 24),
            ),
          ],

      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import '../components/action_button.dart';
// import 'homepage.dart';
// import 'package:get/get.dart';
//
// class ParkDetailsPage extends StatelessWidget {
//   final Park park;
//
//   ParkDetailsPage({required this.park});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             color: Colors.white,
//             height: 100,
//           ),
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Container(
//                 width: double.infinity,
//                 child: Column(
//                   children: [
//                     buildHeader(),
//                     buildBody(),
//
//
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//
//
//   Widget buildHeader() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         )
//       ),
//       child: Column(
//         children: [
//         AppBar(
//         title: Text(park.name),
//       ),
//         ],
//       ),
//     );
//   }
//
//   Widget appBar() {
//     return Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//
//           ),
//       padding: EdgeInsets.symmetric(horizontal: 14,vertical: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//
//           ActionButton(
//             onPressed: () => Get.back(),
//             color: Colors.black, icon: Icons.keyboard_arrow_left,
//             colorIcon: Colors.white,
//           ),
//           Row(
//             children: [
//               ActionButton(
//                 onPressed: () {},
//                 color: Colors.blue, icon: Icons.bookmark_border,
//                 colorIcon: Colors.white,
//               ),
//               ActionButton(
//                 onPressed: () {},
//                 color: Colors.blue, icon: Icons.ios_share,colorIcon: Colors.white,
//
//               ),
//
//             ],
//           ),
//         ],
//       ),
//         );
//   }
//   Widget buildBody() => Container();
// }
//
// // class ActionButton extends StatelessWidget {
// //   const ActionButton({
// //     super.key,
// //     required this.color,
// //     required this.colorIcon,
// //     required this.icon,
// //     required this.onPressed,
// //   });
// //
// //   final Color color;
// //   final Color colorIcon;
// //   final IconData icon;
// //   final void Function() onPressed;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return InkWell(
// //       onTap: onPressed,
// //       child: Container(
// //         width: 45,
// //           height: 45,
// //         margin: EdgeInsets.all(4),
// //         decoration: BoxDecoration(
// //           color: color,
// //           borderRadius: BorderRadius.circular(15),
// //           border: Border.all(
// //             color: Colors.grey.shade300,
// //             width: 1,
// //           )
// //         ),
// //         child: Padding(
// //           padding: EdgeInsets.all(8),
// //           child: Icon(
// //             icon,
// //             color: colorIcon,
// //             size: 28,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
