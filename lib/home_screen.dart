import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  late Size size;
  late List<String> categoryList;
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

  Widget textFormFieldAndBodyOfScaffold(){
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
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (buildContext, index) {
              return Image.asset(categoryList[index],
                width: size.width*.26,height: size.height*.26,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: size.width*.001,);
            },
            itemCount:categoryList.length,
          ),
        ),
        Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Best Selling',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'see all',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            )
        ),
      ],
    );
  }
  Widget bottomNavigationBar(){
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      fixedColor: Colors.red,
      onTap: (index){
        selectedIndex=index;
        setState(() {

        });
      },
      items: [
        bottomNavigationBarItem('Explore',Icons.explore),
        bottomNavigationBarItem('Cart',Icons.shopping_cart),
       bottomNavigationBarItem('Account',Icons.account_circle)
      ],
    );
  }
  BottomNavigationBarItem bottomNavigationBarItem(String text,IconData icon){
    return   BottomNavigationBarItem(
      label: text,
      icon:Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height*.01
        ),
        child: Icon(icon),
      ),
    );

  }
}
