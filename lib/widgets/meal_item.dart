import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_expansion_tile.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  final String title, itemCount;
  final List listOfMeals; // for each meal under a meal item
  final List supplements;
  MealItem(
      {@required this.title,
      @required this.itemCount,
      this.listOfMeals,
      this.supplements});

  @override
  Widget build(BuildContext context) {
    CartProvider cart = Provider.of<CartProvider>(context, listen: false);

    return CustomExpansionTile(
        title: title,
        subtitle: Text("$itemCount Items"),
        children: [
          Container(
              height: 250,
              child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.restaurant,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(listOfMeals[index]["name"]),
                      subtitle: Text("#${listOfMeals[index]['stockprice']}"),
                      trailing: IconButton(
                        icon: Icon(Icons.add_box),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (title == "Main Meal" || title == "Soup") {
                            showModalBottomSheet(
                                context: context,
                                builder: (bctx) {
                                  return Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      "Select the supplements you want for this package",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  ...supplements.map((e) {
                                                    return Container(
                                                        width: double.infinity,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                  child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Checkbox(
                                                                      value:
                                                                          false,
                                                                      onChanged:
                                                                          null),
                                                                  Text(e[
                                                                      'name']),
                                                                ],
                                                              )),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    width: 40,
                                                                    height: 40,
                                                                    child:
                                                                        TextField(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      decoration: InputDecoration(
                                                                          hintText:
                                                                              "1",
                                                                          border:
                                                                              OutlineInputBorder()),
                                                                    ),
                                                                  ),
                                                                  Spacer()
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                    "#${e['stockprice']}")),
                                                          ],
                                                        ));
                                                  }).toList()
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: RaisedButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 1,
                                                        color: Theme.of(context)
                                                            .primaryColor)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: RaisedButton.icon(
                                                icon: Icon(
                                                    Icons.add_shopping_cart),
                                                label: Text("Add to cart"),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                onPressed: () {},
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            CartItem item = CartItem(
                                id: listOfMeals[index]["idstockdetails"],
                                name: listOfMeals[index]["name"],
                                price: 20,
                                qty: 1,
                                subTotal: 20);
                            cart.addToCart(
                                "1",
                                listOfMeals[index]["vendor_id"],
                                "ade street",
                                item,
                                double.parse(listOfMeals[index]["stockprice"]),
                                false);
                            print(cart.cart.totalAmount.toString());
                          }
                        },
                      ),
                    );
                  },
                  itemCount: int.parse(itemCount)))
        ]

        // listOfMeals.map((meal) {
        //   return ListTile(
        //     leading: Icon(
        //       Icons.restaurant,
        //       color: Theme.of(context).primaryColor,
        //     ),
        //     title: Text(meal["name"]),
        //     subtitle: Text("#${meal['stockprice']}"),
        //     trailing: Icon(
        //       Icons.add_box,
        //       color: Theme.of(context).primaryColor,
        //     ),
        //   );
        // }).toList(),
        );
  }
}
