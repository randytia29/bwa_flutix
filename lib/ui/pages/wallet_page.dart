import 'package:bwaflutix/features/flutix_transaction/domain/entities/flutix_transaction.dart';
import 'package:bwaflutix/features/flutix_transaction/presentation/bloc/flutix_transaction_bloc.dart';
import 'package:bwaflutix/injection_container.dart';

import '../../bloc/user_bloc.dart';
import '../../models/user.dart';
import '../../shared/page_transition.dart';
import '../../shared/theme.dart';
import 'topup_page.dart';
import '../widgets/flutix_button.dart';
import '../widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final flutixTransactionBloc = sl<FlutixTransactionBloc>();

  @override
  void initState() {
    flutixTransactionBloc.add(FetchFlutixTransaction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => flutixTransactionBloc,
        child: Stack(
          children: [
            SafeArea(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) {
                  User user = (userState as UserLoaded).user;
                  return ListView(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: defaultMargin),
                          height: 24,
                          child: IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.arrow_back,
                                size: 24, color: Colors.black),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "My Wallet",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultMargin, vertical: 20),
                      width: double.infinity,
                      height: 185,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFF382A74),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: Offset(0, 5))
                          ]),
                      child: Stack(
                        children: [
                          ClipPath(
                            clipper: CardReflectionClipper(),
                            child: Container(
                              height: 185,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft,
                                      colors: [
                                        Colors.white.withOpacity(0.1),
                                        Colors.white.withOpacity(0)
                                      ])),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFFFF2CB),
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: accentColor2,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  NumberFormat.currency(
                                          locale: 'id_ID',
                                          decimalDigits: 0,
                                          symbol: 'IDR ')
                                      .format(user.balance),
                                  style: whiteNumberFont.copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Card Holder",
                                          style: whiteTextFont.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${user.name} ",
                                              style: whiteTextFont.copyWith(
                                                  fontSize: 12),
                                            ),
                                            Container(
                                              width: 14,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color:
                                                      const Color(0xFF28C5B2)),
                                              child: const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Card ID",
                                          style: whiteTextFont.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${user.id.substring(0, 10).toUpperCase()} ",
                                              style: whiteNumberFont.copyWith(
                                                  fontSize: 12),
                                            ),
                                            Container(
                                              width: 14,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color:
                                                      const Color(0xFF28C5B2)),
                                              child: const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: defaultMargin, bottom: 12),
                      child: Text(
                        "Recent Transactions",
                        style: blackTextFont.copyWith(fontSize: 14),
                      ),
                    ),
                    BlocBuilder<FlutixTransactionBloc, FlutixTransactionState>(
                      builder: (context, flutixTransactionState) {
                        if (flutixTransactionState
                            is FlutixTransactionLoading) {
                          return const SpinKitFadingCircle(
                            color: mainColor,
                            size: 50,
                          );
                        }
                        if (flutixTransactionState is FlutixTransactionEmpty) {
                          return const Center(child: Text('kosong'));
                        }
                        if (flutixTransactionState is FlutixTransactionLoaded) {
                          final transactions =
                              flutixTransactionState.flutixTransactions;
                          return generateTransactionList(
                              transactions,
                              MediaQuery.of(context).size.width -
                                  2 * defaultMargin);
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 75,
                    )
                  ]);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlutixButton(
                margin: const EdgeInsets.only(bottom: 30),
                primaryColor: mainColor,
                child: Text(
                  'Top Up My Wallet',
                  style: whiteTextFont.copyWith(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(routeTransition(const TopUpPage()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Column generateTransactionList(
      List<FlutixTransaction>? transactions, double width) {
    transactions?.sort((transaction1, transaction2) =>
        transaction2.time.compareTo(transaction1.time));
    return Column(
      children: transactions!
          .map((transactions) => Padding(
                padding: const EdgeInsets.only(bottom: 12, left: defaultMargin),
                child: TransactionCard(transactions, width),
              ))
          .toList(),
    );
  }
}

class CardReflectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 15);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
