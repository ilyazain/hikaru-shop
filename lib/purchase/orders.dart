import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/purchase/details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<dynamic> historyItems = [];

  @override
  void initState() {
    super.initState();
    // Retrieve purchase history items from SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        historyItems = (prefs.getStringList('history') ?? [])
            .map((item) => json.decode(item))
            .toList();
      });
    });
  }

  void clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('history');
    setState(() {
      historyItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          haveTrailing: true,
          text: "Orders",
          appBar: AppBar(),
          onPressed: () {}),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: clearHistory,
              child: Text("Clear History"),
            ),
            Container(height: 300, child: _order()
                ),
          ],
        ),
      ),
    );
  }

  _order() {
    return ListView.builder(
      itemCount: historyItems.length,
      itemBuilder: (context, index) {
        final product = json.decode(historyItems[index]);final itemName =
            product['items'].map((e) => e['item']).join(', ') ?? 'Unknown Item';
        final itemTotalPrice = product['totalPrice'] ?? 'Unknown Item';
        return GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailPage(product: product,),
              ),
            );
          },
          child: ListTile(
            title: Text(itemTotalPrice.toString()),
            subtitle: Text(itemName),
            trailing: Column(
                children: [Text(itemTotalPrice.toString()), Text("data")]),
            // subtitle: Text('$quantityText, $priceText'),
          ),
        );
      },
    );
  }
}
