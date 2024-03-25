
import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
class MainBlueButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget title;
  final double width;
  final double height;
  final Color? color;
  const MainBlueButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.width = double.infinity,
      this.height = 50,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      // padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: color != null
              ? MaterialStateProperty.all<Color>(color!)
              : MaterialStateProperty.all<Color>(mainBlueColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: title
            // ),
            ),
      ),
    );
  }
}

