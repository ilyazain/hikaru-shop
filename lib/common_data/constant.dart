import 'package:flutter/material.dart';

//constant color
const Color mainBlueColor = Color.fromARGB(255, 17, 46, 92);
const Color lightOrangeColor = Color.fromARGB(255, 234, 226, 167);
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color redColor = Color.fromARGB(255, 201, 37, 37);
const Color greenColor = Color.fromARGB(255, 28, 175, 33);
Color greyShade400Color = Colors.grey.shade400;
Color greyShade300Color = Colors.grey.shade300;
Color orangeShade300Color = Colors.orange.shade300;

//constant font
class TextWhite14 extends StatelessWidget {
  final String text;

  const TextWhite14({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}

class TextWhite16 extends StatelessWidget {
  final String text;

  const TextWhite16({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}

class TextBlack14 extends StatelessWidget {
  final String text;

  const TextBlack14({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}

class TextBlackBold12 extends StatelessWidget {
  final String text;

  const TextBlackBold12({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
    );
  }
}

class TextBlack13 extends StatelessWidget {
  final String text;

  const TextBlack13({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 13,
      ),
    );
  }
}

class TextMaroon12 extends StatelessWidget {
  final String text;

  const TextMaroon12({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: redColor, fontSize: 12, fontWeight: FontWeight.bold),
    );
  }
}

class TextMaroon18 extends StatelessWidget {
  final String text;

  const TextMaroon18({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: redColor, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class TextGrey14 extends StatelessWidget {
  final String text;

  const TextGrey14({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
    );
  }
}

class TextBlack16 extends StatelessWidget {
  final String text;

  const TextBlack16({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}

class TextBlack18 extends StatelessWidget {
  final String text;

  const TextBlack18({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          //
          fontWeight: FontWeight.bold),
    );
  }
}
