import '../../shared/theme.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.assetName,
    required this.title,
    required this.onTap,
  });

  final String assetName;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(assetName), fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: blackTextFont.copyWith(fontSize: 16),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const DottedLine(
            dashLength: 10,
          ),
        ],
      ),
    );
  }
}
