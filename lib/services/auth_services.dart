part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserFlutix userFlutix = UserFlutix(result.user.uid, result.user.email,
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage,
          balance: 50000);
      await UserFlutixServices.updateUserFlutix(userFlutix);
      return SignInSignUpResult(userFlutix: userFlutix);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      UserFlutix userFlutix =
          await UserFlutixServices.getUserFlutix(result.user.uid);
      return SignInSignUpResult(userFlutix: userFlutix);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<ResetPasswordResult> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return ResetPasswordResult();
    } catch (e) {
      return ResetPasswordResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Stream<User> get userStream => _auth.authStateChanges();
}

class SignInSignUpResult {
  final UserFlutix userFlutix;
  final String message;

  SignInSignUpResult({this.userFlutix, this.message});
}

class ResetPasswordResult {
  final String message;

  ResetPasswordResult({this.message});
}
