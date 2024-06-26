import '../../shared/theme.dart';
import 'package:flutter/material.dart';

class TicketDetailInfo extends StatelessWidget {
  const TicketDetailInfo({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleStyle,
  });

  final String title;
  final String subtitle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: greyTextFont.copyWith(fontSize: 16),
        ),
        SizedBox(
          width:
              (MediaQuery.of(context).size.width - 2 * defaultMargin - 32) / 2,
          child: Text(subtitle, style: subtitleStyle, textAlign: TextAlign.end),
        )
      ],
    );
  }
}
