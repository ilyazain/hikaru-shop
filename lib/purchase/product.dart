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
                      // color: Colors.amber,
                      // height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 200),
                      child: const CircularProgressIndicator(
                          backgroundColor: mainBlueColor, color: whiteColor),
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
                      return Column(
                        children: [
                          _allFilterButton(),
                          Text('No products found'),
                        ],
                      );
                    }
                  }
                  return Container(
                    child: PoppinsBlack14(
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
                  width: MediaQuery.of(context).size.width / 2,
                  height: 300,
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(
                          stateData[index].thumbnail.toString(),
                          width: 100,
                          height: 100,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  stateData[index].title.toString(),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  stateData[index].price.toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          stateData[index].description.toString(),
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
            color: isSelected ? mainBlueColor : orangeShade300Color,
            child: Center(
                child: isSelected
                    ? PoppinsWhite14(text: title)
                    : PoppinsBlack14(
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
