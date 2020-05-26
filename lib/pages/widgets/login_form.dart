import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signinfirebaseapp/widgets/rounded_button.dart';

class LoginFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _InputTextLogin(
            iconPath: 'assets/icons/email.svg',
            placeholder: 'Email address',
          ),
          SizedBox(height: 20),
          _InputTextLogin(
            iconPath: 'assets/icons/key.svg',
            placeholder: 'Password',
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text('Forgot password?', style: TextStyle(fontFamily: 'sans')),
              onPressed: () {},
            ),
          ),
          SizedBox(height: 10),
          RoundedButtonWidget(label: 'Sign in', onPressed: () {}),
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
  }) : assert(iconPath != null && placeholder != null);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      prefix: Container(
        padding: EdgeInsets.all(2),
        width: 40,
        height: 30,
        child: SvgPicture.asset(
          this.iconPath,
          color: Color(0xffCCCCCC),
        ),
      ),
      placeholder: this.placeholder,
      placeholderStyle: TextStyle(fontFamily: 'sans', color: Color(0xffCCCCCC)),
      style: TextStyle(fontFamily: 'sans'),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xffDDDDDD)),
        ),
      ),
    );
  }
}
