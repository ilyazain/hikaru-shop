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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return YesNoAlert(
          title: "Delete All Address?",
          subtitle: "Are you sure you want to delete all address?",
          yesOnpressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('address');
            setState(() {
              addressItems.clear();
            });
            Navigator.pop(context);
          },
        );
      },
    );
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
        const SizedBox(
          height: 10,
        ),
        _addressList(),
        SizedBox(
          width: 170,
          child: ElevatedButton(
            onPressed: clearAddress,
            child: const Row(
              children: [
                Icon(
                  Icons.delete,
                  color: redColor,
                ),
                TextMaroon12(text: "Clear All Address"),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
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
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30, bottom: 10, top: 120),
            child: Image.asset(
              "assets/shy_girl2.png",
              height: 200,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Center(
              child: TextBlack16(
                  text: "Your address is empty. Please add address"),
            ),
          ),
        ],
      ),
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
            leading: Container(
              // color: Colors.amber,
              child: Image.asset(
                "assets/address.png",
                width: 60,
              ),
            ),
            title: TextBlack14(
                text:
                    '${item['add']}, ${item['city']}, ${item['postcode']},${item['state']}'),
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
