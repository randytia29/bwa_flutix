part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  TicketDetailPage(this.ticket);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 24,
              margin: EdgeInsets.only(top: 20, left: defaultMargin, bottom: 20),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Ticket Details",
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Column(
                children: [
                  Container(
                      height: 170,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(imageBaseUrl +
                                  "w780" +
                                  ticket.movieDetail.backdropPath),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)))),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket.movieDetail.title,
                          style: blackTextFont.copyWith(fontSize: 18),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          ticket.movieDetail.genresAndLanguage,
                          style: greyTextFont.copyWith(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        RatingStars(
                          voteAverage: ticket.movieDetail.voteAverage,
                          color: Colors.grey,
                          starSize: 40.sp,
                          fontSize: 24.sp,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cinema",
                              style: greyTextFont.copyWith(fontSize: 16),
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width -
                                      2 * defaultMargin -
                                      32) /
                                  2,
                              child: Text(ticket.theater.name,
                                  style: blackTextFont.copyWith(fontSize: 16),
                                  textAlign: TextAlign.end),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date & Time",
                              style: greyTextFont.copyWith(fontSize: 16),
                            ),
                            Text(
                              ticket.time.dateAndTime,
                              style: whiteNumberFont.copyWith(
                                  fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Seat Number",
                              style: greyTextFont.copyWith(fontSize: 16),
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width -
                                      2 * defaultMargin -
                                      32) /
                                  2,
                              child: Text(
                                ticket.seatsInString,
                                style: whiteNumberFont.copyWith(
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ID Order",
                              style: greyTextFont.copyWith(fontSize: 16),
                            ),
                            Text(
                              ticket.bookingCode,
                              style: whiteNumberFont.copyWith(
                                  fontSize: 16, color: Colors.black),
                            )
                          ],
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          32) /
                                      2,
                                  child: Text(
                                    ticket.name,
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("Paid",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  NumberFormat.currency(
                                          locale: "id_ID",
                                          decimalDigits: 0,
                                          symbol: "IDR ")
                                      .format(ticket.totalPrice),
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            QrImage(
                              data: ticket.bookingCode,
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
            )
          ],
        ),
      ),
    );
  }
}
