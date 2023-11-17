import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/theme_bloc.dart';
import '../../bloc/user_bloc.dart';
import '../../models/user.dart';
import '../../services/auth_services.dart';
import '../../shared/page_transition.dart';
import '../../shared/shared_methods.dart';
import '../../shared/theme.dart';
import 'profile_page.dart';
import '../widgets/flutix_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage(this.user, {super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? profilePath;
  File? profileImageFile;
  bool isDataEdited = false;
  TextEditingController? nameController;
  bool isUpdating = false;
  String? photoDelete;

  @override
  void initState() {
    super.initState();
    profilePath = widget.user.profilePicture;
    nameController = TextEditingController(text: widget.user.name);
  }

  @override
  Widget build(BuildContext context) {
    context
        .watch<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 0),
          child: ListView(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Edit Your\nProfile",
                      style: blackTextFont.copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 90,
                    height: 104,
                    margin: const EdgeInsets.only(top: 28, bottom: 30),
                    child: Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            image: DecorationImage(
                                image: (profileImageFile != null)
                                    ? FileImage(profileImageFile!)
                                    : ((profilePath != '')
                                            ? NetworkImage(profilePath!)
                                            : const AssetImage(
                                                "assets/user_pic.png"))
                                        as ImageProvider<Object>,
                                fit: BoxFit.cover),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (profilePath == '') {
                                profileImageFile = await getImage();
                                if (profileImageFile != null) {
                                  profilePath =
                                      basename(profileImageFile!.path);
                                } else {
                                  profilePath = '';
                                }
                              } else {
                                profileImageFile = null;
                                profilePath = '';
                              }
                              setState(() {
                                isDataEdited = (nameController!.text.trim() !=
                                            widget.user.name ||
                                        profilePath !=
                                            widget.user.profilePicture)
                                    ? true
                                    : false;
                              });
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  image: DecorationImage(
                                      image: AssetImage((profilePath == '')
                                          ? 'assets/btn_add_photo.png'
                                          : 'assets/btn_del_photo.png'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  AbsorbPointer(
                    child: TextField(
                      style: whiteNumberFont.copyWith(color: accentColor3),
                      controller: TextEditingController(text: widget.user.id),
                      decoration: InputDecoration(
                        labelText: "User ID",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AbsorbPointer(
                    child: TextField(
                      style: greyTextFont,
                      controller:
                          TextEditingController(text: widget.user.email),
                      decoration: InputDecoration(
                          labelText: "Email Address",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6))),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isDataEdited = (text.trim() != widget.user.name ||
                                profilePath != widget.user.profilePicture)
                            ? true
                            : false;
                      });
                    },
                    style: blackTextFont,
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FlutixButton(
                    primaryColor: Colors.red[400],
                    onSurfaceColor: Colors.red[400],
                    onPressed: (isUpdating)
                        ? null
                        : () {
                            AuthServices.resetPassword(widget.user.email!);

                            flutixSnackbar(context,
                                'The link to change your password has been sent to your email');
                          },
                    child: SizedBox(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            MdiIcons.alertCircle,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Change Password',
                            style: whiteTextFont.copyWith(
                                fontSize: 16,
                                color: (isUpdating)
                                    ? const Color(0xFFBEBEBE)
                                    : Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            MdiIcons.alertCircle,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  (isUpdating)
                      ? const SizedBox(
                          width: 50,
                          height: 50,
                          child: SpinKitFadingCircle(
                            color: Color(0xFF3E9D9D),
                          ),
                        )
                      : FlutixButton(
                          primaryColor: const Color(0xFF3E9D9D),
                          onSurfaceColor: const Color(0xFF3E9D9D),
                          onPressed: (isDataEdited)
                              ? () {
                                  setState(() {
                                    isUpdating = true;
                                  });

                                  if (profileImageFile != null) {
                                    if (widget.user.profilePicture == '') {
                                      photoDelete = '';
                                    } else {
                                      photoDelete = widget.user.profilePicture!
                                          .split('/o/')[1]
                                          .split('?')[0]
                                          .trim();
                                    }

                                    uploadImage(profileImageFile!)
                                        .then((value) {
                                      profilePath = value;
                                    });

                                    profileImageFile = null;

                                    if (photoDelete != '') {
                                      deleteImage(photoDelete!);
                                    }
                                  }
                                  context.read<UserBloc>().add(UpdateData(
                                      name: nameController!.text,
                                      profileImage: profilePath));

                                  Navigator.of(context)
                                    ..popUntil((route) => route.isFirst)
                                    ..push(
                                        routeTransition(const ProfilePage()));
                                }
                              : null,
                          child: Text(
                            'Update My Profile',
                            style: whiteTextFont.copyWith(
                                fontSize: 16,
                                color: (isDataEdited)
                                    ? Colors.white
                                    : const Color(0xFFBEBEBE)),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
