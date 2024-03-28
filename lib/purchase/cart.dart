import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/alert.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/home.dart';
import 'package:hikaru_e_shop/profile/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  final String? item;
  final String? image;
  final int? quantity;
  final String? price;
  const CartPage({super.key, this.item, this.image, this.quantity, this.price});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, dynamic>? selectedAddress;
  int totalPrice = 0;
  List<dynamic> cartItems = [];
  @override
  void initState() {
    super.initState();
    _loadCartItems();
    _loadSelectedAddress();
  }

  _loadCartItems() {
    SharedPreferences.getInstance().then(
      (prefs) {
        setState(
          () {
            cartItems = prefs
                    .getStringList('cart')
                    ?.map((item) => json.decode(item))
                    .toList() ??
                [];
            calculateTotalPrice();
          },
        );
      },
    );
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

  void addToHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> historyItems = prefs
            .getStringList('history')
            ?.map((item) => json.decode(item))
            .toList() ??
        [];

    OrderDetail orderDetail = OrderDetail(
      id: historyItems.length + 1,
      items: cartItems,
      totalPrice: totalPrice,
      // dateTime: DateTime.now()
    );
    String jsonStr = jsonEncode(orderDetail);

    // Add cart items to history
    historyItems.add(jsonStr);

    // Save history items to SharedPreferences
    prefs.setStringList(
        'history', historyItems.map((item) => json.encode(item)).toList());
    _alert();
  }

  void clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
    setState(() {
      cartItems.clear();
      totalPrice = 0;
    });
  }

  void calculateTotalPrice() {
    for (var item in cartItems) {
      totalPrice = (item['quantity'] *
              int.parse(
                item['price'],
              )) +
          totalPrice;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        // haveLeading: false,
        text: "Cart",
        appBar: AppBar(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
      ),
      body:
          Container(child: cartItems.isNotEmpty ? _cartFilled() : _cartEmpty()),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        height: 200,
        // color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
                leading: cartItems.isNotEmpty ? Text("Total") : null,
                trailing:
                    cartItems.isNotEmpty ? Text(totalPrice.toString()) : null),
            MainBlueButton(
              onPressed: () {
                cartItems.isNotEmpty
                    ? addToHistory()
                    : Navigator.pushNamed(context, '/home');
              },
              title: TextWhite14(
                  text: cartItems.isNotEmpty ? "Confirm" : "Add Item"),
            )
          ],
        ),
      ),
    );
  }

  _cartEmpty() {
    return Container(
      margin: EdgeInsets.all(15),
      // height: double.infinity,
      // color: mainBlueColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30, bottom: 10, top: 120),
            child: Image.asset(
              "assets/shy_girl2.png",
              height: 200,
            ),
          ),
          Container(
            // alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Center(
              child: TextBlack16(text: "Your cart is empty. Please add item"),
            ),
          ),
        ],
      ),
    );
  }

  _cartFilled() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: clearCart,
          child: Text("Clear Cart"),
        ),
        _cartItem(),
        MainBlueButton(
          title: const TextWhite14(
            text: "Add more item",
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        ListTile(
          title: Text("Address"),
          subtitle: selectedAddress != null
              ? Text(
                  '${selectedAddress!['add']}, ${selectedAddress!['city']}, ${selectedAddress!['postcode']}, ${selectedAddress!['state']}')
              : Text('No address selected'),
          trailing: IconButton(
              onPressed: () {
                print("object");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressPage(
                      prePage: "fromCart",
                    ),
                  ),
                );
              },
              icon: Icon(Icons.arrow_forward_ios_outlined)),
        )
      ],
    );
  }

  _cartItem() {
    return Expanded(
      child: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            leading: Image.network(item['image']),
            title: Text(item['item']),
            subtitle: Text(item['quantity'].toString()),
            trailing:
                // Text(item['price']),
                Text((item['quantity'] * int.parse(item['price'])).toString()),
          );
        },
      ),
    );
  }

  _alert() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return OkAlert(
          title: "Thank you",
          subtitle: "Thank you for buying with Hikaru Care",
          okOnpressed: () {
            clearCart();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        );
      },
    );
  }
}

// Define a class for the object
class OrderDetail {
  final int id;
  final List<dynamic> items;
  final int totalPrice;
  // final DateTime dateTime;

  OrderDetail({
    required this.id,
    required this.items,
    required this.totalPrice,
    // required this.dateTime
  });

  // Convert OrderDetail instance to a JSON-encodable map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items,
      'totalPrice': totalPrice,
      // 'dateTime': dateTime
    };
  }
}
