import 'package:flutter/material.dart';
import 'package:hikaru_e_shop/common_data/appbar.dart';
import 'package:hikaru_e_shop/purchase/item.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(text: "eShop", appBar: AppBar(), onPressed: () {}),
      body: Container(
        width: double.infinity,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ListTile(
            //   leading: Text("IPhone 14"),
            //   trailing: Text("RM40"),
            // ),
            // Text("lorem ipsum"),
            Wrap(
              children: List.generate(
                listItem.length,
                (index) {
                  return Card(
                    child: GestureDetector(
                      onTap: () {
                        print("hehe: " +
                            listItem[index]['description'].toString());

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemPage(
                              image: listItem[index]['image'].toString(),
                              item: listItem[index]['item'].toString(),
                              price: listItem[index]['price'].toString(),
                              desc: listItem[index]['description'].toString(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.network(
                              listItem[index]['image'],
                              width: 100,
                              height: 100,
                            ),
                            Text(listItem[index]["item"]),
                            Text(listItem[index]["description"]),
                            Text(listItem[index]["price"])
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
