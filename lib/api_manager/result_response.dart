import 'package:ecommerce_app/api_manager/all_products.dart';
import 'package:http/http.dart' as http;

class ResultResponse {

 static Future<List<Products>>  fetchProductsData() async {
    http.Response response =
    await http.get(Uri.parse('https://fakestoreapi.com/products'));
    List<Products> products = productsFromJson(response.body);
    if (response.statusCode == 200) {
      return products;
    } else {
      throw Exception('Failed loading');
    }
  }

}
