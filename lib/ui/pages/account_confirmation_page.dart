import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_bloc.dart';
import '../../injection_container.dart';
import '../../models/registration_data.dart';
import '../../services/auth_services.dart';
import '../../services/shared_pref.dart';
import '../../shared/page_transition.dart';
import '../../shared/shared_value.dart';
import '../../shared/theme.dart';
import 'main_page.dart';
import '../widgets/flutix_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  const AccountConfirmationPage(this.registrationData, {Key? key})
      : super(key: key);

  @override
  State<AccountConfirmationPage> createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 90),
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
                          "Confirm\nNew Account",
                          style: blackTextFont.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: ((widget.registrationData.profileImage == null)
                                  ? const AssetImage("assets/user_pic.png")
                                  : FileImage(
                                      widget.registrationData.profileImage!))
                              as ImageProvider<Object>,
                          fit: BoxFit.cover)),
                ),
                Text(
                  "Welcome",
                  style: blackTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w300),
                ),
                Text(
                  widget.registrationData.name,
                  textAlign: TextAlign.center,
                  style: blackTextFont.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 110,
                ),
                (isSigningUp)
                    ? const SpinKitFadingCircle(
                        color: Color(0xFF3E9D9D),
                        size: 45,
                      )
                    : FlutixButton(
                        primaryColor: const Color(0xFF3E9D9D),
                        child: Text(
                          'Create My Account',
                          style: whiteTextFont.copyWith(fontSize: 16),
                        ),
                        onPressed: () {
                          setState(() {
                            isSigningUp = true;
                          });

                          imageFileToUpload =
                              widget.registrationData.profileImage;

                          AuthServices.signUp(
                                  widget.registrationData.email,
                                  widget.registrationData.password,
                                  widget.registrationData.name,
                                  widget.registrationData.selectedGenres,
                                  widget.registrationData.selectedLang)
                              .then((result) {
                            if (result.user == null) {
                              setState(() {
                                isSigningUp = false;
                              });
                              flutixSnackbar(context, result.message);
                            } else {
                              context
                                  .read<UserBloc>()
                                  .add(LoadUser(result.user!.id));

                              sl<SharedPref>().setUserId(result.user!.id);

                              Navigator.of(context)
                                ..popUntil((route) => route.isFirst)
                                ..pushReplacement(
                                    routeTransition(const MainPage()));
                            }
                          });
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
