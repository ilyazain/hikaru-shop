import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/home.dart';
import 'package:hikaru_e_shop/profile/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? selectedAddress;
  @override
  void initState() {
    super.initState();
    _loadSelectedAddress();
  }

  Future<void> _loadSelectedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedAddressJson = prefs.getString('selectedaddress');
    if (selectedAddressJson != null) {
      setState(() {
        selectedAddress = json.decode(selectedAddressJson);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          haveTrailing: true,
          text: "Profile",
          appBar: AppBar(),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => HomePage(
            //       currentIndex: 2,
            //     ),
            //   ),
            // );
          }),
      body: Container(
        child: Column(
          children: [
            //image profile
            Text("Ain Ilya Aqilah Zainodin"),
            ListTile(
              title: Text("Address"),
              subtitle: selectedAddress != null
                  ? Text(
                      '${selectedAddress!['add']}, ${selectedAddress!['city']}, ${selectedAddress!['postcode']}, ${selectedAddress!['state']}')
                  : Text('No address selected'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios_sharp),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressPage(
                        prePage: "fromProfile",
                      ),
                    ),
                  );
                },
              ),
            ),
            MainBlueButton(
                onPressed: () {},
                title: PoppinsWhite14(
                  text: "Log Out",
                ))
          ],
        ),
      ),
    );
  }
}
