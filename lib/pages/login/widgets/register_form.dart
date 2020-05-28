import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signinfirebaseapp/libs/auth.dart';
import 'package:signinfirebaseapp/pages/home/home_page.dart';
import 'package:signinfirebaseapp/pages/login/widgets/login_form.dart';
import 'package:signinfirebaseapp/utils/app_colors.dart';
import 'package:signinfirebaseapp/utils/dialogs.dart';
import 'package:signinfirebaseapp/utils/responsive.dart';
import 'package:signinfirebaseapp/widgets/rounded_button.dart';

class RegisterFormWidget extends StatefulWidget {
  final VoidCallback onGotoLogin;
  final Alignment alignment;

  const RegisterFormWidget({Key key, this.onGotoLogin, this.alignment}) : super(key: key);
  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  bool _agree = false;
  final GlobalKey<InputTextLoginState> usernameKey = GlobalKey();
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
          padding: EdgeInsets.symmetric(horizontal: 15),
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'New Account',
                style: TextStyle(
                    color: AppColors.primary, fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'raleway'),
              ),
              SizedBox(height: responsive.inchPercent(1)),
              Text(
                's simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: responsive.inchPercent(3)),
              InputTextLogin(
                key: usernameKey,
                iconPath: 'assets/icons/avatar-user.svg',
                placeholder: 'Username',
                validator: (text) {
                  print('VALIDATOR');
                  return text.trim().length > 3;
                },
              ),
              SizedBox(height: responsive.inchPercent(2)),
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
              SizedBox(height: responsive.inchPercent(2)),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: responsive.inchPercent(1.2),
                  color: Colors.black,
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: _agree,
                      onChanged: (value) {
                        _agree = value;
                        setState(() {});
                      },
                    ),
                    Text('I Agree to the', style: TextStyle()),
                    InkWell(
                      child: Text(
                        'Terms of services',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(' & ', style: TextStyle()),
                    InkWell(
                      child: Text(
                        'Privacy policy',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsive.inchPercent(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: widget.onGotoLogin,
                    child: Text('← Back to Login', style: TextStyle()),
                  ),
                  RoundedButtonWidget(
                    label: 'Sign up',
                    onPressed: _submit,
                  ),
                ],
              ),
              SizedBox(height: responsive.inchPercent(3.3)),
            ],
          ),
        ),
      ),
    );
  }

  _submit() async {
    final String username = usernameKey.currentState.value.toString().trim();
    final String email = emailKey.currentState.value.toString().trim();
    final String password = passwordKey.currentState.value.toString().trim();

    final bool usernameIsOk = usernameKey.currentState.isOk;
    final bool emailIsOk = emailKey.currentState.isOk;
    final bool passwordIsOk = passwordKey.currentState.isOk;

    if (usernameIsOk && emailIsOk && passwordIsOk) {
      if (_agree) {
        final firebaseUser = await Auth.instance.signUp(context, username, email, password);
        print(username);
        print(email);
        print(password);

        _goTo(firebaseUser);
      } else {
        Dialogs.alert(context, description: 'You need to accept the terms and conditions');
      }
    } else {
      Dialogs.alert(context, description: 'Some fields are invalid');
    }
  }

  void _goTo(FirebaseUser user) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      print('Register Failed');
    }
  }
}
