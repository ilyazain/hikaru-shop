import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikaru_e_shop/common_data/alert.dart';
import 'package:hikaru_e_shop/common_data/constant.dart';
import 'package:hikaru_e_shop/login.dart';
import 'package:hikaru_e_shop/purchase/bloc_model/menu_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (context) => GetMenuBloc()),
        Provider.value(value: prefs),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        //           subtitle: "Are you sure you want to quit the application?",
        //           yesOnpressed: () {
        //             SystemNavigator.pop();
        //           },
        //         );
        //       },
        //     );
        //     return false;
        //   },
        //   child:

        MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hikaru Shop',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: mainBlueColor),
              useMaterial3: true,
            ),
            home: const LoginPage()
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
            // ),
            );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
