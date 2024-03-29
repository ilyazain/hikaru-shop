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
      // backgroundColor: mainBlueColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/login.png",
                    height: 250,
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: mainBlueColor,
                          width: 2,
                        ),
                        color: whiteColor),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        _textField(_unameController, !_usernameVisible,
                            'Username', Text("")),
                        SizedBox(
                          height: 10,
                        ),
                        _textField(
                          _pwdController,
                          !_passwordVisible,
                          'Password',
                          IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
                              text: "LOGIN",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _textField(controller, obscureText, lblText, suffixIcon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: mainBlueColor,
                width: 2.0,
              ),
            ),
            labelText: lblText,
            suffixIcon: suffixIcon),
      ),
    );
  }
}
