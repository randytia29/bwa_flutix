part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String profilePath;
  File profileImageFile;
  bool isDataEdited = false;
  TextEditingController nameController;
  bool isUpdating = false;
  String photoDelete;

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
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToProfilePage());
        return;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 0),
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
                      icon: Icon(Icons.arrow_back),
                      onPressed: () async {
                        context.read<PageBloc>().add(GoToProfilePage());
                      },
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 90,
                      height: 104,
                      margin: EdgeInsets.only(top: 28, bottom: 30),
                      child: Stack(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45),
                                image: DecorationImage(
                                    image: (profileImageFile != null)
                                        ? FileImage(profileImageFile)
                                        : (profilePath != '')
                                            ? NetworkImage(profilePath)
                                            : AssetImage("assets/user_pic.png"),
                                    fit: BoxFit.cover)),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                if (profilePath == '') {
                                  profileImageFile = await getImage();
                                  if (profileImageFile != null) {
                                    profilePath =
                                        basename(profileImageFile.path);
                                  } else {
                                    profilePath = '';
                                  }
                                } else {
                                  profileImageFile = null;
                                  profilePath = '';
                                }
                                setState(() {
                                  isDataEdited = (nameController.text.trim() !=
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
                                borderRadius: BorderRadius.circular(6))),
                      ),
                    ),
                    SizedBox(
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
                    SizedBox(
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
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red[400],
                            onSurface: Color(0xFFE4E4E4),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.alertCircle,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Change Password",
                              style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  color: (isUpdating)
                                      ? Color(0xFFBEBEBE)
                                      : Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              MdiIcons.alertCircle,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                        onPressed: (isUpdating)
                            ? null
                            : () async {
                                await AuthServices.resetPassword(
                                    widget.user.email);
                                Flushbar(
                                  duration: Duration(milliseconds: 2000),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message:
                                      "The link to change your password has been sent to your email",
                                )..show(context);
                              },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    (isUpdating)
                        ? SizedBox(
                            width: 50,
                            height: 50,
                            child: SpinKitFadingCircle(
                              color: Color(0xFF3E9D9D),
                            ),
                          )
                        : SizedBox(
                            width: 250,
                            height: 45,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF3E9D9D),
                                    onSurface: Color(0xFFE4E4E4),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                child: Text(
                                  "Update My Profile",
                                  style: whiteTextFont.copyWith(
                                      fontSize: 16,
                                      color: (isDataEdited)
                                          ? Colors.white
                                          : Color(0xFFBEBEBE)),
                                ),
                                onPressed: (isDataEdited)
                                    ? () async {
                                        setState(() {
                                          isUpdating = true;
                                        });

                                        if (profileImageFile != null) {
                                          if (widget.user.profilePicture ==
                                              '') {
                                            photoDelete = '';
                                          } else {
                                            photoDelete = widget
                                                .user.profilePicture
                                                .split('/o/')[1]
                                                .split('?')[0]
                                                .trim();
                                          }
                                          profilePath = await uploadImage(
                                              profileImageFile);
                                          profileImageFile = null;
                                          if (photoDelete != '') {
                                            await deleteImage(photoDelete);
                                          }
                                        }
                                        context.read<UserBloc>().add(UpdateData(
                                            name: nameController.text,
                                            profileImage: profilePath));
                                        context
                                            .read<PageBloc>()
                                            .add(GoToProfilePage());
                                      }
                                    : null),
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
