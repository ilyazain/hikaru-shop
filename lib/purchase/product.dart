import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikaru_e_shop/common_data/alert.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/login.dart';
import 'package:hikaru_e_shop/purchase/bloc_model/product_bloc.dart';
import 'package:hikaru_e_shop/purchase/bloc_model/product_model.dart';
import 'package:hikaru_e_shop/purchase/item.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int stateLength = 0;
  List<Products> stateData = [];
  int selectedFilterIndex = 0;
  List<String> filterTitles = [
    "All",
    "Smartphone",
    "Laptop",
    "Cap",
    "Skincare",
    "Grocery",
  ];
  @override
  void initState() {
    Provider.of<GetProductBloc>(context, listen: false).add(
      PostGetAllProduct(),
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
        backgroundColor: mainBlueColor,
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
          child: Column(
            children: [
              BlocBuilder<GetProductBloc, GetProductState>(
                builder: ((context, state) {
                  if (state is LoadingGetProduct) {
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 180),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/shy_girl.png",
                            height: 200,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: TextWhite16(
                                text: "Please wait for a minute..."),
                          ),

                          // const CircularProgressIndicator(
                          //     backgroundColor: mainBlueColor,
                          //     color: whiteColor),
                        ],
                      ),
                    );
                  }
                  if (state is SuccessfulGetAllProduct) {
                    final data = state.output!.products!;
                    stateData = data;
                    if (state.output?.products != null &&
                        state.output!.products!.isNotEmpty) {
                      stateLength = state.output!.products!.length;
                      return _productCard(stateLength, stateData);
                    } else {
                      return Text('No products found');
                    }
                  }
                  if (state is SuccessfulGetCategoryProduct) {
                    final data = state.output!.products!;
                    stateData = data;
                    if (state.output?.products != null &&
                        state.output!.products!.isNotEmpty) {
                      stateLength = state.output!.products!.length;
                      return _productCard(stateLength, stateData);
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            _allFilterButton(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30, top: 110, bottom: 10),
                              child: Image.asset(
                                "assets/shy_girl2.png",
                                height: 200,
                              ),
                            ),
                            Container(
                              // color: Colors.amber,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: const Center(
                                child: TextWhite16(
                                    text:
                                        "No product found. Sorry for the inconvenience. Please select other filter. Thank you"),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  return Container(
                    child: TextBlack14(
                      text: "Sorry, the server was down",
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _productCard(stateLength, stateData) {
    return Column(
      children: [
        _allFilterButton(),
        Wrap(
          children: List.generate(
            stateLength,
            (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemPage(
                          image: stateData[index].thumbnail.toString(),
                          item: stateData[index].title.toString(),
                          price: stateData[index].price.toString(),
                          desc: stateData[index].description.toString(),
                          images: stateData[index].images!),
                    ),
                  );
                },
                child: Container(
                  // margin: EdgeInsets.all(5),
                  // padding: EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 285,
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(
                          stateData[index].thumbnail.toString(),
                          width: 100,
                          height: 100,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 7,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: TextBlackBold12(
                                    text: stateData[index].title.toString(),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: TextMaroon12(
                                    text: "RM" +
                                        stateData[index].price.toString(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextBlack13(
                            text: stateData[index].description.toString(),
                          ),
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
  }

  _allFilterButton() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int index = 0; index < filterTitles.length; index++)
            _filterButton(
              filterTitles[index],
              index,
              () {
                setState(() {
                  selectedFilterIndex = index;
                });
                _onFilterButtonTap(index);
              },
              selectedFilterIndex == index,
            ),
        ],
      ),
    );
  }

  _filterButton(title, int index, onTap, bool isSelected) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 100,
            height: 30,
            // color: isSelected ? mainBlueColor : orangeShade300Color,
            decoration: BoxDecoration(
              color: isSelected ? greyShade300Color : orangeShade300Color,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: isSelected
                      ? orangeShade300Color
                      : whiteColor), // Add border color
            ),
            child: Center(
                child: isSelected
                    ? TextBlack14(text: title)
                    : TextBlack14(
                        text: title,
                      )),
          ),
        ),
      ),
    );
  }

  _onFilterButtonTap(int index) {
    switch (index) {
      case 0:
        Provider.of<GetProductBloc>(context, listen: false).add(
          PostGetAllProduct(),
        );
        break;
      case 1:
        Provider.of<GetProductBloc>(context, listen: false).add(
          PostGetCategoryProduct(category: "smartphones"),
        );
        break;
      case 2:
        Provider.of<GetProductBloc>(context, listen: false).add(
          PostGetCategoryProduct(category: "laptops"),
        );
        break;
      case 3:
        Provider.of<GetProductBloc>(context, listen: false).add(
          PostGetCategoryProduct(category: "cap"),
        );
        break;
      case 4:
        Provider.of<GetProductBloc>(context, listen: false).add(
          PostGetCategoryProduct(category: "skincare"),
        );
        break;
      case 5:
        Provider.of<GetProductBloc>(context, listen: false).add(
          PostGetCategoryProduct(category: "groceries"),
        );
        break;
      default:
        break;
    }
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
