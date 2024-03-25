import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/profile/address.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(text: "Profile", appBar: AppBar(), onPressed: () {}),
      body: Container(
        child: Column(
          children: [
            //image profile
            Text("Ain Ilya Aqilah Zainodin"),
            ListTile(
              leading: Text("Address"),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios_sharp),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressPage(),
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
