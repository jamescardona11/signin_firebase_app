import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signinfirebaseapp/libs/auth.dart';
import 'package:signinfirebaseapp/pages/home/home_page.dart';
import 'package:signinfirebaseapp/utils/app_colors.dart';
import 'package:signinfirebaseapp/utils/dialogs.dart';
import 'package:signinfirebaseapp/utils/responsive.dart';
import 'package:signinfirebaseapp/widgets/circle_button.dart';
import 'package:signinfirebaseapp/widgets/rounded_button.dart';

class LoginFormWidget extends StatefulWidget {
  final VoidCallback onGotoRegister;
  final VoidCallback onGotoForgot;
  final Alignment alignment;

  const LoginFormWidget({Key key, this.onGotoRegister, this.onGotoForgot, this.alignment}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final GlobalKey<InputTextLoginState> emailKey = GlobalKey();
  final GlobalKey<InputTextLoginState> passwordKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);

    return Align(
      alignment: widget.alignment != null ? widget.alignment : Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: Container(
          width: 330,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InputTextLogin(
                key: emailKey,
                iconPath: 'assets/icons/email.svg',
                placeholder: 'Email address',
                validator: (text) {
                  return text.trim().contains('@');
                },
              ),
              SizedBox(height: responsive.inchPercent(2)),
              InputTextLogin(
                key: passwordKey,
                iconPath: 'assets/icons/key.svg',
                placeholder: 'Password',
                validator: (text) {
                  return text.trim().length > 6;
                },
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('Forgot password?', style: TextStyle(fontFamily: 'sans')),
                  onPressed: widget.onGotoForgot,
                ),
              ),
              SizedBox(height: responsive.inchPercent(2)),
              RoundedButtonWidget(
                label: 'Sign in',
                onPressed: _submit,
              ),
              SizedBox(height: responsive.inchPercent(3.3)),
              Text('Or continue with'),
              SizedBox(height: responsive.inchPercent(1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleButtonWidget(
                    backgroundColor: Color(0xff448AFF),
                    iconPath: 'assets/icons/facebook.svg',
                    onPressed: () async {
                      final user = await Auth.instance.facebook(context);
                      _goTo(context, user);
                    },
                  ),
                  SizedBox(width: 10),
                  CircleButtonWidget(
                    backgroundColor: Color(0xffFF1744),
                    iconPath: 'assets/icons/google.svg',
                    onPressed: () async {
                      final user = await Auth.instance.google(context);
                      _goTo(context, user);
                    },
                  ),
                ],
              ),
              SizedBox(height: responsive.inchPercent(2.7)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Don\'t have an account? ', style: TextStyle()),
                  CupertinoButton(
                    child: Text('Sign Up',
                        style: TextStyle(
                          fontFamily: 'sans',
                          fontWeight: FontWeight.w600,
                        )),
                    onPressed: widget.onGotoRegister,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _submit() async {
    final String email = emailKey.currentState.value.toString().trim();
    final String password = passwordKey.currentState.value.toString().trim();

    final bool emailIsOk = emailKey.currentState.isOk;
    final bool passwordIsOk = passwordKey.currentState.isOk;

    if (emailIsOk && passwordIsOk) {
      final firebaseUser = await Auth.instance.signIn(context, email, password);

      _goTo(context, firebaseUser);
    } else {
      Dialogs.alert(context, description: 'Some fields are invalid');
    }
  }

  void _goTo(BuildContext context, FirebaseUser user) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      print('Login Failed');
    }
  }
}

class InputTextLogin extends StatefulWidget {
  final String placeholder;
  final String iconPath;
  final String initValue;
  final bool Function(String text) validator;

  const InputTextLogin({
    Key key,
    @required this.iconPath,
    @required this.placeholder,
    this.validator,
    this.initValue,
  })  : assert(iconPath != null && placeholder != null),
        super(key: key);
  @override
  InputTextLoginState createState() => InputTextLoginState();
}

class InputTextLoginState extends State<InputTextLogin> {
  TextEditingController _controller;

  bool get isOk => _validation;
  String get value => _controller.text;

  bool _validation = false;

  void _checkValidation() {
    if (widget.validator != null) {
      final isOk = widget.validator(_controller.text);
      if (_validation != isOk) {
        _validation = isOk;
        setState(() {});
      }
    } else {}
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initValue);
    _checkValidation();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _controller,
      onChanged: (value) {
        _checkValidation();
      },
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      prefix: Container(
        padding: EdgeInsets.all(2),
        width: 40,
        height: 30,
        child: SvgPicture.asset(
          this.widget.iconPath,
          color: Color(0xffCCCCCC),
        ),
      ),
      suffix: widget.validator != null
          ? Icon(
              Icons.check_circle,
              color: _validation ? AppColors.primary : Colors.grey,
            )
          : null,
      placeholder: this.widget.placeholder,
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
