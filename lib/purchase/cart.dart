import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/profile/address.dart';

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
  var totalPrice = "";
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
            _cartItem(),
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
              trailing: Text(totalPrice),
            ),
            MainBlueButton(
              onPressed: () {
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
    final total = widget.quantity * int.parse(widget.price);
    totalPrice = total.toString();
    return ListTile(
      leading: Image.network(widget.image),
      title: Text(widget.item),
      subtitle: Text(widget.quantity.toString()),
      trailing: Text(total.toString()),
    );
  }
}
