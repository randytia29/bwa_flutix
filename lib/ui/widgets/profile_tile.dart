part of 'widgets.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key key,
    @required this.assetName,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  final String assetName;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(assetName), fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: blackTextFont.copyWith(fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          DottedLine(
            dashLength: 10,
          ),
        ],
      ),
    );
  }
}
