import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:signinfirebaseapp/pages/login/login_page.dart';
import 'package:signinfirebaseapp/utils/dialogs.dart';

class Auth {
  Auth._internal();
  static Auth get instance => Auth._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> get user async {
    return await _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> google(BuildContext context) async {
    try {
      ProgressDialog progressDialog = ProgressDialog(context);
      progressDialog.show();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential =
          GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      final result = await _firebaseAuth.signInWithCredential(credential);

      final FirebaseUser user = result.user;

      print('username: ${user.displayName}');

      progressDialog.dismiss();
      return user;
    } catch (e) {
      print(e);

      return null;
    }
  }

  Future<FirebaseUser> facebook(BuildContext context) async {
    try {
      ProgressDialog progressDialog = ProgressDialog(context);
      progressDialog.showCupertino();
      final LoginResult facebookAuth = await FacebookAuth.instance.login();

      if (facebookAuth.status == 200) {
        print('Facebook Login Ok');
        final credential = FacebookAuthProvider.getCredential(accessToken: facebookAuth.accessToken.token);
        final result = await _firebaseAuth.signInWithCredential(credential);

        print('RESULT $result');
        final FirebaseUser user = result.user;
        print('username: ${user.displayName}');

        return user;
      } else if (facebookAuth.status == 403) {
        print('Facebook Login cancelled');
      } else {
        print('Facebook Login failed');
      }

      progressDialog.dismiss();
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> logOut(BuildContext context) async {
    final providerId = (await user).providerData[0].providerId;

    switch (providerId) {
      case 'facebook.com':
        await FacebookAuth.instance.logOut();
        break;

      case 'google.com':
        await _googleSignIn.signOut();
        break;

      case 'password':
        break;

      case 'phone':
        break;
    }
    await _firebaseAuth.signOut();

    Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
  }
}
