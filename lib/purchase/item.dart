import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/purchase/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemPage extends StatefulWidget {
  final String item;
  final String image;
  final String desc;
  final String price;
  final List<String> images;
  const ItemPage(
      {super.key,
      required this.item,
      required this.image,
      required this.desc,
      required this.price,
      required this.images});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyShade300Color,
      appBar: MainAppBar(
          haveTrailing: true,
          text: "Item",
          appBar: AppBar(),
          onPressed: () {
            Navigator.pop(context);
          }),
      body: Container(
        child: Column(
          children: [
            _slideImage(),
            ListTile(
              title: TextBlack18(text: widget.item),
              subtitle: TextMaroon18(text: "RM " + widget.price),
            ),
            Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(15),
              margin: EdgeInsets.all(10),
              child: TextBlack14(text: widget.desc),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: MainBlueButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                int quantity = 1;
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(10),
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image.network(
                              widget.image,
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                TextBlack14(text: widget.item),
                                Row(
                                  children: [
                                    TextBlack14(text: "Quantity"),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        color: blackColor,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            if (quantity > 1) {
                                              quantity--;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                    Text("$quantity"),
                                    IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: blackColor,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            quantity++;
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MainBlueButton(
                          onPressed: () {
                            SharedPreferences.getInstance().then((prefs) {
                              List<String> cartItems =
                                  prefs.getStringList('cart') ?? [];
                              cartItems.add(json.encode({
                                'item': widget.item,
                                'image': widget.image,
                                'price': widget.price,
                                'quantity': quantity,
                              }));
                              prefs.setStringList('cart', cartItems);
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(
                                  image: widget.image,
                                  item: widget.item,
                                  price: widget.price,
                                  quantity: quantity,
                                ),
                              ),
                            );
                          },
                          title: const TextWhite14(
                            text: "Add To Cart",
                          ),
                        )
                      ],
                    ),
                  );
                });
              },
            );
          },
          title: const TextWhite14(
            text: "Continue",
          ),
        ),
      ),
    );
  }

  _slideImage() {
    if (widget.images.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        height: 250,
        width: double.infinity,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.images.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 3,
                color: greyShade400Color);
          },
          itemBuilder: (context, index) {
            return Image.network(widget.images[index]);
          },
        ),
      );
    }
  }
}
