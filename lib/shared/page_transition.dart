import 'package:flutter/widgets.dart';

const Offset beginTransitionPage = Offset(1, 0);
Offset endTransitionPage = Offset.zero;
Curve curve = Curves.easeIn;

PageRouteBuilder<dynamic> routeTransition(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(begin: beginTransitionPage, end: endTransitionPage)
          .chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
