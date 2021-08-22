part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    MovieDetail? movieDetail;
    List<Credit>? credits;
    return Scaffold(
      body: FutureBuilder(
        future: MovieServices.getDetails(movie),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            movieDetail = snapshot.data as MovieDetail;
            return FutureBuilder(
              future: MovieServices.getCredits(movie.id),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  credits = snapshot.data as List<Credit>;
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
                                            movieDetail!.backdropPath!),
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
                                  margin: EdgeInsets.only(
                                      top: 16, left: defaultMargin),
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
                            margin:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  movieDetail!.title!,
                                  textAlign: TextAlign.center,
                                  style: blackTextFont.copyWith(fontSize: 24),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  movieDetail!.genresAndLanguage,
                                  style: blackTextFont.copyWith(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                RatingStars(
                                  voteAverage: movieDetail!.voteAverage,
                                  color: accentColor3,
                                  alignment: MainAxisAlignment.center,
                                  starSize: 40.sp,
                                  fontSize: 24.sp,
                                )
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(defaultMargin,
                                  defaultMargin, defaultMargin, 12),
                              child: Text(
                                'Cast & Crew',
                                style: blackTextFont.copyWith(fontSize: 14),
                              )),
                          SizedBox(
                            height: 110,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: credits!.length,
                              itemBuilder: (_, index) =>
                                  (credits![index].profilePath != null)
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: (index == 0)
                                                  ? defaultMargin
                                                  : 0,
                                              right:
                                                  (index == credits!.length - 1)
                                                      ? defaultMargin
                                                      : 12),
                                          child: CreditCard(credits![index]),
                                        )
                                      : Container(),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(defaultMargin,
                                  defaultMargin, defaultMargin, 8),
                              child: Text(
                                'Storyline',
                                style: blackTextFont.copyWith(fontSize: 14),
                              )),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 30),
                            child: Text(
                              movieDetail!.overview!,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 55),
                            height: 46,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: mainColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () {
                                Navigator.of(context).push(routeTransition(
                                    SelectSchedulePage(movieDetail)));
                              },
                              child: Text(
                                'Continue to Book',
                                style: whiteTextFont.copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: defaultMargin,
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
