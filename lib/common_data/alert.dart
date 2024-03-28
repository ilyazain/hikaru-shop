import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';

class OkAlert extends StatelessWidget {
  String title;
  String subtitle;
  Function() okOnpressed;
  OkAlert({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.okOnpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              title,
            ),
            SizedBox(height: 15),
            Text(
              subtitle,
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainBlueColor),
                      onPressed: okOnpressed,
                      child: Container(
                        child: TextWhite14(
                          text: "OK",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class YesNoAlert extends StatelessWidget {
  String title;
  String subtitle;
  String? rightButton;
  String? leftButton;
  Function()? yesOnpressed;
  Function()? noOnpressed;
  YesNoAlert(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.rightButton,
      this.leftButton,
      this.yesOnpressed,
      this.noOnpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              title,
            ),
            SizedBox(height: 15),
            Text(
              subtitle,
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.black),
                      ),
                      onPressed: noOnpressed ??
                          () {
                            Navigator.pop(context);
                          },
                      child: TextBlack14(text: leftButton ?? "No"),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainBlueColor),
                      onPressed: yesOnpressed ??
                          () {
                            Navigator.pop(context);
                          },
                      child: TextWhite14(
                        text: rightButton ?? "Yes",
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
