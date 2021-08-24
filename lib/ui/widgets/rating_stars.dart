part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final Color? color;
  final MainAxisAlignment alignment;

  RatingStars(
      {this.voteAverage = 0,
      this.color,
      this.alignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();
    List<Widget> widgets = List.generate(
        5,
        (index) => Icon(
              index < n ? MdiIcons.star : MdiIcons.starOutline,
              color: accentColor2,
              size: 40.sp,
            ));
    widgets.add(SizedBox(
      width: 3,
    ));
    widgets.add(Text(
      '$voteAverage/10',
      style: whiteNumberFont.copyWith(
          color: color ?? Colors.white,
          fontSize: 24.sp,
          fontWeight: FontWeight.w300),
    ));
    return Row(
      mainAxisAlignment: alignment,
      children: widgets,
    );
  }
}
