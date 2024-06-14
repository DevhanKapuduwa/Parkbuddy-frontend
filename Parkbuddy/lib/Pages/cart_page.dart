// import 'package:flutter/material.dart';
// import 'package:plz/Pages/shop.dart';
// import 'package:provider/provider.dart';
//
// import 'homepage.dart';
//
// class CartPage extends StatelessWidget {
//   const CartPage({super.key});
//
//   void removeFromCart(Park park,BuildContext context) {
//     final shop = context.read<Shop>();
//
//     shop.removeFromCart(park);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Shop>(
//       builder: (context,value,child) => Scaffold(
//         appBar: AppBar(
//           title: Text("My Cart"),
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                   itemBuilder: (context,index) {
//
//                     final Park park =value.cart[index];
//
//                     final String parkName = park.name;
//
//                     final String parkPrice = park.price;
//
//                     return Container(
//                       decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2),borderRadius: BorderRadius.circular(8)),
//                       margin: EdgeInsets.only(left: 20,top: 20,right: 20),
//
//                       child: ListTile(
//                         title: Text(parkName,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),),
//                         subtitle: Text(parkPrice,
//                           style: TextStyle(
//                             color: Colors.grey.shade300,
//                           ),
//                         ),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => removeFromCart(park,context),
//                         ),
//                       ),
//                     );
//               },
//               ),
//             ),
//
//     ElevatedButton(
//     style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.grey.withOpacity(0.2) // Text color
//     ),
//     onPressed: () {},
//     child: Row(
//     children: [
//     Text(
//     "Add To Cart",
//     style: TextStyle(color: Colors.white),
//     ),
//     Icon(
//     Icons.arrow_forward_rounded,
//     color: Colors.white,
//     ),
//     ],
//     ),
//     ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:plz/Pages/shop.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeFromCart(Park park, BuildContext context) {
    final shop = context.read<Shop>();
    shop.removeFromCart(park);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("My Cart"),
          elevation: 0,
        ),
        body: value.cart.isEmpty
            ? Center(
          child: Text(
            "Your cart is empty",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: value.cart.length,
                itemBuilder: (context, index) {
                  final Park park = value.cart[index];
                  final String parkName = park.name;
                  final String parkPrice = park.price;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: ListTile(
                      title: Text(
                        parkName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        parkPrice,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => removeFromCart(park, context),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(0.2) // Text color
              ),
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add To Cart",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

