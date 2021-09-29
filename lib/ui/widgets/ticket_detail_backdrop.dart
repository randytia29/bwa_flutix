import '../../models/ticket.dart';
import '../../shared/shared_value.dart';
import 'package:flutter/material.dart';

class TicketDetailBackdrop extends StatelessWidget {
  const TicketDetailBackdrop({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        image: DecorationImage(
            image:
                NetworkImage(imageBaseUrl + "w780" + ticket.movieBackdropPath!),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
    );
  }
}
