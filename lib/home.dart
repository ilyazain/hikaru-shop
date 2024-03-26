import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/profile/profile.dart';
import 'package:hikaru_e_shop/purchase/menu.dart';
import 'package:hikaru_e_shop/purchase/orders.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> bottomBar = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.menu_book),
      label: 'Menu',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.list_alt),
      label: 'Orders',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_2_rounded),
      label: 'Profile',
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
    return

        // WillPopScope(
        //   onWillPop: () async {
        //     showDialog(
        //       context: context,
        //       barrierDismissible: false,
        //       builder: (context) {
        //         return YesNoAlert(
        //           title: "Quit?",
        //           subtitle: "Are you sure you want to quit?",
        //           yesOnpressed: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => LoginPage(),
        //               ),
        //             );
        //           },
        //         );
        //       },
        //     );
        //     return false;
        //   },
        //   child:

        Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
        children: const [
          MenuPage(),
          OrdersPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          );
        },
        items: bottomBar,
      ),
    );
  }
}
