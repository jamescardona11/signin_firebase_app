import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signinfirebaseapp/utils/responsive.dart';

class WelcomeWidget extends StatelessWidget {
  //static final String id = 'welcome_route_id';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return AspectRatio(
      aspectRatio: 16 / 11,
      child: LayoutBuilder(
        builder: (_, constrains) {
          return Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/login/clouds.svg',
                    width: constrains.maxWidth,
                    height: constrains.maxHeight * 0.7,
                  ),
                ),
                Positioned(
                  top: constrains.maxHeight * 0.7,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 1.5,
                        width: constrains.maxWidth,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(fontSize: responsive.inchPercent(2.5), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: constrains.maxHeight * 0.285,
                  child: SvgPicture.asset(
                    'assets/login/woman.svg',
                    width: constrains.maxWidth * 0.35,
                  ),
                ),
                Positioned(
                  top: constrains.maxHeight * 0.32,
                  right: 5,
                  child: SvgPicture.asset(
                    'assets/login/man.svg',
                    width: constrains.maxWidth * 0.26,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
