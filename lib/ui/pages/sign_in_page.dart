part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
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
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 70,
                  child: Image.asset('assets/logo.png'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 70, bottom: 40),
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
                SizedBox(
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
                SizedBox(
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
                      onTap: () async {
                        ResetPasswordResult resetPassword =
                            await AuthServices.resetPassword(
                                emailController.text);
                        flutixSnackbar(
                            context,
                            isEmailValid
                                ? 'The link to change your password has been sent to your email'
                                : resetPassword.message);
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
                    margin: EdgeInsets.only(top: 40, bottom: 30),
                    child: isSigningIn
                        ? SpinKitFadingCircle(
                            color: mainColor,
                          )
                        : FloatingActionButton(
                            elevation: 0,
                            child: Icon(
                              Icons.arrow_forward,
                              color: isEmailValid && isPasswordValid
                                  ? Colors.white
                                  : Color(0xFFBEBEBE),
                            ),
                            backgroundColor: isEmailValid && isPasswordValid
                                ? mainColor
                                : Color(0xFFE4E4E4),
                            onPressed: isEmailValid && isPasswordValid
                                ? () async {
                                    setState(() {
                                      isSigningIn = true;
                                    });
                                    SignInSignUpResult result =
                                        await AuthServices.signIn(
                                            emailController.text,
                                            passwordController.text);
                                    if (result.user == null) {
                                      setState(() {
                                        isSigningIn = false;
                                      });
                                      flutixSnackbar(context, result.message);
                                    } else {
                                      context
                                          .read<UserBloc>()
                                          .add(LoadUser(result.user!.id));
                                      context
                                          .read<TicketBloc>()
                                          .add(GetTickets(result.user!.id));

                                      await SharedPref.setUserId(
                                          result.user!.id);

                                      Navigator.of(context)
                                        ..popUntil((route) => route.isFirst)
                                        ..pushReplacement(
                                            routeTransition(MainPage()));
                                    }
                                  }
                                : null),
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
