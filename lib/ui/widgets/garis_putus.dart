part of 'widgets.dart';

class GarisPutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          25,
          (index) => Row(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width -
                                2 * defaultMargin -
                                32) /
                            25 -
                        2,
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 2,
                  )
                ],
              )),
    );
  }
}
