import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/alert.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/profile/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddressPage extends StatefulWidget {
  final String prePage;
  const AddAddressPage({super.key, required this.prePage});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController addController = TextEditingController();
  TextEditingController pCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          text: "Add Address",
          appBar: AppBar(),
          onPressed: () {
            Navigator.pop(context);
          }),
      body: Column(
        children: [
          _textField("Address", addController),
          _textField("City", cityController),
          _textField("Postcode", pCodeController),
          _textField("State", stateController)
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: MainBlueButton(
            onPressed: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AddressPage(),
              //   ),
              // );

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return OkAlert(
                    title: "Address Add Successfully",
                    subtitle: "Your address was successfully added",
                    okOnpressed: () {
                      SharedPreferences.getInstance().then((prefs) {
                        List<String> addressItems =
                            prefs.getStringList('address') ?? [];
                        addressItems.add(json.encode({
                          'add': addController.text,
                          'city': cityController.text,
                          'postcode': pCodeController.text,
                          'state': stateController.text,
                        }));
                        prefs.setStringList('address', addressItems);
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressPage(
                            prePage: widget.prePage,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            title: PoppinsWhite14(
              text: "Confirm",
            )),
      ),
    );
  }

  _textField(title, controller) {
    return ListTile(
      title: Text(title),
      subtitle: TextFormField(
        controller: controller,
      ),
    );
  }
}
