import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shop.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeFromCart(String key, BuildContext context) {
    final shop = context.read<Shop>();
    shop.removeFromCart(key);
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
              fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
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
                        final key = value.cart.keys.elementAt(index);
                        final item = value.cart[key]!;
                        final park = item['park'] as Park;
                        final quantity = item['quantity'] as int;
                        final reservationTime = item['time'] as String;
                        final totalPrice = int.parse(park.price) * quantity;

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                          child: ListTile(
                            leading: Image.asset(
                              park.imagePath,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              park.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rs. $totalPrice",
                                  style: TextStyle(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                Text(
                                  reservationTime,
                                  style: TextStyle(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => removeFromCart(key, context),
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
                          "Proceed to Checkout",
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
