import '../../features/movie/domain/entities/movie.dart';
import '../../shared/page_transition.dart';
import '../../shared/shared_value.dart';
import '../../shared/theme.dart';
import '../pages/movie_detail_page.dart';
import 'rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(routeTransition(MovieDetailPage(
          movieID: movie.id,
        )));
      },
      child: Container(
        height: 280.h,
        width: 420.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage('${imageBaseUrl}w780${movie.backdropPath}'),
              fit: BoxFit.fill),
        ),
        child: Container(
          height: 280.h,
          width: 420.w,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.61),
                    Colors.black.withValues(alpha: 0)
                  ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: whiteTextFont,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              RatingStars(
                voteAverage: movie.voteAverage,
              )
            ],
          ),
        ),
      ),
    );
  }
}
