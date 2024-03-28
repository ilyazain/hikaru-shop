import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final AppBar appBar;
  final Function() onPressed;
  final bool? haveLeading;
  final bool? haveTrailing;
  const MainAppBar(
      {Key? key,
      required this.text,
      required this.appBar,
      this.haveLeading = true,
      this.haveTrailing = false,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      actions: [
        haveTrailing == true
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: whiteColor,
                  ),
                ),
              )
            : Container()
      ],
      leading: haveLeading == true
          ? IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white,
              ))
          : null,
      elevation: 2,
      backgroundColor: mainBlueColor,
      title: Text(
        text,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
