part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;

  SuccessPage(this.ticket, this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return;
        },
        child: Scaffold(
          body: FutureBuilder(
            future: ticket != null
                ? processingTicketOrder(context)
                : processingTopUp(context),
            builder: (_, snapshot) => (snapshot.connectionState ==
                    ConnectionState.done)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage((ticket == null)
                                    ? "assets/top_up_done.png"
                                    : "assets/ticket_done.png"))),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 85, vertical: 70),
                        child: Column(
                          children: [
                            Text(
                              (ticket == null)
                                  ? "Emmm Yummy!"
                                  : "Happy Watching",
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            Text(
                              (ticket == null)
                                  ? "You have succesfully\ntop up the wallet"
                                  : "You have succesfully\nbought the ticket",
                              style: greyTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 250,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            (ticket == null) ? "My Wallet" : "My Tickets",
                            style: whiteTextFont.copyWith(fontSize: 16),
                          ),
                          color: mainColor,
                          onPressed: () {
                            context.read<PageBloc>().add((ticket == null)
                                ? GoToWalletPage(GoToMainPage())
                                : GoToMainPage(bottomNavBarIndex: 1));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Discover new movie? ",
                              style: greyTextFont.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<PageBloc>().add(GoToMainPage());
                              },
                              child: Text(
                                "Back to Home",
                                style: purpleTextFont,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Center(
                    child: SpinKitFadingCircle(
                      size: 50,
                      color: mainColor,
                    ),
                  ),
          ),
        ));
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.read<UserBloc>().add(Purchase(ticket.totalPrice));
    context.read<TicketBloc>().add(BuyTicket(ticket, transaction.userID));
    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    context.read<UserBloc>().add(TopUp(transaction.amount));
    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
