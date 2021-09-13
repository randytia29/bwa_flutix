part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage(this.ticket);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    int total = 26500 * widget.ticket.seats!.length;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            User user = (userState as UserLoaded).user;
            return ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16, left: defaultMargin),
                      height: 24,
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.arrow_back,
                            size: 24, color: Colors.black),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Checkout\nMovie',
                          style: blackTextFont.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: defaultMargin, right: 20),
                      width: 70,
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(imageBaseUrl +
                                  'w342' +
                                  widget.ticket.moviePosterPath!),
                              fit: BoxFit.cover)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              70 -
                              20,
                          child: Text(
                            widget.ticket.movieTitle!,
                            style: blackTextFont.copyWith(fontSize: 18),
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              70 -
                              20,
                          child: Text(
                            genresAndLanguage(widget.ticket.movieGenres!,
                                widget.ticket.movieLanguage!),
                            // widget.ticket.movie!.genresAndLanguage,
                            style: greyTextFont.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w400),
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        RatingStars(
                          voteAverage: widget.ticket.movieVoteAverage!,
                          color: accentColor3,
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: defaultMargin, vertical: 20),
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFFE4E4E4),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order ID',
                        style: greyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.ticket.bookingCode!,
                        style: whiteNumberFont.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cinema',
                        style: greyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Text(
                          widget.ticket.theaterName!,
                          style: blackTextFont.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date & Time',
                        style: greyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.ticket.time.dateAndTime,
                        style: whiteNumberFont.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.end,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Seat Number',
                        style: greyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Text(
                          widget.ticket.seats!,
                          style: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price',
                        style: greyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Text(
                          'IDR 25.000 x ${widget.ticket.seats!.length}',
                          style: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fee',
                        style: greyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Text(
                          'IDR 1.500 x ${widget.ticket.seats!.length}',
                          style: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: greyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Text(
                          NumberFormat.currency(
                                  locale: 'id_ID',
                                  decimalDigits: 0,
                                  symbol: 'IDR ')
                              .format(total),
                          style: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: defaultMargin, vertical: 20),
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFFE4E4E4),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Wallet',
                        style: greyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Text(
                          NumberFormat.currency(
                                  locale: 'id_ID',
                                  decimalDigits: 0,
                                  symbol: 'IDR ')
                              .format(user.balance),
                          style: whiteNumberFont.copyWith(
                              color: (user.balance! >= total)
                                  ? Color(0xFF3E9D9D)
                                  : Color(0xFFFF5C83),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
                FlutixButton(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 36, defaultMargin, 50),
                  primaryColor:
                      (user.balance! >= total) ? Color(0xFF3E9D9D) : mainColor,
                  child: Text(
                    (user.balance! >= total)
                        ? 'Checkout Now'
                        : 'Top Up My Wallet',
                    style: whiteTextFont.copyWith(fontSize: 16),
                  ),
                  onPressed: () async {
                    if (user.balance! >= total) {
                      context.read<UserBloc>().add(Purchase(total));
                      context.read<TicketBloc>().add(
                          BuyTicket(widget.ticket.copyWith(totalPrice: total)));

                      await FlutixTransactionServices.saveTransaction(
                          FlutixTransaction(
                              userID: user.id,
                              title: widget.ticket.movieTitle,
                              subtitle: widget.ticket.theaterName,
                              time: DateTime.now(),
                              amount: -total,
                              picture: widget.ticket.moviePosterPath));

                      await NotificationService.setScheduleMovie(
                          Random().nextInt(100) + 1,
                          'Movie Coming',
                          'Hurry up',
                          widget.ticket.time);

                      await NotificationService.showNotificationNow(
                          1, 'Ticket Bought', 'Congratulation');

                      Navigator.of(context)
                          .push(routeTransition(SuccessPage(false)));
                    } else {
                      Navigator.of(context)
                        ..popUntil((route) => route.isFirst)
                        ..push(routeTransition(TopUpPage()));
                    }
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
