import 'package:flutter/material.dart';
import 'package:signinfirebaseapp/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign in App',
      home: LoginPage(),
    );
  }
}
