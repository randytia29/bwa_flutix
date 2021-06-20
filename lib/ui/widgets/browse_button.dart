part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;

  BrowseButton(this.genre);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100.h,
            height: 100.h,
            decoration: BoxDecoration(
                color: Color(0xFFEBFFF6),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: AssetImage(genre.contains('Horror')
                        ? 'assets/ic_horror.png'
                        : genre.contains('Music')
                            ? 'assets/ic_music.png'
                            : genre.contains('Action')
                                ? 'assets/ic_action.png'
                                : genre.contains('Drama')
                                    ? 'assets/ic_drama.png'
                                    : genre.contains('War')
                                        ? 'assets/ic_war.png'
                                        : 'assets/ic_crime.png'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            genre.contains('Horror')
                ? 'Horror'
                : genre.contains('Music')
                    ? 'Music'
                    : genre.contains('Action')
                        ? 'Action'
                        : genre.contains('Drama')
                            ? 'Drama'
                            : genre.contains('War')
                                ? 'War'
                                : 'Crime',
            style: blackTextFont,
          )
        ],
      ),
    );
  }
}
