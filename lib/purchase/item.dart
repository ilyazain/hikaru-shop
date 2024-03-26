import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/button.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/purchase/bloc_model/menu_model.dart';
import 'package:hikaru_e_shop/purchase/cart.dart';
import 'package:hikaru_e_shop/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemPage extends StatefulWidget {
  final String item;
  final String image;
  final String desc;
  final String price;
  const ItemPage(
      {super.key,
      required this.item,
      required this.image,
      required this.desc,
      required this.price});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  // List<MenuModel> items = [];

  // void addItem(MenuModel menuModel) {
  //   items.add(menuModel);
  // }

  // void removeItem(MenuModel menuModel) {
  //   items.remove(menuModel);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          text: "Item",
          appBar: AppBar(),
          onPressed: () {
            Navigator.pop(context);
          }),
      body: Container(
        child: Column(
          children: [
            Image.network(widget.image),
            ListTile(
              leading: Text(widget.item),
              trailing: Text(widget.price),
            ),
            Text(widget.desc),
            Text("data")
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
                    height: 200,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.network(
                              widget.image,
                              scale: 8,
                              // width: 10,
                              // height: 10,
                            ),
                            Column(
                              children: [
                                Text(widget.item),
                                Row(
                                  children: [
                                    Text("Quantity"),
                                    IconButton(
                                      icon: Icon(Icons.remove),
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
                                      icon: Icon(Icons.add),
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
                        MainBlueButton(
                          onPressed: () {
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
                          title: const PoppinsWhite14(
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
          title: const PoppinsWhite14(
            text: "Add To Cart",
          ),
        ),
      ),
    );
  }
}
