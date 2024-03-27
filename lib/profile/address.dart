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
  int selectedAddress = -1;
  dynamic itemSelectedAddredd;
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
          _navigation();
        },
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: clearAddress,
              child: Text("Clear Address"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: addressItems.length,
                itemBuilder: (context, index) {
                  final item = addressItems[index];
                  return ListTile(
                    leading: Text(item['add'] +
                        item['city'] +
                        item['postcode'] +
                        item['state']),
                    trailing: IconButton(
                      icon: selectedAddress == index
                          ? Icon(Icons.check_box)
                          : Icon(Icons.check_box_outline_blank),
                      onPressed: () async {
                        setState(() {
                          selectedAddress = index;
                          print(selectedAddress);
                        });
                        itemSelectedAddredd = item;
                        // SharedPreferences prefs =
                        //     await SharedPreferences.getInstance();
                        // await prefs.setString(
                        //     'selectedaddress', json.encode(item));
                      },
                    ),
                  );
                },
              ),
            ),
            MainBlueButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString(
                      'selectedaddress', json.encode(itemSelectedAddredd));

                  _navigation();
                },
                title: PoppinsWhite14(
                  text: "Confirm Address",
                ))
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
          ),
        ),
      ),
    );
  }

  _navigation() {
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
  }
}
