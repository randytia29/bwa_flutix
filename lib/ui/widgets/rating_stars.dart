import '../../shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final Color? color;
  final MainAxisAlignment alignment;

  const RatingStars(
      {Key? key,
      this.voteAverage = 0,
      this.color,
      this.alignment = MainAxisAlignment.start})
      : super(key: key);

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
    widgets.add(const SizedBox(
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
