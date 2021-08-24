part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final bool isTopUp;

  SuccessPage(this.isTopUp);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(isTopUp
                      ? "assets/top_up_done.png"
                      : "assets/ticket_done.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 85, vertical: 70),
              child: Column(
                children: [
                  Text(
                    isTopUp ? "Emmm Yummy!" : "Happy Watching",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    isTopUp
                        ? "You have succesfully\ntop up the wallet"
                        : "You have succesfully\nbought the ticket",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            FlutixButton(
              primaryColor: mainColor,
              child: Text(
                isTopUp ? "My Wallet" : "My Tickets",
                style: whiteTextFont.copyWith(fontSize: 16),
              ),
              onPressed: isTopUp
                  ? () {
                      Navigator.of(context)
                        ..popUntil((route) => route.isFirst)
                        ..push(routeTransition(WalletPage()));
                    }
                  : () {
                      Navigator.of(context)
                        ..popUntil((route) => route.isFirst)
                        ..pushReplacement(routeTransition(MainPage(
                          bottomNavBarIndex: 1,
                        )));
                    },
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
                      Navigator.of(context)
                        ..popUntil((route) => route.isFirst)
                        ..pushReplacement(routeTransition(MainPage()));
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
        ),
      ),
    );
  }
}
