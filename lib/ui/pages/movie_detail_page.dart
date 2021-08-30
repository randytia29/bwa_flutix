part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (_, movieDetailState) {
          if (movieDetailState is MovieDetailLoading) {
            return SpinKitFadingCircle(
              color: mainColor,
              size: 50,
            );
          }
          if (movieDetailState is MovieDetailLoaded) {
            final movie = movieDetailState.movie;
            final credits = movieDetailState.credits;

            return SafeArea(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 270,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(imageBaseUrl +
                                      'w780' +
                                      movie!.backdropPath),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 270,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Color(0xFFF6F7F9),
                                  Colors.transparent
                                ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 16, left: defaultMargin),
                            height: 24,
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.arrow_back, size: 24),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Column(
                        children: <Widget>[
                          Text(
                            movie.title,
                            textAlign: TextAlign.center,
                            style: blackTextFont.copyWith(fontSize: 24),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            movie.genresAndLanguage,
                            style: blackTextFont.copyWith(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          RatingStars(
                            voteAverage: movie.voteAverage,
                            color: accentColor3,
                            alignment: MainAxisAlignment.center,
                          )
                        ],
                      ),
                    ),
                    CreditMovie(credits: credits),
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            defaultMargin, defaultMargin, defaultMargin, 8),
                        child: Text(
                          'Storyline',
                          style: blackTextFont.copyWith(fontSize: 14),
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 0, defaultMargin, 30),
                      child: Text(
                        movie.overview,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    FlutixButton(
                      margin: EdgeInsets.symmetric(horizontal: 55),
                      primaryColor: mainColor,
                      child: Text(
                        'Continue to Book',
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(routeTransition(SelectSchedulePage(movie)));
                      },
                    ),
                    SizedBox(
                      height: defaultMargin,
                    )
                  ],
                ),
              ),
            );
          }
          return SpinKitFadingCircle(
            color: mainColor,
            size: 50,
          );
        },
      ),
    );
  }
}
