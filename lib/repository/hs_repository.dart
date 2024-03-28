import 'dart:convert';
import 'package:http/http.dart' as http;

class HikaShopRepository {
  fetchAllProducts() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products'),
    );
    return response.body;
  }

  fetchProductByCategory(var category) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products/category/$category'),
    );
    return response.body;
  }

  // fetchAllCategory() async {
  //   final response = await http.get(
  //     Uri.parse('https://dummyjson.com/products/categories'),
  //   );
  //   return response.body;
  // }

  // Future<List<Product>> fetchAllProducts() async {
  //   final response =
  //       await http.get(Uri.parse('https://dummyjson.com/products'));
  //   if (response.statusCode == 200) {
  //     List<dynamic> data = json.decode(response.body);
  //     List<Product> products =
  //         data.map((json) => Product.fromJson(json)).toList();
  //     return products;
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }

  // validatePerson(String usrId, String passNo, String docNo, String nat) async {
  //   client.setApi('/generate-qr/InqLayer3');
  //   var jsonBody = {
  //     "usrId": usrId,
  //     "epassNo": passNo.trim(),
  //     "docNo": docNo.trim(),
  //     "natCd": nat.trim()
  //   };
  //   print(jsonBody);
  //   client.setBody(jsonBody);
  //   var response = await client.post();
  //   return response.body;
  // }
}
