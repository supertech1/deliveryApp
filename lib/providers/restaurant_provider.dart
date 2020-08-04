import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:foodxyme/screens/restaurants.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

import '../models/restaurants_model.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  dynamic currentRestaurantData;

  final url = Config.apiBaseUrl + "category/1";

  void fetchRestaurants() async {
    final response = await http.get(url,
        headers: {"Accept": "application/json", "token": Config.apiToken});
    List<dynamic> result = jsonDecode(response.body)['vendors'];

    _restaurants = result
        .map((e) => Restaurant(
            arrangement: e['arrangement'],
            vendorId: e['idvendors'],
            address: e['address'],
            logo: e['logo'],
            openingTime: e['open_at'],
            closingTime: e['close_at'],
            storeName: e['store_name'],
            regionId: e['region_id'],
            restaurantId: e['idvendors']))
        .toList();

    notifyListeners();
  }

  List<Restaurant> get restaurants {
    return [..._restaurants];
  }

  void fetchCurrentRestaurantData(String vendorId) async {
    String url = Config.apiBaseUrl + "vendor/$vendorId";
    final response = await http.get(url,
        headers: {"Accept": "application/json", "token": Config.apiToken});
    dynamic result = jsonDecode(response.body);
    currentRestaurantData = result;
    notifyListeners();
  }

  void resetCurrentRestaurantData() {
    currentRestaurantData = null;
  }
}
