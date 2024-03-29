import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';

class OrderDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const OrderDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyShade300Color,
      appBar: MainAppBar(
        text: "Order Details",
        appBar: AppBar(),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _orderDetail(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _address() {
  //   return ListTile(
  //     title: const TextBlack14(text: "Address"),
  //     leading: Image.asset("assets/address.png"),
  //     subtitle: TextGrey14(text: widget.product["address"]),
  //   );
  // }

  Widget _orderDetail() {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _listTileWidget("Datetime:", widget.product["dateTime"]),
          _listTileWidget("Address:", widget.product["address"]),
          Divider(),
          const Padding(
            padding: EdgeInsets.all(10),
            child: TextBlack14(text: "Order Detail"),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              // height: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.product["items"].length,
                itemBuilder: (context, index) {
                  final item = widget.product["items"][index];
                  return ListTile(
                    leading: Image.network(
                      item['image'],
                      width: 70,
                    ),
                    title: TextBlack14(text: item['item']),
                    subtitle: TextGrey14(text: "Quantity: ${item['quantity']}"),
                    trailing: TextBlack14(
                      text: "RM ${item['quantity'] * int.parse(item['price'])}",
                    ),
                  );
                },
              ),
            ),
          ),
          _totalPrice()
        ],
      ),
    );
  }

  Widget _listTileWidget(String leading, String trailing) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextBlack14(text: leading),
          SizedBox(width: 220, child: TextBlack13(text: trailing)),
        ],
      ),
    );
  }

  Widget _totalPrice() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      title: TextBlack14(text: "Total Price"),
      trailing: TextBlack14(
        text: "RM ${widget.product["totalPrice"]}",
      ),
    );
  }
}
