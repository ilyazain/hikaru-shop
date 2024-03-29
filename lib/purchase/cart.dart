import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/alert.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/home.dart';
import 'package:hikaru_e_shop/profile/address.dart';
import 'package:intl/intl.dart';
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
  int selectedCart = -1;
  dynamic itemSelectedCart;
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
                    ?.map(
                      (item) => json.decode(
                        item,
                      ),
                    )
                    .toList() ??
                [];
            // calculateTotalPrice();
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

    String formattedDateTime =
        DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    String address =
        '${selectedAddress!['add']}, ${selectedAddress!['city']}, ${selectedAddress!['postcode']}, ${selectedAddress!['state']}';
    OrderDetail orderDetail = OrderDetail(
        id: historyItems.length + 1,
        items: cartItems,
        totalPrice: totalPrice,
        dateTime: formattedDateTime,
        address: address);
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
    totalPrice = 0;
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
            cartItems.isNotEmpty
                ? ElevatedButton(
                    onPressed: clearCart,
                    child: Text("Clear Cart"),
                  )
                : Container(),
            ListTile(
                leading:
                    cartItems.isNotEmpty ? TextBlack14(text: "Total") : null,
                trailing: _getTotalPrice()),
            MainBlueButton(
              onPressed: () {
                cartItems.isNotEmpty
                    ? selectedAddress != null
                        ? addToHistory()
                        : showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return OkAlert(
                                title: "Address epmty",
                                subtitle: "Please add or select address",
                                okOnpressed: () {
                                  // Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddressPage(
                                        prePage: "fromCart",
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
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

  _getTotalPrice() {
    // _updateCartList();
    calculateTotalPrice();
    return cartItems.isNotEmpty
        ? TextBlack14(text: "RM " + totalPrice.toString())
        : null;
  }

  _cartEmpty() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30, bottom: 10, top: 130),
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
        Expanded(
          child: _cartItem(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: orangeShade300Color,
            foregroundColor: Colors.white,
          ),
          child: const TextWhite14(
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
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.network(
              item['image'],
              width: 80,
            ),
          ),
          title: TextBlack14(text: item['item']),
          subtitle: TextGrey14(text: item['quantity'].toString()),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextBlack14(
                  text: ("RM " +
                      (item['quantity'] * int.parse(item['price']))
                          .toString())),
              // SizedBox(
              //   width: 10,
              // )
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: redColor,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return YesNoAlert(
                        title: "Delete item?",
                        subtitle:
                            "Are you sure you want to delete ${item['item']} in cart?",
                        yesOnpressed: () {
                          setState(() {
                            cartItems.removeAt(index);
                            if (selectedCart == index) {
                              selectedCart = -1;
                              itemSelectedCart = null;
                            }
                          });
                          _updateCartList();
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartJsonList =
        cartItems.map((item) => json.encode(item)).toList();
    prefs.setStringList('cart', cartJsonList);
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
  final String dateTime;
  final String address;

  OrderDetail(
      {required this.id,
      required this.items,
      required this.totalPrice,
      required this.dateTime,
      required this.address});

  // Convert OrderDetail instance to a JSON-encodable map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items,
      'totalPrice': totalPrice,
      'dateTime': dateTime,
      'address': address
    };
  }
}
