import '../../bloc/user_bloc.dart';
import '../../models/user.dart';
import '../../shared/theme.dart';
import '../widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      margin:
                          const EdgeInsets.only(top: 20, left: defaultMargin),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: defaultMargin, vertical: 30),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            const SpinKitFadingCircle(
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
                                        image:
                                            ((user.profilePicture != "")
                                                    ? NetworkImage(
                                                        user.profilePicture!)
                                                    : const AssetImage(
                                                        "assets/user_pic.png"))
                                                as ImageProvider<Object>,
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          user.name!,
                          style: blackTextFont.copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          user.email!,
                          style: greyTextFont.copyWith(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  ProfileMenu(user: user)
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
