import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final AppBar appBar;
  final Function() onPressed;
  const MainAppBar(
      {Key? key,
      required this.text,
      required this.appBar,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          )),
      elevation: 2,
      backgroundColor: mainBlueColor,
      title: Text(
        text,
        style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
