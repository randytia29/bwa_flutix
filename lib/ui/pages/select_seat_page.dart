import 'package:bwaflutix/features/ticket/presentation/bloc/order_ticket_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/page_transition.dart';
import '../../shared/shared_value.dart';
import '../../shared/theme.dart';
import 'checkout_page.dart';
import '../widgets/selectable_box.dart';
import 'package:flutter/material.dart';

class SelectSeatPage extends StatefulWidget {
  const SelectSeatPage({Key? key}) : super(key: key);

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  late OrderTicketBloc orderTicketBloc;

  List<String> selectedSeats = [];

  @override
  void initState() {
    orderTicketBloc = BlocProvider.of<OrderTicketBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16, left: defaultMargin),
                  height: 24,
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back,
                        size: 24, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: defaultMargin),
                  child: BlocBuilder<OrderTicketBloc, OrderTicketState>(
                    builder: (context, orderTicketState) {
                      return Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 16),
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              orderTicketState.movieTitle!,
                              style: blackTextFont.copyWith(fontSize: 20),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${imageBaseUrl}w154${orderTicketState.moviePosterPath!}'),
                                  fit: BoxFit.cover),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: 277,
              height: 84,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('assets/screen.png'))),
            ),
            generateSeats(),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: selectedSeats.isNotEmpty
                    ? mainColor
                    : const Color(0xFFE4E4E4),
                onPressed: selectedSeats.isNotEmpty
                    ? () {
                        orderTicketBloc.add(SeatsSelected(selectedSeats));

                        Navigator.of(context)
                            .push(routeTransition(BlocProvider.value(
                          value: orderTicketBloc,
                          child: const CheckoutPage(),
                        )));
                      }
                    : null,
                child: Icon(
                  Icons.arrow_forward,
                  color: selectedSeats.isNotEmpty
                      ? Colors.white
                      : const Color(0xFFBEBEBE),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Column generateSeats() {
    List<int> numberofSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];
    for (int i = 0; i < numberofSeats.length; i++) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          numberofSeats[i],
          (index) => Padding(
            padding: EdgeInsets.only(
                right: index == numberofSeats[i] - 1 ? defaultMargin : 15,
                left: index == 0 ? defaultMargin : 0),
            child: SelectableBox(
              '${String.fromCharCode(i + 65)}${index + 1}',
              width: 40,
              height: 40,
              textStyle: yellowNumberFont.copyWith(color: Colors.black),
              isSelected: selectedSeats
                  .contains('${String.fromCharCode(i + 65)}${index + 1}'),
              onTap: () {
                String seatNumber =
                    '${String.fromCharCode(i + 65)}${index + 1}';
                setState(() {
                  if (selectedSeats.contains(seatNumber)) {
                    selectedSeats.remove(seatNumber);
                  } else {
                    if (index != 0) {
                      selectedSeats.add(seatNumber);
                    }
                  }
                });
              },
              isEnabled: index != 0,
            ),
          ),
        ),
      ));
      widgets.add(const SizedBox(
        height: 16,
      ));
    }
    return Column(
      children: widgets,
    );
  }
}
