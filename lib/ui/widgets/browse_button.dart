import '../../shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  image: AssetImage(_genreAsset(genre)), fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            genre,
            style: blackTextFont,
          )
        ],
      ),
    );
  }

  String _genreAsset(String genre) {
    switch (genre) {
      case 'Horror':
        return 'assets/ic_horror.png';
      case 'Music':
        return 'assets/ic_music.png';
      case 'Action':
        return 'assets/ic_action.png';
      case 'Drama':
        return 'assets/ic_drama.png';
      case 'War':
        return 'assets/ic_war.png';
      default:
        return 'assets/ic_crime.png';
    }
  }
}
