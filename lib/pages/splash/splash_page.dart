import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signinfirebaseapp/libs/auth.dart';
import 'package:signinfirebaseapp/pages/home/home_page.dart';
import 'package:signinfirebaseapp/pages/login/login_page.dart';

class SplashPage extends StatefulWidget {
  static final String id = 'splash_page_route_id';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Auth.instance.user.then((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomePage.id);
      } else {
        Navigator.pushReplacementNamed(context, LoginPage.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
