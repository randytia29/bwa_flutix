import 'package:bwaflutix/features/ticket/domain/entities/ticket.dart';

import '../../shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketDetailUser extends StatelessWidget {
  const TicketDetailUser({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  final Ticket? ticket;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name",
            style: greyTextFont.copyWith(
                fontSize: 16, fontWeight: FontWeight.w400)),
        SizedBox(
          height: 2,
        ),
        SizedBox(
          width:
              (MediaQuery.of(context).size.width - 2 * defaultMargin - 32) / 2,
          child: Text(
            ticket!.name,
            style: whiteNumberFont.copyWith(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text("Paid",
            style: greyTextFont.copyWith(
                fontSize: 16, fontWeight: FontWeight.w400)),
        SizedBox(
          height: 2,
        ),
        Text(
          NumberFormat.currency(
                  locale: "id_ID", decimalDigits: 0, symbol: "IDR ")
              .format(ticket!.totalPrice),
          style: whiteNumberFont.copyWith(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
