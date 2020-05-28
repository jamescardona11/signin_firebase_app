import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signinfirebaseapp/libs/auth.dart';
import 'package:signinfirebaseapp/utils/app_colors.dart';
import 'package:signinfirebaseapp/utils/responsive.dart';
import 'package:signinfirebaseapp/widgets/rounded_button.dart';

class RegisterFormWidget extends StatefulWidget {
  final VoidCallback onGotoLogin;

  const RegisterFormWidget({Key key, this.onGotoLogin}) : super(key: key);
  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  bool _agree = false;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
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
              _InputTextLogin(
                iconPath: 'assets/icons/avatar-user.svg',
                placeholder: 'Username',
              ),
              SizedBox(height: responsive.inchPercent(2)),
              _InputTextLogin(
                iconPath: 'assets/icons/email.svg',
                placeholder: 'Email address',
              ),
              SizedBox(height: responsive.inchPercent(2)),
              _InputTextLogin(
                iconPath: 'assets/icons/key.svg',
                placeholder: 'Password',
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
                    onPressed: () {},
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
