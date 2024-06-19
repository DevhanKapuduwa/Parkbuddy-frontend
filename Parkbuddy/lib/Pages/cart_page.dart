// import 'package:flutter/material.dart';
// import 'package:plz/Pages/shop.dart';
// import 'package:provider/provider.dart';
//
// import 'homepage.dart';
//
// class CartPage extends StatelessWidget {
//   const CartPage({super.key});
//
//   void removeFromCart(Park park, BuildContext context) {
//     final shop = context.read<Shop>();
//     shop.removeFromCart(park);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Shop>(
//       builder: (context, value, child) => Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             'My Cart',
//             style: TextStyle(
//               fontSize: Theme.of(context)
//                   .textTheme
//                   .headlineSmall
//                   ?.fontSize, // Use the same font size as headlineSmall
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         body: value.cart.isEmpty
//             ? Center(
//                 child: Text(
//                   "Your cart is empty",
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               )
//             : Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: value.cart.length,
//                       itemBuilder: (context, index) {
//                         final Park park = value.cart[index];
//                         final String parkName = park.name;
//                         final String parkPrice = park.price;
//                         final String parkPhoto = park.imagePath;
//
//                         return Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           margin: EdgeInsets.only(left: 20, top: 20, right: 20),
//                           child: ListTile(
//                             leading: Image.asset(
//                               parkPhoto,
//                               width: 50,
//                               height: 50,
//                               fit: BoxFit.cover,
//                             ),
//                             title: Text(
//                               parkName,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             subtitle: Text(
//                               "Rs. " + parkPrice,
//                               style: TextStyle(
//                                 color: Colors.grey.shade300,
//                               ),
//                             ),
//                             trailing: IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () => removeFromCart(park, context),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             Colors.grey.withOpacity(0.2) // Text color
//                         ),
//                     onPressed: () {},
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           "Add To Cart",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Icon(
//                           Icons.arrow_forward_rounded,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shop.dart';

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
          centerTitle: true,
          title: Text(
            'My Cart',
            style: TextStyle(
              fontSize: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.fontSize, // Use the same font size as headlineSmall
              fontWeight: FontWeight.bold,
            ),
          ),
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
                        final park = value.cart.keys.elementAt(index);
                        final quantity = value.cart[park]!;
                        final totalPrice = int.parse(park.price) * quantity;
                        final String parkName = park.name;
                        final String parkPhoto = park.imagePath;

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                          child: ListTile(
                            leading: Image.asset(
                              parkPhoto,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              parkName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Rs. $totalPrice",
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
                      backgroundColor: Colors.grey.withOpacity(0.2),
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
