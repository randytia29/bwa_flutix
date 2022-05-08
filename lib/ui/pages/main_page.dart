import 'dart:developer';

import '../../services/notification_service.dart';
import '../../shared/page_transition.dart';
import '../../shared/theme.dart';
import 'movie_page.dart';
import 'ticket_page.dart';
import 'topup_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  final bool isExpired;

  const MainPage({Key? key, this.bottomNavBarIndex = 0, this.isExpired = false})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? bottomNavBarIndex;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavBarIndex!);

    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        log(notification.title ?? '');
        log(notification.body ?? '');

        await NotificationService.showNotificationNow(
            notification.hashCode, notification.title, notification.body);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  bottomNavBarIndex = index;
                });
              },
              children: <Widget>[
                const MoviePage(),
                TicketPage(
                  isExpiredTicket: widget.isExpired,
                )
              ],
            ),
          ),
          createCustomBottomNavBar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 46,
              width: 46,
              margin: const EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: accentColor2,
                  child: SizedBox(
                    height: 26,
                    width: 26,
                    child: Icon(
                      MdiIcons.walletPlus,
                      color: Colors.black.withOpacity(0.54),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(routeTransition(const TopUpPage()));
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget createCustomBottomNavBar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomNavBarClipper(),
          child: Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: mainColor,
              unselectedItemColor: const Color(0xFFE5E5E5),
              currentIndex: bottomNavBarIndex!,
              onTap: (index) {
                setState(() {
                  bottomNavBarIndex = index;
                  pageController!.jumpToPage(index);
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: 'New Movie',
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    height: 20,
                    child: Image.asset((bottomNavBarIndex == 0)
                        ? 'assets/ic_movies.png'
                        : 'assets/ic_movies_grey.png'),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'My Tickets',
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    height: 20,
                    child: Image.asset((bottomNavBarIndex == 1)
                        ? 'assets/ic_ticket.png'
                        : 'assets/ic_ticket_grey.png'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
