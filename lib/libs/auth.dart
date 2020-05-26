import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  Auth._internal();
  static Auth get instance => Auth._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> google() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential =
          GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      final result = await _firebaseAuth.signInWithCredential(credential);

      final FirebaseUser user = result.user;

      print('username: ${user.displayName}');
    } catch (e) {
      print(e);
    }
  }

  Future<void> facebook() async {
    try {
      final LoginResult facebookAuth = await FacebookAuth.instance.login();

      if (facebookAuth.status == 200) {
        print('Facebook Login Ok');
        final credential = FacebookAuthProvider.getCredential(accessToken: facebookAuth.accessToken.token);
        final result = await _firebaseAuth.signInWithCredential(credential);

        print('RESULT $result');
        final FirebaseUser user = result.user;
        print('username: ${user.displayName}');
      }
      if (facebookAuth.status == 403) {
        print('Facebook Login cancelled');
      } else {
        print('Facebook Login failed');
      }
    } catch (e) {
      print(e);
    }
  }
}
