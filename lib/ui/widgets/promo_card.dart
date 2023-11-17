import '../../models/promo.dart';
import '../../shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;

  const PromoCard(this.promo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 160.h,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: mainColor, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    promo.title,
                    style: whiteTextFont,
                  ),
                  Text(
                    promo.subtitle,
                    style: whiteTextFont.copyWith(
                        fontSize: 22.sp, fontWeight: FontWeight.w300),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'OFF ',
                    style: yellowNumberFont.copyWith(
                        fontSize: 36.sp, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    '${promo.discount}%',
                    style: yellowNumberFont.copyWith(
                        fontSize: 36.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ),
        ShaderMask(
          shaderCallback: (rectangle) {
            return LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Colors.black.withOpacity(0.1), Colors.transparent])
                .createShader(const Rect.fromLTRB(0, 0, 117, 80));
          },
          blendMode: BlendMode.dstIn,
          child: SizedBox(
            height: 160.h,
            width: 117,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: Image.asset('assets/reflection2.png')),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                  end: Alignment.centerRight,
                  begin: Alignment.centerLeft,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.transparent
                  ]).createShader(const Rect.fromLTRB(0, 0, 134, 45));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              height: 90.h,
              width: 134,
              child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(15)),
                  child: Image.asset('assets/reflection1.png')),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                  end: Alignment.centerRight,
                  begin: Alignment.centerLeft,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.transparent
                  ]).createShader(const Rect.fromLTRB(0, 0, 74, 25));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              height: 50.h,
              width: 74,
              child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(15)),
                  child: Image.asset('assets/reflection1.png')),
            ),
          ),
        )
      ],
    );
  }
}
