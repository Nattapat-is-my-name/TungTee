import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
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

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuthentication =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken);

    return await _auth.signInWithCredential(credential);
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
