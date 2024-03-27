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
      appBar: MainAppBar(text: "Orders", appBar: AppBar(), onPressed: () {}),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: clearHistory,
              child: Text("Clear History"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailPage(),
                  ),
                );
              },
              child: Container(
                height: 300,
                child: ListView.builder(
                  itemCount: historyItems.length,
                  itemBuilder: (context, index) {
                    final items = historyItems[index];
                    // Check if 'item', 'quantity', and 'price' are not null before accessing them
                    final itemText = items['item'] ?? 'Unknown Item';
                    final quantityText = items['quantity'] != null
                        ? 'Quantity: ${items['quantity']}'
                        : 'Unknown Quantity';
                    final priceText = items['price'] != null
                        ? 'Price: ${items['price']}'
                        : 'Unknown Price';
                    return ListTile(
                      title: Text(itemText),
                      subtitle: Text('$quantityText, $priceText'),
                    );
                  },
                ),

                // Column(children: [
                //   ListTile(
                //     title: Text("data"),
                //     subtitle: Text("data"),
                //     trailing: Column(
                //       children: [Text("data"), Text("data")],
                //     ),
                //   )
                // ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
