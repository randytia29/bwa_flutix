import '../../models/promo.dart';
import '../../shared/theme.dart';
import 'promo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetLuckyDay extends StatelessWidget {
  const GetLuckyDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            'Get Lucky Day',
            style: blackTextFont.copyWith(
                fontSize: 36.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: dummyPromos
              .map((e) => Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 0, defaultMargin, 16),
                  child: PromoCard(e)))
              .toList(),
        )
      ],
    );
  }
}
