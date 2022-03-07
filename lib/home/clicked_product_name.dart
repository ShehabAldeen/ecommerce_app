import 'package:ecommerce_app/api_manager/all_products.dart';
import 'package:ecommerce_app/home/home_screen.dart';
import 'package:ecommerce_app/home/product_details.dart';
import 'package:ecommerce_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api_manager/result_response.dart';

class ClickedCategory extends StatelessWidget {
  static const routeName='jwell';
  List<Products>? products;
  late AuthProvider provider;
  @override
  Widget build(BuildContext context) {
    provider=Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: appBar(100,
          InkWell(
              onTap: (){
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              child: Icon(Icons.arrow_back_ios,color: Colors.black)),
          Text(selectedCategory(provider), style: TextStyle(color: Colors.black),)),
      body:Container(
        width: double.infinity,
        child: futureBuilder(
            ResultResponse.fetchProductsData('category',
                selectedCategory(provider)),
            2,products,Axis.vertical,10,70),
      )
      );
  }

}

String selectedCategory(AuthProvider provider) {
  if(provider.index==0){
    return 'men';
  } else if (provider.index== 1) {
    return 'jewelery';
  } else if (provider.index == 2) {
    return 'electronics';
  }
  return '';
}

