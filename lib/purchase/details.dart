import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          MainAppBar(text: "Order Details", appBar: AppBar(), onPressed: () {}),
      body: Container(
        child: Column(
          children: [
            _dateTime("Date", "23/23/23"),
            _dateTime("Time", "15:34"),
            _divider(),
            Text("Address"),
            Text("Casa Subang Apartment"),
            _divider(),
            ListTile(
              leading: Image.network(
                "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
              ),
              title: Text("Item"),
              subtitle: Text("Qt2: 2"),
              trailing: Text("RM 350"),
            ),
            _divider(),
            ListTile(
              leading: Text("Order Detail"),
              trailing: Text("RM 450"),
            )
          ],
        ),
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
