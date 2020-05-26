import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signinfirebaseapp/pages/widgets/login_form.dart';
import 'package:signinfirebaseapp/pages/widgets/welcome.dart';
import 'package:signinfirebaseapp/utils/responsive.dart';

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
    final Responsive responsive = new Responsive.of(context);
    return Scaffold(
      body: GestureDetector(
        //TODO when click in textfield singlechild scroll to top
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              height: responsive.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  WelcomeWidget(),
                  LoginFormWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
