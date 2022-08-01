import 'package:ecommerce_app/home/home_screen.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = 'product_details';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late OneProduct product;
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context)!.settings.arguments as OneProduct;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: appBar(10),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            selectedIndex=index;
            setState(() {

            });
          },
          items: [
            BottomNavigationBarItem(
               label: '',
                icon: Column(
                  children: [
                    Text('Price',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    Text('\$${product.price }',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
            ),
            BottomNavigationBarItem(
               label: '',
               icon: Container(
                   padding: EdgeInsets.symmetric(
                       vertical: size.height*.02,
                       horizontal: size.width*.12
                   ),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8),
                       color: Colors.green
                   ),
                   child: Text('ADD',style: TextStyle(
                       color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),))),
          ],
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                        width: double.infinity,
                        height: size.height * .3,
                        margin: EdgeInsets.only(bottom: size.height * .03),
                        decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            shape: BoxShape.rectangle,
                            color: Colors.grey.shade800,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(product.image??'')))),
                    Positioned(
                        bottom: size.height * .01,
                        right: size.width * .03,
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Icon(
                              Icons.star_border_outlined,
                              color: Colors.white,
                            ))),
                    Positioned(
                        bottom: size.height * .01,
                        left: size.width * .03,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, HomeScreen.routeName);
                            },
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                )))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title??'' ,
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.height*0.02,bottom: size.height*.02
                        ),
                        child: Text('Details:',style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 22),),
                      ),
                      Text(product.description??'' ,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
  
}

 AppBar appBar(double? toolbarHeight,[Widget? leadingWidget,Widget? titleWidget]){
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    toolbarHeight: toolbarHeight,
    leading: leadingWidget,
    title:titleWidget ,
    centerTitle: true,
  );
}
