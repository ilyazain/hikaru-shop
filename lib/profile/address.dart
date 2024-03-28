import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/alert.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/home.dart';
import 'package:hikaru_e_shop/profile/add_address.dart';
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
  dynamic itemSelectedAddress;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then(
      (prefs) {
        setState(
          () {
            addressItems = prefs
                    .getStringList('address')
                    ?.map(
                      (item) => json.decode(item),
                    )
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
          child: addressItems.isNotEmpty ? _haveAddress() : _addressEmpty()),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: MainBlueButton(
          onPressed: () {
            addressItems.isNotEmpty
                ? _confirmNavigation()
                : _addAddressNavigation();
          },
          title: TextWhite14(
            text: addressItems.isNotEmpty ? "Confirm Address" : "Add Address",
          ),
        ),
      ),
    );
  }

  _addAddressNavigation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAddressPage(prePage: widget.prePage),
      ),
    );
  }

  _haveAddress() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: clearAddress,
          child: Text("Clear Address"),
        ),
        _addressList(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: MainBlueButton(
            onPressed: () async {
              _addAddressNavigation();
            },
            title: const TextWhite14(
              text: "Add Address",
            ),
          ),
        )
      ],
    );
  }

  _confirmNavigation() async {
    // if (itemSelectedAddress) {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedaddress', json.encode(itemSelectedAddress));

    _navigation();
    // } else {
    //   showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) {
    //       return OkAlert(
    //         title: "Address Empty",
    //         subtitle: "Please select address",
    //         okOnpressed: () {
    //           Navigator.pop(context);
    //         },
    //       );
    //     },
    //   );
    // }
  }

  _addressEmpty() {
    return const Column(
      children: [
        //add image
        TextBlack14(text: "Your address is empty. Please add item")
      ],
    );
  }

  _addressList() {
    return Expanded(
      child: ListView.builder(
        itemCount: addressItems.length,
        itemBuilder: (context, index) {
          final item = addressItems[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextBlack14(
                  text:
                      '${item['add']}, ${item['city']}, ${item['postcode']},${item['state']}'),
            ),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: selectedAddress == index
                      ? const Icon(
                          Icons.check_box,
                          color: greenColor,
                        )
                      : const Icon(Icons.check_box_outline_blank),
                  onPressed: () async {
                    setState(() {
                      selectedAddress = index;
                    });
                    itemSelectedAddress = item;
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: redColor,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return YesNoAlert(
                          title: "Delete Address?",
                          subtitle:
                              "Are you sure you want to delete ${item['add']}, ${item['city']}, ${item['postcode']},${item['state']} address?",
                          yesOnpressed: () {
                            setState(() {
                              addressItems.removeAt(index);
                              if (selectedAddress == index) {
                                selectedAddress = -1;
                                itemSelectedAddress = null;
                              }
                            });
                            _updateAddressList();
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _updateAddressList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> addressJsonList =
        addressItems.map((item) => json.encode(item)).toList();
    prefs.setStringList('address', addressJsonList);
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
    } else {}
  }
}
