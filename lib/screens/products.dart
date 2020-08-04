import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './restaurants.dart';
import './bars.dart';
import './pharmacy.dart';
import './supermarket.dart';
import '../widgets/custom_drawer.dart';
import '../providers/restaurant_provider.dart';
import '../widgets/badge.dart';

class Products extends StatefulWidget {
  static final screen_id = "/products";
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<Map<String, Widget>> pages;

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      {"title": Text("Restaurants"), "screen": Restaurants()},
      {"title": Text("Bars"), "screen": Bars()},
      {"title": Text("Supermarket"), "screen": SuperMarket()},
      {"title": Text("Pharmacy"), "screen": Pharmacy()},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantProvider(),
      child: CustomDrawer(
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Badge(
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, CartScreen.id);
                  },
                ),
                value: '0',
                color: Colors.white, //cartsData.itemsCount.toString(),
              ),
            ],
          ),
          body: pages[_selectedPageIndex]["screen"],
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Theme.of(context).accentColor,
              unselectedItemColor: Colors.white,
              currentIndex: _selectedPageIndex,
              type: BottomNavigationBarType.fixed,
              // type: BottomNavigationBarType.shifting,  if you use this property, you will have to do some settings like bgColor in the botoomnavbaritem, this property only add some animation effect
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.restaurant,
                      size: 20,
                    ),
                    title: Text(
                      "Restaurants",
                      style: TextStyle(fontSize: 12),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_drink,
                      size: 20,
                    ),
                    title: Text(
                      "Bars",
                      style: TextStyle(fontSize: 12),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_grocery_store,
                      size: 20,
                    ),
                    title: Text(
                      "Supermarkets",
                      style: TextStyle(fontSize: 12),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_pharmacy,
                      size: 20,
                    ),
                    title: Text(
                      "Pharmacy",
                      style: TextStyle(fontSize: 12),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
