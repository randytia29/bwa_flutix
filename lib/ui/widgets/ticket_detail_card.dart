import '../../core/util/convert_to_string.dart';
import '../../extensions/date_time_extension.dart';
import '../../models/ticket.dart';
import '../../shared/theme.dart';
import 'rating_stars.dart';
import 'ticket_detail_backdrop.dart';
import 'ticket_detail_info.dart';
import 'ticket_detail_user.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketDetailCard extends StatelessWidget {
  const TicketDetailCard({Key? key, required this.ticket}) : super(key: key);

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Column(
        children: [
          TicketDetailBackdrop(ticket: ticket),
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.movieTitle!,
                  style: blackTextFont.copyWith(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  genresAndLanguage(ticket.movieGenres!, ticket.movieLanguage!),
                  // ticket.movie!.genresAndLanguage,
                  style: greyTextFont.copyWith(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 6,
                ),
                RatingStars(
                  voteAverage: ticket.movieVoteAverage!,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 16,
                ),
                TicketDetailInfo(
                  title: 'Cinema',
                  subtitle: ticket.theaterName!,
                  subtitleStyle: blackTextFont.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 8,
                ),
                TicketDetailInfo(
                  title: 'Date & Time',
                  subtitle: ticket.time.dateAndTime,
                  subtitleStyle: whiteNumberFont.copyWith(
                      fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 8,
                ),
                TicketDetailInfo(
                  title: 'Seat Number',
                  subtitle: seatsInString(ticket.seats!),
                  subtitleStyle: whiteNumberFont.copyWith(
                      fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 8,
                ),
                TicketDetailInfo(
                  title: 'ID Order',
                  subtitle: ticket.bookingCode!,
                  subtitleStyle: whiteNumberFont.copyWith(
                      fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                DottedLine(
                  dashLength: 7,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TicketDetailUser(ticket: ticket),
                    QrImage(
                      data: ticket.bookingCode!,
                      version: 6,
                      foregroundColor: Colors.black,
                      errorCorrectionLevel: QrErrorCorrectLevel.M,
                      padding: EdgeInsets.all(0),
                      size: 100,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
