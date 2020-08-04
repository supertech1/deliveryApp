import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: double.infinity,
      child: Material(
        color: Theme.of(context).primaryColor,
        child: Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 120,
                padding: EdgeInsets.only(top: 20),
                alignment: AlignmentDirectional.center,
                width: double.infinity,
                color: Color(0xffd18000),
                child: Image.asset(
                  'assets/images/foodxyme_logo.png',
                  width: 170,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.restaurant),
                        title: Text('Products'),
                      ),
                      ListTile(
                        leading: Icon(Icons.list),
                        title: Text('My Orders'),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('Delivery Location'),
                      ),
                      ListTile(
                        leading: Icon(Icons.favorite),
                        title: Text('Favorites'),
                      ),
                      ListTile(
                        leading: Icon(Icons.question_answer),
                        title: Text('FAQs'),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                      ),
                      // ListTile(
                      //   leading: Icon(Icons.person),
                      //   title: Text('Profile'),
                      // ),

                      Container(
                          padding: EdgeInsets.only(top: 80),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Login",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "or",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Create Account",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
