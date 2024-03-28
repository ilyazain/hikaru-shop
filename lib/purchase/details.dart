import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';

class OrderDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const OrderDetailPage({super.key, required this.product});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<String> selectedHistory = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _dateTime("Date", "23/23/23"),
            _dateTime("Time", "15:34"),
            _divider(),
            Text("Address"),
            Text("Casa Subang Apartment"),
            _divider(),
            _orderDetail(),
            _divider(),
            ListTile(
              leading: Text("Order Detail"),
              trailing: Text(widget.product["totalPrice"].toString()),
            )
          ],
        ),
      ),
    );
  }

  _orderDetail() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.product["items"].length,
        itemBuilder: (context, index) {
          final item = widget.product["items"][index];
          return ListTile(
            leading: Image.network(item['image']),
            title: Text(item['item']),
            subtitle: Text(item['quantity'].toString()),
            trailing:
                Text((item['quantity'] * int.parse(item['price'])).toString()),
          );
        },
      ),
    );
  }

  _divider() {
    return Divider(
      height: 2,
    );
  }

  _dateTime(leading, trailing) {
    return ListTile(
      leading: Text(leading),
      trailing: Text(trailing),
    );
  }
}
