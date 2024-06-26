import '../../features/movie/domain/entities/movie.dart';
import '../../features/movie/presentation/bloc/movie_bloc.dart';
import '../../shared/theme.dart';
import 'coming_soon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ComingSoonMovie extends StatelessWidget {
  const ComingSoonMovie({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            'Coming Soon',
            style: blackTextFont.copyWith(
                fontSize: 36.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                List<Movie> movies = movieState.movies!.sublist(10);
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right:
                            (index == movies.length - 1) ? defaultMargin : 16),
                    child: ComingSoonCard(movies[index]),
                  ),
                );
              } else {
                return const SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            },
          ),
        )
      ],
    );
  }
}
