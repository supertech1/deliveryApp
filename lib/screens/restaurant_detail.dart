import 'package:flutter/material.dart';
import 'package:foodxyme/models/cart_item.dart';
import 'package:foodxyme/models/restaurants_model.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_expansion_tile.dart';
import '../widgets/badge.dart';
import '../widgets/meal_item.dart';
import '../providers/restaurant_provider.dart';
import '../providers/cart_provider.dart';

class RestaurantDetail extends StatefulWidget {
  static final screen_id = './restaurant_detail';

  @override
  _RestaurantDetailState createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  bool loadingData = true;
  bool _initLoaded = false;

  List stockList = [];
  List supplements = [];
  dynamic currentRestaurantData;
  // Cart cart;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final argus =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final id = argus["restaurantId"];
    if (argus != null) {
      if (!_initLoaded) {
        Provider.of<RestaurantProvider>(context, listen: false)
            .fetchCurrentRestaurantData(id);
        _initLoaded = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    currentRestaurantData = Provider.of<RestaurantProvider>(
      context,
    ).currentRestaurantData;
    // cart = Provider.of<CartProvider>(
    //   context,
    // ).cart;
    if (currentRestaurantData != null) {
      stockList = currentRestaurantData["stock_list"];
      supplements = currentRestaurantData["supplements"];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(args["storeName"]),
        actions: <Widget>[
          Consumer<CartProvider>(
            builder: (_, cartProvider, child) {
              return Badge(
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, CartScreen.id);
                  },
                ),
                value: cartProvider.cart.cartItems.length.toString(),
                color: Colors.white, //cartsData.itemsCount.toString(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  "assets/images/food_edit.png",
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: AlignmentDirectional.center,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1),
                  ),
                  child: Text(
                    "Order Online",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: AlignmentDirectional.center,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                        vertical: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1)),
                  ),
                  child: Text("Gallery"),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: AlignmentDirectional.center,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1),
                  ),
                  child: Text("Restaurant Info"),
                ),
              ),
            ],
          ),
          Expanded(
            child: currentRestaurantData == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: stockList.map((meal) {
                        Provider.of<RestaurantProvider>(context, listen: false)
                            .resetCurrentRestaurantData();
                        List _list = meal.keys.toList();
                        if (_list[0] == "Meal Supplements") {
                          return Container();
                        }
                        return MealItem(
                          title: _list[0],
                          itemCount: meal[_list[0]].length.toString(),
                          listOfMeals: meal[_list[0]],
                          supplements: supplements,
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
