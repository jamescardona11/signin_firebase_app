import 'package:flutter/material.dart';
import 'package:signinfirebaseapp/libs/auth.dart';

class HomePage extends StatefulWidget {
  static final String id = 'home_page_route_id';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
            onPressed: () {
              Auth.instance.logOut(context);
            },
            child: Text('Home Page')),
      ),
    );
  }
}
