import '../../shared/page_transition.dart';
import '../../shared/theme.dart';
import 'main_page.dart';
import 'wallet_page.dart';
import '../widgets/flutix_button.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final bool isTopUp;

  const SuccessPage(this.isTopUp, {Key? key}) : super(key: key);

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
              margin: const EdgeInsets.symmetric(horizontal: 85, vertical: 70),
              child: Column(
                children: [
                  Text(
                    isTopUp ? "Emmm Yummy!" : "Happy Watching",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
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
              onPressed: isTopUp
                  ? () {
                      Navigator.of(context)
                        ..popUntil((route) => route.isFirst)
                        ..push(routeTransition(const WalletPage()));
                    }
                  : () {
                      Navigator.of(context)
                        ..popUntil((route) => route.isFirst)
                        ..pop()
                        ..push(routeTransition(const MainPage(
                          bottomNavBarIndex: 1,
                        )));
                    },
              child: Text(
                isTopUp ? "My Wallet" : "My Tickets",
                style: whiteTextFont.copyWith(fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
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
                      Navigator.of(context).popUntil((route) => route.isFirst);
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
