part of 'widgets.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.user,
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
              context.read<PageBloc>().add(GoToEditProfilePage(user));
            },
          ),
          SizedBox(
            height: 16,
          ),
          ProfileTile(
            assetName: 'assets/my_wallet.png',
            title: 'My Wallet',
            onTap: () {
              context.read<PageBloc>().add(GoToWalletPage(GoToProfilePage()));
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
              await AuthServices.signOut();
              context.read<UserBloc>().add(SignOut());
            },
          )
        ],
      ),
    );
  }
}
