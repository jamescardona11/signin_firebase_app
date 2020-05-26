import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      child: Column(
        children: <Widget>[
          _InputTextLogin(
            iconPath: 'assets/icons/email.svg',
            placeholder: 'Email address',
          ),
          SizedBox(height: 10),
          _InputTextLogin(
            iconPath: 'assets/icons/key.svg',
            placeholder: 'Password',
          ),
          SizedBox(height: 200),
        ],
      ),
    );
  }
}

class _InputTextLogin extends StatelessWidget {
  final String placeholder;
  final String iconPath;

  const _InputTextLogin({
    @required this.iconPath,
    @required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      prefix: Container(
        width: 40,
        height: 30,
        child: SvgPicture.asset(
          this.iconPath,
          color: Color(0xffCCCCCC),
        ),
      ),
      placeholder: this.placeholder,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xffDDDDDD)),
        ),
      ),
    );
  }
}
