import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'api_manager/all_products.dart';
import 'api_manager/result_response.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  late Size size;
  late List<String> categoryList;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    categoryList = [
      'assets/images/Men.png',
      'assets/images/Women.png',
      'assets/images/Devices.png',
      'assets/images/Gadgets.png',
      'assets/images/Gaming.png',
    ];
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
      body: Container(
        padding: EdgeInsets.only(
            top: size.height * .07,
            left: size.width * .05,
            right: size.width * .05),
        child: textFormFieldAndBodyOfScaffold(),
      ),
    );
  }

  Widget textFormFieldAndBodyOfScaffold() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: size.height * .04),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.grey.shade200),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "",
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        Text(
          'Categories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
            flex: 1,
            child: FutureBuilder(
              future: ResultResponse.fetchProductsData(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Products>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                List<Products>? products = snapshot.data;
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (buildContext, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: size.height * .02,
                                top: size.height * .05),
                            padding: EdgeInsets.all(13),
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.grey),
                            child: Text(
                              Category.values.elementAt(index).name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (buildContext, index) => SizedBox(
                          width: size.width * .04,
                        ),
                    itemCount: Category.values.length);
              },
            )),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Best Selling',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  await Future.delayed(const Duration(milliseconds: 3));
                  SchedulerBinding.instance?.addPostFrameCallback((_) {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastOutSlowIn);
                  });
                },
                child: Text(
                  'see all',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: ResultResponse.fetchProductsData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            List<Products>? products = snapshot.data;
            return Expanded(
              flex: 3,
              child: ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (buildContext, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: size.width * .5,
                            height: size.height * .3,
                            margin: EdgeInsets.only(bottom: size.height * .02),
                            decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(
                                        products?.elementAt(index).image ??
                                            '')))),
                        Text(
                          products?.elementAt(index).category?.name ?? '',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        Text(
                          products?.elementAt(index).title ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey),
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        Text(
                          '\$${products?.elementAt(index).price?.toString() ?? ''}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.green),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (buildContext, index) => SizedBox(
                        width: size.width * .04,
                      ),
                  itemCount: products?.length ?? 0),
            );
          },
        )
      ],
    );
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      fixedColor: Colors.red,
      onTap: (index) {
        selectedIndex = index;
        setState(() {});
      },
      items: [
        bottomNavigationBarItem('Explore', Icons.explore),
        bottomNavigationBarItem('Cart', Icons.shopping_cart),
        bottomNavigationBarItem('Account', Icons.account_circle)
      ],
    );
  }

  BottomNavigationBarItem bottomNavigationBarItem(String text, IconData icon) {
    return BottomNavigationBarItem(
      label: text,
      icon: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * .01),
        child: Icon(icon),
      ),
    );
  }
}
