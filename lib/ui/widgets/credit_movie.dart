import '../../features/credit/presentation/bloc/credit_bloc.dart';
import '../../shared/theme.dart';
import 'credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditMovie extends StatelessWidget {
  const CreditMovie({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(
              defaultMargin, defaultMargin, defaultMargin, 12),
          child: Text(
            'Cast & Crew',
            style: blackTextFont.copyWith(fontSize: 14),
          ),
        ),
        BlocBuilder<CreditBloc, CreditState>(
          builder: (context, state) {
            if (state is CreditLoaded) {
              final credits = state.credits;
              return SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: credits!.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right:
                            (index == credits.length - 1) ? defaultMargin : 12),
                    child: CreditCard(credits[index]),
                  ),
                ),
              );
            }
            return Container();
          },
        )
      ],
    );
  }
}
