import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/alert.dart';
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
        backgroundColor: mainBlueColor,
        appBar: MainAppBar(
            haveTrailing: true,
            text: "Profile",
            appBar: AppBar(),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            }),
        body: Container(
          color: whiteColor,
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/girl_image.jpg'),
                  radius: 75,
                ),
              ),
              const TextBlack18(text: "Ain Ilya"),
              _profileData(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: MainBlueButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return YesNoAlert(
                            title: "Log out?",
                            subtitle: "Are you sure you want to logout?",
                            yesOnpressed: () async {
                              Navigator.pushNamed(context, '/login');
                            },
                          );
                        },
                      );
                    },
                    title: const TextWhite14(
                      text: "Log Out",
                    )),
              )
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
      // height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: orangeShade300Color),
      child: Column(
        children: [
          _listProfile("Email", "hikaru@gmail.com", () {}, false),
          _listProfile("Birthday", "9 April 2000", () {}, false),
          _listProfile(
              "Address",
              selectedAddress != null
                  ? '${selectedAddress!['add']}, ${selectedAddress!['city']}, ${selectedAddress!['postcode']}, ${selectedAddress!['state']}'
                  : 'No address selected', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddressPage(
                  prePage: "fromProfile",
                ),
              ),
            );
          }, true),
          _listProfile("Telephone Number", "0120394835", () {}, false)
        ],
      ),
    );
  }

  _listProfile(title, subtitle, onTap, bool trailing) {
    return ListTile(
        contentPadding: EdgeInsets.only(right: 0, left: 15),
        title: TextBlack14(text: title),
        subtitle: TextBlack13(text: subtitle),
        trailing: trailing
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: blackColor,
                ),
                onPressed: onTap)
            : null);
  }
}
