part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  WalletPage(this.pageEvent);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(pageEvent);
          return;
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                color: accentColor1,
              ),
              SafeArea(
                child: Container(
                  color: Color(0xFFF6F7F9),
                  child: BlocBuilder<UserFlutixBloc, UserFlutixState>(
                    builder: (_, userFlutixState) {
                      UserFlutix userFlutix =
                          (userFlutixState as UserFlutixLoaded).userFlutix;
                      return ListView(children: [
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: defaultMargin),
                              height: 24,
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.arrow_back,
                                    size: 24, color: Colors.black),
                                onPressed: () {
                                  context.bloc<PageBloc>().add(pageEvent);
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: Text(
                                  "My Wallet",
                                  style: blackTextFont.copyWith(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: defaultMargin, vertical: 20),
                          width: double.infinity,
                          height: 185,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFF382A74),
                              boxShadow: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                              color: Color(0xFFFFF2CB),
                                              borderRadius:
                                                  BorderRadius.circular(9)),
                                        ),
                                        SizedBox(
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
                                          .format(userFlutix.balance),
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
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${userFlutix.name} ",
                                                  style: whiteTextFont.copyWith(
                                                      fontSize: 12),
                                                ),
                                                Container(
                                                  width: 14,
                                                  height: 14,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      color: Color(0xFF28C5B2)),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
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
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${userFlutix.id.substring(0, 10).toUpperCase()} ",
                                                  style: whiteNumberFont
                                                      .copyWith(fontSize: 12),
                                                ),
                                                Container(
                                                  width: 14,
                                                  height: 14,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      color: Color(0xFF28C5B2)),
                                                  child: Icon(
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
                        FutureBuilder(
                          future: FlutixTransactionServices.getTransaction(
                              userFlutix.id),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return generateTransactionList(
                                  snapshot.data,
                                  MediaQuery.of(context).size.width -
                                      2 * defaultMargin);
                            } else {
                              return SpinKitFadingCircle(
                                color: mainColor,
                                size: 50,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 75,
                        )
                      ]);
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 250,
                  height: 46,
                  margin: EdgeInsets.only(bottom: 30),
                  child: RaisedButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: mainColor,
                    onPressed: () {
                      context
                          .bloc<PageBloc>()
                          .add(GoToTopUpPage(GoToWalletPage(pageEvent)));
                    },
                    child: Text(
                      "Top Up My Wallet",
                      style: whiteTextFont.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Column generateTransactionList(
      List<FlutixTransaction> transactions, double width) {
    transactions.sort((transaction1, transaction2) =>
        transaction2.time.compareTo(transaction1.time));
    return Column(
      children: transactions
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
