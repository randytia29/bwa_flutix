import '../../features/movie/domain/entities/movie.dart';
import '../../shared/shared_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComingSoonCard extends StatelessWidget {
  final Movie movie;
  final Function? onTap;

  const ComingSoonCard(this.movie, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 280.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
            image: NetworkImage(imageBaseUrl + 'w780' + movie.posterPath),
            fit: BoxFit.fill),
      ),
    );
  }
}
