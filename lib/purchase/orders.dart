import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/purchase/details.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(text: "Orders", appBar: AppBar(), onPressed: () {}),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailPage(),
            ),
          );
        },
        child: Container(
          child: Column(children: [
            ListTile(
              title: Text("data"),
              subtitle: Text("data"),
              trailing: Column(
                children: [Text("data"), Text("data")],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
