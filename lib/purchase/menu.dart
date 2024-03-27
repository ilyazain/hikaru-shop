import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikaru_e_shop/common_data/alert.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/login.dart';
import 'package:hikaru_e_shop/purchase/bloc_model/menu_bloc.dart';
import 'package:hikaru_e_shop/purchase/item.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<dynamic> listItem = [
    {
      // 'image': "image1",
      'image':
          "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
      'item': "item1",
      'description': "desc1",
      'price': "price1"
    },
    {
      // 'image': "image2",
      'image':
          "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
      'item': "item2",
      'description': "desc2",
      'price': "price2"
    },
    {
      // 'image': "image3",
      'image':
          "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
      'item': "item3",
      'description': "desc3",
      'price': "price3"
    },
    {
      // 'image': "image4",
      'image':
          "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
      'item': "item4",
      'description': "desc4",
      'price': "price4"
    },
    {
      // 'image': "image5",
      'image':
          "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
      'item': "item5",
      'description': "desc5",
      'price': "price5"
    },
    {
      // 'image': "image6",
      'image':
          "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
      'item': "item6",
      'description': "desc6",
      'price': "price6"
    },
  ];

  @override
  void initState() {
    Provider.of<GetMenuBloc>(context, listen: false).add(
      PostGetMenu(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return _closeAlert();
          },
        );
        return false;
      },
      child: Scaffold(
        appBar: MainAppBar(
            haveTrailing: true,
            text: "eShop",
            appBar: AppBar(),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return _closeAlert();
                },
              );
            }),
        body: SingleChildScrollView(
          child: BlocBuilder<GetMenuBloc, GetMenuState>(
            builder: ((context, state) {
              if (state is LoadingGetMenu) {
                return Container(
                  // color: Colors.amber,
                  // height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 200),
                  child: const CircularProgressIndicator(
                      backgroundColor: mainBlueColor, color: whiteColor),
                );
              }
              if (state is SuccessfulGetMenu) {
                final data = state.output!.products!;
                if (state.output?.products != null &&
                    state.output!.products!.isNotEmpty) {
                  return Wrap(
                    children: List.generate(
                      state.output!.products!.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemPage(
                                  image: data[index].thumbnail.toString(),
                                  item: data[index].title.toString(),
                                  price: data[index].price.toString(),
                                  desc: data[index].description.toString(),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Image.network(
                                  data[index].thumbnail.toString(),
                                  width: 100,
                                  height: 100,
                                ),
                                Text(data[index].title.toString()),
                                Text(data[index].description.toString()),
                                Text(data[index].price.toString())
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  );
                } else {
                  return Text('No products found');
                }
              }
              return Container(
                child: PoppinsBlack14(
                  text: "Sorry, the server was down",
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  _closeAlert() {
    return YesNoAlert(
      title: "Quit?",
      subtitle: "Are you sure you want to quit?",
      yesOnpressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      },
    );
  }
}
