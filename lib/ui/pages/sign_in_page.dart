import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/theme_bloc.dart';
import '../../bloc/user_bloc.dart';
import '../../injection_container.dart';
import '../../models/registration_data.dart';
import '../../services/auth_services.dart';
import '../../services/shared_pref.dart';
import '../../shared/page_transition.dart';
import '../../shared/theme.dart';
import 'main_page.dart';
import 'sign_up_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    context
        .watch<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 70,
                  child: Image.asset('assets/logo.png'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 70, bottom: 40),
                  child: Text(
                    'Welcome Back,\nExplorer!',
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      isEmailValid = EmailValidator.validate(text);
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Email Address'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      isPasswordValid = text.length >= 6;
                    });
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Password'),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Forgot Password? ',
                      style: greyTextFont.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        AuthServices.resetPassword(emailController.text)
                            .then((resetPassword) {
                          flutixSnackbar(
                              context,
                              isEmailValid
                                  ? 'The link to change your password has been sent to your email'
                                  : resetPassword.message);
                        });
                      },
                      child: Text(
                        'Get Now',
                        style: purpleTextFont.copyWith(fontSize: 12),
                      ),
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(top: 40, bottom: 30),
                    child: isSigningIn
                        ? const SpinKitFadingCircle(
                            color: mainColor,
                          )
                        : FloatingActionButton(
                            elevation: 0,
                            backgroundColor: isEmailValid && isPasswordValid
                                ? mainColor
                                : const Color(0xFFE4E4E4),
                            onPressed: isEmailValid && isPasswordValid
                                ? () {
                                    setState(() {
                                      isSigningIn = true;
                                    });

                                    AuthServices.signIn(emailController.text,
                                            passwordController.text)
                                        .then((result) {
                                      if (result.user == null) {
                                        setState(() {
                                          isSigningIn = false;
                                        });

                                        flutixSnackbar(context, result.message);
                                      } else {
                                        context
                                            .read<UserBloc>()
                                            .add(LoadUser(result.user!.id));

                                        sl<SharedPref>()
                                            .setUserId(result.user!.id);

                                        Navigator.of(context)
                                          ..popUntil((route) => route.isFirst)
                                          ..pushReplacement(routeTransition(
                                              const MainPage()));
                                      }
                                    });
                                  }
                                : null,
                            child: Icon(
                              Icons.arrow_forward,
                              color: isEmailValid && isPasswordValid
                                  ? Colors.white
                                  : const Color(0xFFBEBEBE),
                            )),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Start Fresh Now? ',
                      style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            routeTransition(SignUpPage(RegistrationData())));
                      },
                      child: Text(
                        'Sign Up',
                        style: purpleTextFont,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
