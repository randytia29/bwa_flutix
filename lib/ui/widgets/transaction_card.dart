import 'package:bwaflutix/features/flutix_transaction/domain/entities/flutix_transaction.dart';

import '../../shared/shared_value.dart';
import '../../shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final FlutixTransaction transaction;
  final double width;

  const TransactionCard(this.transaction, this.width, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          height: 90,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: transaction.picture.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageBaseUrl + 'w500' + transaction.picture,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('😢'));
                    },
                    fit: BoxFit.fill,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/bg_topup.png',
                    fit: BoxFit.fill,
                  ),
                ),
        ),
        Column(
          children: [
            SizedBox(
              width: width - 86,
              child: Text(
                transaction.title,
                style: blackTextFont.copyWith(fontSize: 18),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SizedBox(
                width: width - 86,
                child: Text(
                  NumberFormat.currency(
                          locale: 'id_ID', decimalDigits: 0, symbol: 'IDR ')
                      .format((transaction.amount < 0)
                          ? -transaction.amount
                          : transaction.amount),
                  style: whiteNumberFont.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: (transaction.amount < 0)
                          ? const Color(0xFFFF5C83)
                          : const Color(0xFF3E9D9D)),
                ),
              ),
            ),
            SizedBox(
              width: width - 86,
              child: Text(
                transaction.subtitle,
                style: greyTextFont.copyWith(
                    fontSize: 12, fontWeight: FontWeight.w400),
              ),
            )
          ],
        )
      ],
    );
  }
}
