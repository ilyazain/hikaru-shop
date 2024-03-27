import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/home.dart';
import 'package:hikaru_e_shop/profile/add_address.dart';
import 'package:hikaru_e_shop/purchase/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPage extends StatefulWidget {
  final String prePage;
  const AddressPage({super.key, required this.prePage});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  bool isChecked = false;
  List<dynamic> addressItems = [];
  @override
  void initState() {
    super.initState();
    // Retrieve cart items from SharedPreferences when the page loads
    SharedPreferences.getInstance().then(
      (prefs) {
        setState(
          () {
            addressItems = prefs
                    .getStringList('address')
                    ?.map((item) => json.decode(item))
                    .toList() ??
                [];
            // calculateTotalPrice();
          },
        );
      },
    );
  }

  void clearAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('address');
    setState(() {
      addressItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          text: "Address",
          appBar: AppBar(),
          onPressed: () {
            if (widget.prePage == "fromCart") {
              Navigator.pushNamed(context, '/cart');
            } else if (widget.prePage == "fromProfile") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    currentIndex: 2,
                  ),
                ),
              );
            } else {
              print("hehe");
            }
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => CartPage(
            //         // image: widget.image,
            //         // item: widget.item,
            //         // price: widget.price,
            //         // quantity: quantity,
            //         ),
            //   ),
            // );
          }),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: clearAddress,
              child: Text("Clear Address"),
            ),
            Text("data"),
            Expanded(
              child: ListView.builder(
                itemCount: addressItems.length,
                itemBuilder: (context, index) {
                  final item = addressItems[index];
                  return Text(item['add'] +
                      item['city'] +
                      item['postcode'] +
                      item['state']);

                  // ListTile(
                  //   leading: Image.network(item['image']),
                  //   title: Text(item['item']),
                  //   subtitle: Text(item['quantity'].toString()),
                  //   trailing:
                  //       // Text(item['price']),
                  //       Text((item['quantity'] * int.parse(item['price']))
                  //           .toString()),
                  // );
                },
              ),
            ),
            ListTile(
              leading: Text("Casa Subang Apartment"),
              trailing: IconButton(
                icon: isChecked
                    ? Icon(Icons.check_box)
                    : Icon(Icons.check_box_outline_blank),
                onPressed: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: MainBlueButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAddressPage(prePage: widget.prePage),
                ),
              );
            },
            title: PoppinsWhite14(
              text: "Add Address",
            )),
      ),
    );
  }
}
