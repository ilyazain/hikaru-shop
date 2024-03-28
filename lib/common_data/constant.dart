import 'package:flutter/material.dart';

//constant color
const Color mainBlueColor = Color.fromARGB(255, 36, 87, 169);
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
Color greyShade400Color = Colors.grey.shade400;
Color orangeShade300Color = Colors.orange.shade300;

//constant font
class PoppinsWhite14 extends StatelessWidget {
  final String text;

  const PoppinsWhite14({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold),
    );
  }
}

class PoppinsBlack14 extends StatelessWidget {
  final String text;

  const PoppinsBlack14({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold),
    );
  }
}
