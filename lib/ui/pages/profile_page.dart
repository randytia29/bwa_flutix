part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                        margin: EdgeInsets.only(top: 20, left: defaultMargin),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () async {
                            Navigator.of(context).pop();
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
                                          image: (user.profilePicture != "")
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
                    ProfileMenu(user: user)
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
