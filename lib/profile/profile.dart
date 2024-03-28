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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: MainAppBar(
            haveTrailing: true,
            text: "Profile",
            appBar: AppBar(),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            }),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/girl_image.jpg'),
                  radius: 75,
                ),
              ),
              const TextBlack18(text: "Ain Ilya Aqilah Zainodin"),
              _profileData(),
              MainBlueButton(
                  onPressed: () {},
                  title: const TextWhite14(
                    text: "Log Out",
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _profileData() {
    return Container(
      // color: Colors.amber,
      margin: EdgeInsets.all(15),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: orangeShade300Color),
      child: Column(
        children: [
          ListTile(
            title: TextBlack14(text: "Address"),
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
        ],
      ),
    );
  }
}
