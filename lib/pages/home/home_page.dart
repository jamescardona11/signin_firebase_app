import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: FutureBuilder<FirebaseUser>(
            future: Auth.instance.user,
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.hasData) {
                final user = snapshot.data;

                return ListView(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      child: _imageOrPhoto(user),
                    ),
                    SizedBox(height: 10),
                    Text(
                      user.displayName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.email,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 20),
                    CupertinoButton(
                        child: Text('Logout'),
                        onPressed: () {
                          Auth.instance.logOut(context);
                        })
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Network error'),
                );
              }

              return Center(
                child: FlatButton(
                    onPressed: () {
                      Auth.instance.logOut(context);
                    },
                    child: Text('Home Page')),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _imageOrPhoto(FirebaseUser user) {
    Widget childReturn;

    if (user.photoUrl != null && user.photoUrl.length > 0) {
      childReturn = ClipOval(
        child: Image.network(
          user.photoUrl,
          width: 74,
          height: 74,
          fit: BoxFit.cover,
        ),
      );
    } else {
      final List<String> tmp = user.displayName.split(" ");

      String alias = '';
      if (tmp.length > 0) {
        alias = tmp[0][0];
        if (tmp.length >= 2) alias = alias + tmp[1][0];
      }

      childReturn = Center(
        child: Text(
          alias,
          style: TextStyle(fontSize: 30),
        ),
      );
    }

    return childReturn;
  }
}
