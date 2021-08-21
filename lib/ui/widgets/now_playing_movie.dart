part of 'widgets.dart';

class NowPlayingMovie extends StatelessWidget {
  const NowPlayingMovie({
    Key key,
  }) : super(key: key);

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
                List<Movie> movies = movieState.movies.sublist(0, 10);
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right:
                            (index == movies.length - 1) ? defaultMargin : 16),
                    child: MovieCard(
                      movies[index],
                      onTap: () {
                        Navigator.of(context).push(
                            routeTransition(MovieDetailPage(movies[index])));
                      },
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
