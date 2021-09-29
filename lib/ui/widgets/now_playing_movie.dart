import '../../features/movie/presentation/bloc/movie_bloc.dart';
import '../../shared/theme.dart';
import 'movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NowPlayingMovie extends StatelessWidget {
  const NowPlayingMovie({
    Key? key,
    this.controller,
  }) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            'Now Playing',
            style: blackTextFont.copyWith(
                fontSize: 36.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 280.h,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                return ListView.builder(
                  controller: controller,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: movieState.hasReachedMax!
                      ? movieState.movies!.length
                      : movieState.movies!.length + 1,
                  itemBuilder: (_, index) => index < movieState.movies!.length
                      ? Container(
                          margin: EdgeInsets.only(
                              left: (index == 0) ? defaultMargin : 0,
                              right: (index == movieState.movies!.length - 1)
                                  ? defaultMargin
                                  : 16),
                          child: MovieCard(
                            movieState.movies![index],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: SpinKitFadingCircle(
                            color: mainColor,
                            size: 50,
                          ),
                        ),
                );
              } else {
                return SpinKitFadingCircle(
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
