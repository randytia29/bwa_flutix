import 'dart:math';

import 'package:bwaflutix/features/flutix_transaction/presentation/bloc/order_transaction_bloc.dart';
import 'package:bwaflutix/features/ticket/presentation/bloc/order_ticket_bloc.dart';
import 'package:bwaflutix/injection_container.dart';

import '../../bloc/user_bloc.dart';
import '../../core/util/convert_to_string.dart';
import '../../extensions/date_time_extension.dart';
import '../../models/user.dart';
import '../../services/notification_service.dart';
import '../../shared/page_transition.dart';
import '../../shared/shared_value.dart';
import '../../shared/theme.dart';
import 'success_page.dart';
import 'topup_page.dart';
import '../widgets/flutix_button.dart';
import '../widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final orderTransactionBloc = sl<OrderTransactionBloc>();
  late OrderTicketBloc orderTicketBloc;

  @override
  void initState() {
    orderTicketBloc = BlocProvider.of<OrderTicketBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => orderTransactionBloc,
        child: SafeArea(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              User user = (userState as UserLoaded).user;
              return BlocBuilder<OrderTicketBloc, OrderTicketState>(
                builder: (context, orderTicketState) {
                  return ListView(
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: 16, left: defaultMargin),
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
                            margin:
                                EdgeInsets.only(left: defaultMargin, right: 20),
                            width: 70,
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(imageBaseUrl +
                                        'w342' +
                                        orderTicketState.moviePosterPath!),
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
                                  orderTicketState.movieTitle!,
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
                                  genresAndLanguage(
                                      orderTicketState.movieGenres!,
                                      orderTicketState.movieLanguage!),
                                  style: greyTextFont.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              RatingStars(
                                voteAverage: orderTicketState.movieVoteAverage!,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order ID',
                              style: greyTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              orderTicketState.bookingCode!,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
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
                                orderTicketState.theaterName!,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
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
                              orderTicketState.time!.dateAndTime,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
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
                                seatsInString(orderTicketState.seats!),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
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
                                'IDR 25.000 x ${orderTicketState.seats!.length}',
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
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
                                'IDR 1.500 x ${orderTicketState.seats!.length}',
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
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
                                    .format(orderTicketState.totalPrice),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
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
                                    color: (user.balance! >=
                                            orderTicketState.totalPrice!)
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
                        margin: EdgeInsets.fromLTRB(
                            defaultMargin, 36, defaultMargin, 50),
                        primaryColor:
                            (user.balance! >= orderTicketState.totalPrice!)
                                ? Color(0xFF3E9D9D)
                                : mainColor,
                        child: Text(
                          (user.balance! >= orderTicketState.totalPrice!)
                              ? 'Checkout Now'
                              : 'Top Up My Wallet',
                          style: whiteTextFont.copyWith(fontSize: 16),
                        ),
                        onPressed: () async {
                          if (user.balance! >= orderTicketState.totalPrice!) {
                            context
                                .read<UserBloc>()
                                .add(Purchase(orderTicketState.totalPrice!));

                            orderTicketBloc.add(BuyTicket());

                            orderTransactionBloc.add(PostTransaction(
                                userID: user.id,
                                title: orderTicketState.movieTitle,
                                subtitle: orderTicketState.theaterName,
                                time: DateTime.now(),
                                amount: -orderTicketState.totalPrice!,
                                picture: orderTicketState.moviePosterPath));

                            await NotificationService.setScheduleMovie(
                                Random().nextInt(100) + 1,
                                'Movie Coming',
                                'Hurry up',
                                orderTicketState.time!);

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
              );
            },
          ),
        ),
      ),
    );
  }
}
