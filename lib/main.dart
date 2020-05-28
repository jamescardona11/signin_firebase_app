import 'package:flutter/material.dart';
import 'package:signinfirebaseapp/pages/home/home_page.dart';
import 'package:signinfirebaseapp/pages/login/login_page.dart';
import 'package:signinfirebaseapp/pages/splash/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign in App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'sans',
      ),
      home: LoginPage(),
      routes: {
        HomePage.id: (_) => HomePage(),
        LoginPage.id: (_) => LoginPage(),
        SplashPage.id: (_) => SplashPage(),
      },
    );
  }
}
