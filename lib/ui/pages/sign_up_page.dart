part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToSplashPage());
          return;
        },
        child: Scaffold(
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 22),
                      height: 56,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToSplashPage());
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Create New\nAccount',
                              style: blackTextFont.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 104,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        (widget.registrationData.profileImage ==
                                                null)
                                            ? AssetImage('assets/user_pic.png')
                                            : FileImage(widget
                                                .registrationData.profileImage),
                                    fit: BoxFit.cover)),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                if (widget.registrationData.profileImage ==
                                    null) {
                                  widget.registrationData.profileImage =
                                      await getImage();
                                } else {
                                  widget.registrationData.profileImage = null;
                                }
                                setState(() {});
                              },
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage((widget
                                                    .registrationData
                                                    .profileImage ==
                                                null)
                                            ? 'assets/btn_add_photo.png'
                                            : 'assets/btn_del_photo.png'))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    TextField(
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      textCapitalization: TextCapitalization.words,
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Full Name'),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Email'),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Password'),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Confirm Password'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.arrow_forward),
                      backgroundColor: mainColor,
                      elevation: 0,
                      onPressed: () {
                        if (!(nameController.text.trim() != '' &&
                            emailController.text.trim() != '' &&
                            passwordController.text.trim() != '' &&
                            confirmPasswordController.text.trim() != '')) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: 'Please fill all the fields',
                          )..show(context);
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: 'Mismatch password and confirmed password',
                          )..show(context);
                        } else if (passwordController.text.length < 6) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Password's length min 6 characters",
                          )..show(context);
                        } else if (!EmailValidator.validate(
                            emailController.text)) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: 'Wrong formatted email address',
                          )..show(context);
                        } else {
                          widget.registrationData.name = nameController.text;
                          widget.registrationData.email = emailController.text;
                          widget.registrationData.password =
                              passwordController.text;
                          context
                              .bloc<PageBloc>()
                              .add(GoToPreferencePage(widget.registrationData));
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
