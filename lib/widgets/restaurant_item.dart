import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodxyme/screens/restaurants.dart';
import '../screens/restaurant_detail.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import 'package:intl/intl.dart';

class RestaurantItem extends StatelessWidget {
  final double width, height; // for the width of the container
  final storeName, opensAt, closesAt, address, rating, logo, restaurantId;

  const RestaurantItem(
      {this.width,
      this.height,
      this.storeName,
      this.opensAt,
      this.closesAt,
      this.address,
      this.rating,
      this.logo,
      this.restaurantId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RestaurantDetail.screen_id,
            arguments: {"restaurantId": restaurantId, "storeName": storeName});
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: Colors.black12,
            width: width,
            height: height,
            child: GridTile(
              child: CachedNetworkImage(
                imageUrl: "https://foodxyme.com/vendorimages/$logo",
                placeholder: (context, url) =>
                    Image.asset("assets/images/loading.gif"),
              ),
              // FadeInImage.assetNetwork(
              //     placeholder: 'assets/images/loading.gif',
              //     image: "https://foodxyme.com/vendorimages/$logo"),
              // logo != null
              //     ? Image.network(
              //         "https://foodxyme.com/vendorimages/$logo",
              //         fit: BoxFit.cover,
              //       )
              //     : Image.asset("assets/images/restaurant.jpg"),
              header: GridTileBar(
                backgroundColor: Colors.black26,
                title: Text(
                  storeName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                  color: Theme.of(context).accentColor,
                ),
              ),
              footer: GridTileBar(
                  backgroundColor: Colors.black38,
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.timer,
                          color: Theme.of(context).accentColor,
                          size: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 4),
                          width: 120,
                          child: Text(
                            opensAt.toString().substring(0, 5) +
                                " AM - " +
                                closesAt.toString().substring(0, 5) +
                                " PM",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).accentColor,
                          size: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          width: 150,
                          child: Text(
                            address,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
