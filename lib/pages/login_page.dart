import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signinfirebaseapp/pages/widgets/login_form.dart';
import 'package:signinfirebaseapp/pages/widgets/welcome.dart';

class LoginPage extends StatefulWidget {
  static final String id = 'login_page_route_id';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            WelcomeWidget(),
            LoginFormWidget(),
          ],
        ),
      ),
    );
  }
}
