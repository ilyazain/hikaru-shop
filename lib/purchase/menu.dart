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
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10),
                        child: Container(
                          width: 100,
                          height: 30,
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              'ClipRRect',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Wrap(
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
                                      images: data[index].images! ),
                                  ),
                                );
                              },
                              child: Container(
                                // margin: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width / 2,
                                height: 300,
                                child: Card(
                                  child: Column(
                                    children: [
                                      Image.network(
                                        data[index].thumbnail.toString(),
                                        width: 100,
                                        height: 100,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            flex: 3,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              // color: Colors.red,
                                              child: Text(
                                                data[index].title.toString(),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              // color: Colors.blue,
                                              child: Text(
                                                data[index].price.toString(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        data[index].description.toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
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
