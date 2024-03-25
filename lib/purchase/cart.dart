import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/profile/address.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(text: "Cart", appBar: AppBar(), onPressed: () {}),
      body: Container(
        child: Column(
          children: [
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
              trailing: Text("RM 40"),
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
}
