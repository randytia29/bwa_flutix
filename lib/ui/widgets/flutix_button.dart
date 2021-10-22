import 'package:flutter/material.dart';

class FlutixButton extends StatelessWidget {
  const FlutixButton({
    Key? key,
    this.primaryColor,
    required this.child,
    this.onPressed,
    this.margin,
    this.onSurfaceColor,
  }) : super(key: key);

  final Color? primaryColor;
  final Color? onSurfaceColor;
  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: primaryColor,
              onSurface: onSurfaceColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              minimumSize: const Size(250, 46)),
          child: child,
          onPressed: onPressed),
    );
  }
}
