import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: mainBlueColor,
        appBar: MainAppBar(
            haveTrailing: true,
            text: "Orders",
            appBar: AppBar(),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            }),
        body:

            // Column(
            //   children: [
            // ElevatedButton(
            //   onPressed: clearHistory,
            //   child: Text("Clear History"),
            // ),
            _order(),
        //   ],
        // ),
      ),
    );
  }

  _order() {
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: whiteColor),
        // height: 300,
        padding: EdgeInsets.all(10),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: historyItems.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(); // Add Divider between items
          },
          itemBuilder: (context, index) {
            final product = json.decode(historyItems[index]);
            final itemName =
                product['items'].map((e) => e['item']).join(', ') ??
                    'Unknown Item';
            final itemTotalPrice = product['totalPrice'] ?? 'Unknown Item';
            return GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailPage(
                      product: product,
                    ),
                  ),
                );
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: orangeShade300Color,
                  child: const Icon(
                    Icons.shopping_bag,
                    size: 28,
                    color: mainBlueColor,
                  ),
                ),
                title: Text(itemTotalPrice.toString()),
                subtitle: Text(itemName),
                trailing: Container(
                  width: 90,
                  // color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextBlack14(text: "RM $itemTotalPrice"),
                          const TextGrey14(text: "data"),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
