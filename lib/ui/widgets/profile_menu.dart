part of 'widgets.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 30),
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
          SizedBox(
            height: 16,
          ),
          ProfileTile(
            assetName: 'assets/my_wallet.png',
            title: 'My Wallet',
            onTap: () {
              Navigator.of(context).push(routeTransition(WalletPage()));
            },
          ),
          SizedBox(
            height: 16,
          ),
          ProfileTile(
            assetName: 'assets/language.png',
            title: 'Change Language',
            onTap: () {},
          ),
          SizedBox(
            height: 16,
          ),
          ProfileTile(
            assetName: 'assets/help_centre.png',
            title: 'Help Centre',
            onTap: () {},
          ),
          SizedBox(
            height: 16,
          ),
          ProfileTile(
            assetName: 'assets/rate.png',
            title: 'Rate Flutix App',
            onTap: () {},
          ),
          SizedBox(
            height: 16,
          ),
          ProfileTile(
            assetName: 'assets/sign_out.png',
            title: 'Sign Out',
            onTap: () async {
              context.read<UserBloc>().add(SignOut());
              Navigator.of(context)
                ..popUntil((route) => route.isFirst)
                ..pushReplacement(routeTransition(SplashPage()));
            },
          )
        ],
      ),
    );
  }
}
