import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
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
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
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

  Future<FirebaseUser> signIn(BuildContext context, String email, String password) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if (result.user != null) {
        progressDialog.dismiss();
        return user;
      }

      progressDialog.dismiss();
      return null;
    } catch (e) {
      String message = 'unknown error';
      progressDialog.dismiss();
      print(e);
      Dialogs.alert(context, title: 'ERROR', description: message);

      return null;
    }
  }

  Future<FirebaseUser> signUp(BuildContext context, String username, String email, String password) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();

      final AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      if (result.user != null) {
        final UserUpdateInfo userUpdateInfo = UserUpdateInfo();
        userUpdateInfo.displayName = username;
        await result.user.updateProfile(userUpdateInfo);
        progressDialog.dismiss();
        return user;
      }

      progressDialog.dismiss();
      return null;
    } on PlatformException catch (e) {
      String message = 'unknown error';
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USER') {
        message = e.message;
      } else if (e.code == 'ERROR_WEAK_PASSWORD') {
        message = e.message;
      }

      progressDialog.dismiss();
      print(e);
      Dialogs.alert(context, title: 'ERROR', description: message);

      return null;
    }
  }

  Future<bool> sendResetEmailLink(BuildContext context, String email) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      progressDialog.dismiss();
      return true;
    } on PlatformException catch (e) {
      print(e);
      progressDialog.dismiss();
      Dialogs.alert(context, title: 'ERROR', description: e.message);
      return false;
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
