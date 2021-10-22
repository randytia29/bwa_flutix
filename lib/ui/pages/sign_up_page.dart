import '../../bloc/theme_bloc.dart';
import '../../models/registration_data.dart';
import '../../shared/page_transition.dart';
import '../../shared/shared_methods.dart';
import '../../shared/theme.dart';
import 'preference_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  const SignUpPage(this.registrationData, {Key? key}) : super(key: key);

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
        .watch<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 22),
                  height: 56,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
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
                SizedBox(
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
                                image: ((widget.registrationData.profileImage ==
                                        null)
                                    ? const AssetImage('assets/user_pic.png')
                                    : FileImage(widget.registrationData
                                        .profileImage!)) as ImageProvider<
                                    Object>,
                                fit: BoxFit.cover)),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () async {
                            if (widget.registrationData.profileImage == null) {
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
                                    image: AssetImage(
                                        (widget.registrationData.profileImage ==
                                                null)
                                            ? 'assets/btn_add_photo.png'
                                            : 'assets/btn_del_photo.png'))),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
                  height: 30,
                ),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_forward),
                  backgroundColor: mainColor,
                  elevation: 0,
                  onPressed: () {
                    if (!(nameController.text.trim() != '' &&
                        emailController.text.trim() != '' &&
                        passwordController.text.trim() != '' &&
                        confirmPasswordController.text.trim() != '')) {
                      flutixSnackbar(context, 'Please fill all the fields');
                    } else if (passwordController.text !=
                        confirmPasswordController.text) {
                      flutixSnackbar(
                          context, 'Mismatch password and confirmed password');
                    } else if (passwordController.text.length < 6) {
                      flutixSnackbar(
                          context, "Password's length min 6 characters");
                    } else if (!EmailValidator.validate(emailController.text)) {
                      flutixSnackbar(context, 'Wrong formatted email address');
                    } else {
                      widget.registrationData.name = nameController.text;
                      widget.registrationData.email = emailController.text;
                      widget.registrationData.password =
                          passwordController.text;

                      Navigator.of(context).push(routeTransition(
                          PreferencePage(widget.registrationData)));
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
