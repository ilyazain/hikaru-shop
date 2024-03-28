import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool _passwordVisible = false;
  bool _usernameVisible = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/background.png"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child: TextField(
              //     // cursorColor: greenishBlue,
              //     obscureText: !_usernameVisible,
              //     controller: _unameController,
              //     decoration: const InputDecoration(
              //       fillColor: mainBlueColor,
              //       focusColor: mainBlueColor,
              //       border: OutlineInputBorder(
              //           borderSide: BorderSide(color: mainBlueColor)),
              //       labelText: 'ID Pengguna',
              //       // hintText: 'Masukkan ID Pengguna'
              //     ),
              //   ),
              // ),
              _textField(
                  _unameController, !_usernameVisible, 'ID Pengguna', Text("")),
              // Padding(
              //   padding: EdgeInsets.only(
              //       left: 15.0, right: 15.0, top: 15, bottom: 0),
              //   child: TextFormField(
              //     controller: _pwdController,
              //     obscureText: !_passwordVisible,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Kata Laluan',
              //       suffixIcon: IconButton(
              //         icon: Icon(
              //           _passwordVisible
              //               ? Icons.visibility
              //               : Icons.visibility_off,
              //           color: mainBlueColor,
              //         ),
              //         onPressed: () {
              //           setState(() {
              //             _passwordVisible = !_passwordVisible;
              //           });
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              _textField(
                _pwdController,
                !_passwordVisible,
                'Kata Laluan',
                IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: mainBlueColor,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _passwordVisible = !_passwordVisible;
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: MainBlueButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  title: const TextWhite14(
                    text: "LOG MASUK",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _textField(controller, obscureText, lblText, suffixIcon) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: lblText,
            suffixIcon: suffixIcon),
      ),
    );
  }
}
