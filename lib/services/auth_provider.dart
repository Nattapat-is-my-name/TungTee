import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled sign-in.
        return null;
      }
      final GoogleSignInAuthentication googleAuthentication =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuthentication.accessToken,
          idToken: googleAuthentication.idToken);
      return await _auth.signInWithCredential(credential);
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled') {
        // User canceled sign-in.
        return null;
      }
      // Handle other platform exceptions.
      // You can throw the exception or return an error message.
      return null;
    }
  }

  static void handleSignInError(String errorCode) {
    switch (errorCode) {
      case SignInError.wrongPassword:
        {}
        break;
      case SignInError.invalidEmail:
        {}
        break;
      case SignInError.userDisabled:
        {}
        break;
      case SignInError.userNotFound:
        {}
        break;
      case SignInError.invalidCredential:
        {}
        break;
      case SignInError.accountExistsWithDifferentCredential:
        {}
        break;
      default:
        print('Error code: ${errorCode}');
    }
  }
}

// https://stackoverflow.com/questions/67617502/what-are-the-error-codes-for-flutter-firebase-auth-exception
class SignInError {
  static const wrongPassword = 'wrong-password';
  static const invalidEmail = 'invalid-email';
  static const userDisabled = 'user-disabled';
  static const userNotFound = 'user-not-found';
  static const accountExistsWithDifferentCredential =
      'account-exists-with-different-credential';
  static const invalidCredential = 'invalid-credential';
  static const operationNotAllowed = 'operation-not-allowed';
  static const invalidVerificationCode = 'invalid-verification-code';
  static const invalidVerificationId = 'invalid-verification-id';
}
