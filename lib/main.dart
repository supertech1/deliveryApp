import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/restaurant_provider.dart';
import './providers/cart_provider.dart';
import './screens/products.dart';
import './screens/restaurant_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xffF79E05),
          accentColor: Color(0xffFF3008),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryTextTheme:
              TextTheme(headline6: TextStyle(color: Colors.white)),
          primaryIconTheme: const IconThemeData.fallback().copyWith(
            color: Colors.white,
          ),
        ),
        initialRoute: Products.screen_id,
        routes: {
          Products.screen_id: (context) => Products(),
          RestaurantDetail.screen_id: (context) => RestaurantDetail(),
        },
      ),
    );
  }
}
