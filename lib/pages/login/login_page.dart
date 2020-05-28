import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signinfirebaseapp/pages/login/widgets/forgot_form.dart';
import 'package:signinfirebaseapp/pages/login/widgets/login_form.dart';
import 'package:signinfirebaseapp/pages/login/widgets/register_form.dart';
import 'package:signinfirebaseapp/pages/login/widgets/welcome.dart';
import 'package:signinfirebaseapp/utils/responsive.dart';

class LoginFormType {
  static final int login = 0;
  static final int register = 1;
  static final int forgotPassword = 2;
}

class LoginPage extends StatefulWidget {
  static final String id = 'login_page_route_id';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AfterLayoutMixin {
  PageController _pageController = PageController(initialPage: LoginFormType.login);

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.shortestSide > 600.0;

    if (!isTablet) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);

    return Scaffold(
      body: GestureDetector(
        //TODO when click in textfield singlechild scroll to top
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return SingleChildScrollView(
                    child: Container(
                      height: responsive.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          WelcomeWidget(),
                          Expanded(
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _pageController,
                              children: <Widget>[
                                LoginFormWidget(
                                  onGotoRegister: () {
                                    _switchForm(LoginFormType.register);
                                  },
                                  onGotoForgot: () {
                                    _switchForm(LoginFormType.forgotPassword);
                                  },
                                ),
                                RegisterFormWidget(
                                  onGotoLogin: () {
                                    _switchForm(LoginFormType.login);
                                  },
                                ),
                                ForgotFormWidget(
                                  onGotoLogin: () {
                                    _switchForm(LoginFormType.login);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Container(
                            padding: EdgeInsets.only(left: 25),
                            height: responsive.height,
                            child: WelcomeWidget(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            height: responsive.height,
                            child: Center(
                              child: LoginFormWidget(
                                onGotoRegister: () {
                                  _switchForm(LoginFormType.register);
                                },
                                onGotoForgot: () {
                                  _switchForm(LoginFormType.forgotPassword);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _switchForm(int page) {
    _pageController.animateToPage(page, duration: Duration(milliseconds: 300), curve: Curves.linear);
  }
}
