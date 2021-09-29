import '../../core/util/convert_to_string.dart';
import '../../features/credit/presentation/bloc/credit_bloc.dart';
import '../../features/movie/presentation/bloc/movie_detail_bloc.dart';
import '../../injection_container.dart';
import '../../shared/page_transition.dart';
import '../../shared/shared_value.dart';
import '../../shared/theme.dart';
import 'select_schedule_page.dart';
import '../widgets/credit_movie.dart';
import '../widgets/flutix_button.dart';
import '../widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieDetailPage extends StatefulWidget {
  final int? movieID;

  const MovieDetailPage({Key? key, required this.movieID}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final movieDetailBloc = sl<MovieDetailBloc>();
  final creditBloc = sl<CreditBloc>();

  @override
  void initState() {
    movieDetailBloc.add(FetchMovieDetail(movieID: widget.movieID));
    creditBloc.add(FetchCredit(movieID: widget.movieID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => movieDetailBloc,
          ),
          BlocProvider(
            create: (context) => creditBloc,
          )
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (_, movieDetailState) {
            if (movieDetailState is MovieDetailLoading) {
              return SpinKitFadingCircle(
                color: mainColor,
                size: 50,
              );
            }
            if (movieDetailState is MovieDetailLoaded) {
              final movieDetail = movieDetailState.movie;

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
                                      movieDetail!.backdropPath),
                                  fit: BoxFit.cover),
                            ),
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
                                    end: Alignment.topCenter),
                              ),
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
                              movieDetail.title,
                              textAlign: TextAlign.center,
                              style: blackTextFont.copyWith(fontSize: 24),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              genresAndLanguage(
                                  movieDetail.genres, movieDetail.language),
                              style: blackTextFont.copyWith(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            RatingStars(
                              voteAverage: movieDetail.voteAverage,
                              color: accentColor3,
                              alignment: MainAxisAlignment.center,
                            )
                          ],
                        ),
                      ),
                      CreditMovie(),
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
                          movieDetail.overview,
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
                          Navigator.of(context).push(
                              routeTransition(SelectSchedulePage(movieDetail)));
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
      ),
    );
  }
}
