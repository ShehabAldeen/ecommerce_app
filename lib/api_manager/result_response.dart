import 'package:ecommerce_app/api_manager/all_products.dart';
import 'package:http/http.dart' as http;

class ResultResponse {

 static Future<List<Products>>  fetchProductsData(
     [String? category,String? categoryName]) async {

    http.Response response =
    await http.get(Uri.parse(
        'https://fakestoreapi.com/products/${category??''}/${categoryName??''}'));
    List<Products> products = productsFromJson(response.body);
    if (response.statusCode == 200) {
      return products;
    } else {
      throw Exception('Failed loading');
    }
  }

}
