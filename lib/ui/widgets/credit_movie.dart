part of 'widgets.dart';

class CreditMovie extends StatelessWidget {
  const CreditMovie({
    Key? key,
    required this.credits,
  }) : super(key: key);

  final List<Credit>? credits;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
              defaultMargin, defaultMargin, defaultMargin, 12),
          child: Text(
            'Cast & Crew',
            style: blackTextFont.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: credits!.length,
            itemBuilder: (_, index) => (credits![index].profilePath != null)
                ? Container(
                    margin: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right: (index == credits!.length - 1)
                            ? defaultMargin
                            : 12),
                    child: CreditCard(credits![index]),
                  )
                : Container(),
          ),
        )
      ],
    );
  }
}
