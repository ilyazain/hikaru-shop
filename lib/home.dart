import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/alert.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/login.dart';
import 'package:hikaru_e_shop/profile/address.dart';
import 'package:hikaru_e_shop/profile/profile.dart';
import 'package:hikaru_e_shop/purchase/cart.dart';
import 'package:hikaru_e_shop/purchase/menu.dart';
import 'package:hikaru_e_shop/purchase/item.dart';
import 'package:hikaru_e_shop/purchase/orders.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<dynamic> listItem = [
  //   {
  //     // 'image': "image1",
  //     'image':
  //         "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
  //     'item': "item1",
  //     'description': "desc1",
  //     'price': "price1"
  //   },
  //   {
  //     // 'image': "image2",
  //     'image':
  //         "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
  //     'item': "item2",
  //     'description': "desc2",
  //     'price': "price2"
  //   },
  //   {
  //     // 'image': "image3",
  //     'image':
  //         "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
  //     'item': "item3",
  //     'description': "desc3",
  //     'price': "price3"
  //   },
  //   {
  //     // 'image': "image4",
  //     'image':
  //         "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
  //     'item': "item4",
  //     'description': "desc4",
  //     'price': "price4"
  //   },
  //   {
  //     // 'image': "image5",
  //     'image':
  //         "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
  //     'item': "item5",
  //     'description': "desc5",
  //     'price': "price5"
  //   },
  //   {
  //     // 'image': "image6",
  //     'image':
  //         "https://img.freepik.com/free-vector/sweet-eyed-kitten-cartoon-character_1308-135596.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1711324800&semt=ais",
  //     'item': "item6",
  //     'description': "desc6",
  //     'price': "price6"
  //   },
  // ];
  List<BottomNavigationBarItem> bottomBar = [
    BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded),
      label: 'Profil',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.qr_code_2),
      label: 'Imbas QR',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: 'Dashboard',
    )
  ];
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
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
          },
        );
        return false;
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            MenuPage(), // Index 0
            OrdersPage(), // Index 1
            ProfilePage(), // Index 2 if online mode
          ],
        ),

        // Container(
        //   width: double.infinity,
        //   child: Column(
        //     // crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       // ListTile(
        //       //   leading: Text("IPhone 14"),
        //       //   trailing: Text("RM40"),
        //       // ),
        //       // Text("lorem ipsum"),
        //       Wrap(
        //         children: List.generate(
        //           listItem.length,
        //           (index) {
        //             return Card(
        //               child: GestureDetector(
        //                 onTap: () {
        //                   print("hehe: " +
        //                       listItem[index]['description'].toString());

        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                       builder: (context) => ItemPage(
        //                         image: listItem[index]['image'].toString(),
        //                         item: listItem[index]['item'].toString(),
        //                         price: listItem[index]['price'].toString(),
        //                         desc: listItem[index]['description'].toString(),
        //                       ),
        //                     ),
        //                   );
        //                 },
        //                 child: Container(
        //                   child: Column(
        //                     children: [
        //                       Image.network(
        //                         listItem[index]['image'],
        //                         width: 100,
        //                         height: 100,
        //                       ),
        //                       Text(listItem[index]["item"]),
        //                       Text(listItem[index]["description"]),
        //                       Text(listItem[index]["price"])
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             );
        //           },
        //         ).toList(),
        //       ),
        //     ],
        //   ),
        // ),
        // bottomNavigationBar: BottomNavigationBar(
        //   elevation: 2,
        //   currentIndex: _currentIndex,
        //   onTap: (index) async {
        //     if (index == 0) {}
        //     if (index == 1) {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => OrdersPage(),
        //         ),
        //       );
        //     }
        //     if (index == 2) {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => AddressPage()),
        //       );
        //     }
        //   },
        //   items: bottomBar,
        // ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            });
          },
          items: bottomBar,
        ),
      ),
    );
  }
}
