part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function? onTap;

  MovieCard(this.movie, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        height: 280.h,
        width: 420.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(imageBaseUrl + 'w780' + movie.backdropPath!),
              fit: BoxFit.fill),
        ),
        child: Container(
          height: 280.h,
          width: 420.w,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.61),
                    Colors.black.withOpacity(0)
                  ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title!,
                style: whiteTextFont,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              RatingStars(
                voteAverage: movie.voteAverage,
                starSize: 40.sp,
                fontSize: 24.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
