part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.read<PageBloc>().add(GoToMainPage());
          return;
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                color: accentColor1,
              ),
              SafeArea(
                child: Container(
                  color: Color(0xFFF6F7F9),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) {
                      if (userState is UserLoaded) {
                        User user = userState.user;
                        return ListView(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 24,
                                margin: EdgeInsets.only(
                                    top: 20, left: defaultMargin),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () async {
                                    context
                                        .read<PageBloc>()
                                        .add(GoToMainPage());
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 30),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      SpinKitFadingCircle(
                                        color: mainColor,
                                        size: 120,
                                      ),
                                      Center(
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: (user.profilePicture !=
                                                          "")
                                                      ? NetworkImage(
                                                          user.profilePicture)
                                                      : AssetImage(
                                                          "assets/user_pic.png"),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    user.name,
                                    style: blackTextFont.copyWith(fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    user.email,
                                    style: greyTextFont.copyWith(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 30),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<PageBloc>()
                                          .add(GoToEditProfilePage(user));
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/edit_profile.png"),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Text(
                                          "Edit Profile",
                                          style: blackTextFont.copyWith(
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  GarisPutus(),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      context.read<PageBloc>().add(
                                          GoToWalletPage(GoToProfilePage()));
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/my_wallet.png"),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Text(
                                          "My Wallet",
                                          style: blackTextFont.copyWith(
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  GarisPutus(),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/language.png"),
                                                fit: BoxFit.cover)),
                                      ),
                                      Text(
                                        "Change Language",
                                        style: blackTextFont.copyWith(
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  GarisPutus(),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/help_centre.png"),
                                                fit: BoxFit.cover)),
                                      ),
                                      Text(
                                        "Help Centre",
                                        style: blackTextFont.copyWith(
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  GarisPutus(),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/rate.png"),
                                                fit: BoxFit.cover)),
                                      ),
                                      Text(
                                        "Rate Flutix App",
                                        style: blackTextFont.copyWith(
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  GarisPutus(),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await AuthServices.signOut();
                                      context.read<UserBloc>().add(SignOut());
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/sign_out.png"),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Text(
                                          "Sign Out",
                                          style: blackTextFont.copyWith(
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  GarisPutus()
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
