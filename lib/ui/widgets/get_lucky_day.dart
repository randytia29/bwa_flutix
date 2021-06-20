part of 'widgets.dart';

class GetLuckyDay extends StatelessWidget {
  const GetLuckyDay({
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
            'Get Lucky Day',
            style: blackTextFont.copyWith(
                fontSize: 36.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: dummyPromos
              .map((e) => Padding(
                  padding:
                      EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
                  child: PromoCard(e)))
              .toList(),
        )
      ],
    );
  }
}
