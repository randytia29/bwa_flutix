part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserFlutix userFlutix = result.user.convertToUserFlutix(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);
      await UserFlutixServices.updateUser(userFlutix);
      return SignInSignUpResult(userFlutix: userFlutix);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      UserFlutix userFlutix = await result.user.fromFireStore();
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

  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;
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
