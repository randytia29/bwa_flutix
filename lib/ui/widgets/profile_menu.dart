import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_bloc.dart';
import '../../models/user.dart';
import '../../shared/page_transition.dart';
import '../../shared/theme.dart';
import '../pages/edit_profile_page.dart';
import '../pages/splash_page.dart';
import '../pages/wallet_page.dart';
import 'profile_tile.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 30),
      child: Column(
        children: [
          ProfileTile(
            assetName: 'assets/edit_profile.png',
            title: 'Edit Profile',
            onTap: () {
              Navigator.of(context)
                  .push(routeTransition(EditProfilePage(user)));
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ProfileTile(
            assetName: 'assets/my_wallet.png',
            title: 'My Wallet',
            onTap: () {
              Navigator.of(context).push(routeTransition(const WalletPage()));
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ProfileTile(
            assetName: 'assets/language.png',
            title: 'Change Language',
            onTap: () {},
          ),
          const SizedBox(
            height: 16,
          ),
          ProfileTile(
            assetName: 'assets/help_centre.png',
            title: 'Help Centre',
            onTap: () {},
          ),
          const SizedBox(
            height: 16,
          ),
          ProfileTile(
            assetName: 'assets/rate.png',
            title: 'Rate Flutix App',
            onTap: () {},
          ),
          const SizedBox(
            height: 16,
          ),
          ProfileTile(
            assetName: 'assets/sign_out.png',
            title: 'Sign Out',
            onTap: () async {
              context.read<UserBloc>().add(SignOut());
              Navigator.of(context)
                ..popUntil((route) => route.isFirst)
                ..pushReplacement(routeTransition(const SplashPage()));
            },
          )
        ],
      ),
    );
  }
}
