part of 'widgets.dart';

class CreditCard extends StatelessWidget {
  final Credit credit;

  CreditCard(this.credit);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 110,
      child: Column(
        children: <Widget>[
          Container(
            width: 70,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image:
                      NetworkImage(imageBaseUrl + "w780" + credit.profilePath),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            width: 70,
            height: 24,
            child: Text(
              credit.name,
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
