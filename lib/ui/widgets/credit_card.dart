import '../../features/credit/domain/entities/credit.dart';
import '../../shared/shared_value.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final Credit credit;

  const CreditCard(this.credit, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      NetworkImage("${imageBaseUrl}w780${credit.profilePath}"),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            width: 70,
            height: 24,
            child: Text(
              credit.name,
              style: const TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
