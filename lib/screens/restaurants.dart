import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../models/restaurants_model.dart';
import '../widgets/restaurant_item.dart';
import '../widgets/badge.dart';

class Restaurants extends StatefulWidget {
  static final screen_id = "/restautants";

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  List<Restaurant> all_restaurants = [];
  List<Restaurant> popular_restaurants = [];
  final controller = PageController(initialPage: 1);
  bool _initLoaded = false;

  List<Restaurant> getPopularRestaurant(List<Restaurant> allRest) {
    return allRest
        .where((restaurant) => int.parse(restaurant.arrangement) < 4)
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!_initLoaded) {
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchRestaurants();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (all_restaurants.isEmpty) {
      all_restaurants = Provider.of<RestaurantProvider>(
        context,
      ).restaurants;
    }

    popular_restaurants = getPopularRestaurant(all_restaurants);
    return all_restaurants.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Popular Restaurants",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: popular_restaurants
                            .map((e) => RestaurantItem(
                                  width: 250,
                                  height: 200,
                                  address: e.address,
                                  storeName: e.storeName,
                                  opensAt: e.openingTime,
                                  closesAt: e.closingTime,
                                  logo: e.logo,
                                  restaurantId: e.restaurantId,
                                ))
                            .toList()),
                  ),
                  Text(
                    "All Restaurants",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold),
                  ),
                  ...all_restaurants
                      .map((e) => RestaurantItem(
                            width: double.infinity,
                            height: 230,
                            address: e.address,
                            storeName: e.storeName,
                            opensAt: e.openingTime,
                            closesAt: e.closingTime,
                            logo: e.logo,
                            restaurantId: e.restaurantId,
                          ))
                      .toList()
                      .reversed,
                ],
              ),
            ),
          );
  }
}
