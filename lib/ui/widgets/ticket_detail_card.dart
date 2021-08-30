part of 'widgets.dart';

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
                  ticket.movie!.title,
                  style: blackTextFont.copyWith(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  ticket.movie!.genresAndLanguage,
                  style: greyTextFont.copyWith(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 6,
                ),
                RatingStars(
                  voteAverage: ticket.movie!.voteAverage,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 16,
                ),
                TicketDetailInfo(
                  title: 'Cinema',
                  subtitle: ticket.theater!.name!,
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
                  subtitle: ticket.seatsInString,
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
