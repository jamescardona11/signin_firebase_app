import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signinfirebaseapp/libs/auth.dart';
import 'package:signinfirebaseapp/pages/login/widgets/login_form.dart';
import 'package:signinfirebaseapp/utils/app_colors.dart';
import 'package:signinfirebaseapp/utils/dialogs.dart';
import 'package:signinfirebaseapp/utils/responsive.dart';
import 'package:signinfirebaseapp/widgets/rounded_button.dart';

class ForgotFormWidget extends StatefulWidget {
  final VoidCallback onGotoLogin;

  const ForgotFormWidget({Key key, this.onGotoLogin}) : super(key: key);
  @override
  _ForgotFormWidgetState createState() => _ForgotFormWidgetState();
}

class _ForgotFormWidgetState extends State<ForgotFormWidget> {
  bool _send = false;
  final GlobalKey<InputTextLoginState> emailKey = GlobalKey();

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
              (_send)
                  ? Text('The email to reset your password is send')
                  : InputTextLogin(
                      key: emailKey,
                      iconPath: 'assets/icons/email.svg',
                      placeholder: 'Email address',
                      validator: (text) {
                        return text.trim().contains('@');
                      },
                    ),
              SizedBox(height: responsive.inchPercent(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: widget.onGotoLogin,
                    child: Text('← Back to Login', style: TextStyle()),
                  ),
                  if (!_send) ...[
                    RoundedButtonWidget(
                      label: 'Send',
                      onPressed: _submit,
                    )
                  ],
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
    final String email = emailKey.currentState.value.toString().trim();

    final bool emailIsOk = emailKey.currentState.isOk;

    if (emailIsOk) {
      final finalIsOk = await Auth.instance.sendResetEmailLink(context, email);
      setState(() {
        _send = finalIsOk;
      });
    } else {
      Dialogs.alert(context, description: 'Some fields are invalid');
    }
  }
}
