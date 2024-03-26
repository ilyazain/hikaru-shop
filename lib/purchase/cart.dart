import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/alert.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/home.dart';
import 'package:hikaru_e_shop/profile/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  final String item;
  final String image;
  final int quantity;
  final String price;
  const CartPage(
      {super.key,
      required this.item,
      required this.image,
      required this.quantity,
      required this.price});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalPrice = 0;
  List<dynamic> cartItems = [];
  @override
  void initState() {
    super.initState();
    // Retrieve cart items from SharedPreferences when the page loads
    SharedPreferences.getInstance().then(
      (prefs) {
        setState(
          () {
            cartItems = prefs
                    .getStringList('cart')
                    ?.map((item) => json.decode(item))
                    .toList() ??
                [];
            calculateTotalPrice();
          },
        );
      },
    );
  }

  void clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
    setState(() {
      cartItems.clear();
      totalPrice = 0;
    });
  }

  void calculateTotalPrice() {
    for (var item in cartItems) {
      totalPrice = (item['quantity'] *
              int.parse(
                item['price'],
              )) +
          totalPrice;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        text: "Cart",
        appBar: AppBar(),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: clearCart,
              child: Text("Clear Cart"),
            ),
            _cartItem(),
            MainBlueButton(
              title: const PoppinsWhite14(
                text: "Add more item",
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Address"),
              subtitle: Text("Casa Subang Apartment"),
              trailing: IconButton(
                  onPressed: () {
                    print("object");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddressPage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        height: 200,
        // color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              leading: Text("Total"),
              trailing: Text(totalPrice.toString()),
            ),
            MainBlueButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return OkAlert(
                      title: "Payment Success",
                      subtitle: "Thank you for buying with HikaShop",
                      okOnpressed: () {
                        clearCart();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                    );
                  },
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CartPage(),
                //   ),
                // );
              },
              title: const PoppinsWhite14(
                text: "Confirm",
              ),
            )
          ],
        ),
      ),
    );
  }

  _cartItem() {
    // final total = widget.quantity * int.parse(widget.price);
    // totalPrice = total.toString();
    return Expanded(
      child: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            leading: Image.network(item['image']),
            title: Text(item['item']),
            subtitle: Text(item['quantity'].toString()),
            trailing:
                // Text(item['price']),
                Text((item['quantity'] * int.parse(item['price'])).toString()),
          );
        },
      ),
    );

    // ListTile(
    //   leading: Image.network(widget.image),
    //   title: Text(widget.item),
    //   subtitle: Text(widget.quantity.toString()),
    //   trailing: Text(total.toString()),
    // );
  }
}
