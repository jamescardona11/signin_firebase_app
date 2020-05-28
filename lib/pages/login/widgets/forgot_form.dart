import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signinfirebaseapp/libs/auth.dart';
import 'package:signinfirebaseapp/utils/app_colors.dart';
import 'package:signinfirebaseapp/utils/responsive.dart';
import 'package:signinfirebaseapp/widgets/rounded_button.dart';

class ForgotFormWidget extends StatefulWidget {
  final VoidCallback onGotoLogin;

  const ForgotFormWidget({Key key, this.onGotoLogin}) : super(key: key);
  @override
  _ForgotFormWidgetState createState() => _ForgotFormWidgetState();
}

class _ForgotFormWidgetState extends State<ForgotFormWidget> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);

    return Align(
      alignment: Alignment.center,
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
                'Reset Password',
                style: TextStyle(
                    color: AppColors.primary, fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'raleway'),
              ),
              SizedBox(height: responsive.inchPercent(1)),
              SizedBox(height: responsive.inchPercent(2)),
              _InputTextLogin(
                iconPath: 'assets/icons/email.svg',
                placeholder: 'Email address',
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
                    label: 'Send',
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
