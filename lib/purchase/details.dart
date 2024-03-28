import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const OrderDetailPage({super.key, required this.product});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<String> selectedHistory = [];
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
    return Scaffold(
      backgroundColor: greyShade400Color,
      appBar: MainAppBar(
          text: "Order Details",
          appBar: AppBar(),
          onPressed: () {
            Navigator.pop(context);
          }),
      body: Container(
        height: 600,
        child: Column(
          children: [
            _dateTime(),
            _address(),
            _orderDetail(),
            ListTile(
              leading: Text("Order Detail"),
              trailing: Text(widget.product["totalPrice"].toString()),
            )
          ],
        ),
      ),
    );
  }

  _address() {
    return ListTile(
      tileColor: mainBlueColor,
      title: TextWhite16(text: "Address"),
      leading: Image.asset("assets/address.png"),
      subtitle: selectedAddress != null
          ? TextWhite14(
              text:
                  '${selectedAddress!['add']}, ${selectedAddress!['city']}, ${selectedAddress!['postcode']}, ${selectedAddress!['state']}')
          : TextWhite14(text: 'No address selected'),
      // trailing: IconButton(
      //   icon: Icon(Icons.arrow_forward_ios_sharp),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => AddressPage(
      //           prePage: "fromProfile",
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }

  _orderDetail() {
    return Expanded(
      child: Card(
        child: Container(
          // margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.product["items"].length,
            itemBuilder: (context, index) {
              final item = widget.product["items"][index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                leading: Image.network(
                  item['image'],
                  width: 70,
                ),
                title: TextBlack14(text: item['item']),
                subtitle: TextGrey14(text: item['quantity'].toString()),
                trailing: TextBlack14(
                    text: ("RM " +
                        (item['quantity'] * int.parse(item['price']))
                            .toString())),
              );
            },
          ),
        ),
      ),
    );
  }

  _divider() {
    return Divider(
      height: 2,
    );
  }

  _dateTime() {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _dateTimeWidget("Date", "23/23/23"),
          _dateTimeWidget("Time", "15:34"),
        ],
      ),
    );
  }

  _dateTimeWidget(leading, trailing) {
    return ListTile(
      leading: TextBlack14(text: leading),
      trailing: TextGrey14(text: trailing),
    );
  }
}
