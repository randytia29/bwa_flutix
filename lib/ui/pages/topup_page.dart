import 'package:bwaflutix/core/util/convert_bool.dart';
import 'package:bwaflutix/core/util/convert_to_string.dart';
import 'package:bwaflutix/features/flutix_transaction/presentation/bloc/order_transaction_bloc.dart';
import 'package:bwaflutix/injection_container.dart';
import 'package:bwaflutix/services/notification_service.dart';

import '../../bloc/theme_bloc.dart';
import '../../bloc/user_bloc.dart';
import '../../shared/page_transition.dart';
import '../../shared/theme.dart';
import 'success_page.dart';
import '../widgets/flutix_button.dart';
import '../widgets/money_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final orderTransactionBloc = sl<OrderTransactionBloc>();

  TextEditingController amountController = TextEditingController(text: 'IDR 0');
  int? selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeBloc>().add(ChangeTheme(
        ThemeData().copyWith(primaryColor: const Color(0xFFE4E4E4))));
    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;
    return Scaffold(
      body: BlocProvider(
        create: (context) => orderTransactionBloc,
        child: SafeArea(
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: defaultMargin),
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
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Top Up",
                        style: blackTextFont.copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(
                    defaultMargin, 0, defaultMargin, 20),
                child: TextField(
                  onChanged: (text) {
                    String temp = '';
                    for (int i = 0; i < text.length; i++) {
                      temp += isDigit(text, i) ? text[i] : '';
                    }
                    setState(() {
                      selectedAmount = int.tryParse(temp) ?? 0;
                    });
                    amountController.text = NumberFormat.currency(
                      locale: 'id_ID',
                      symbol: 'IDR ',
                      decimalDigits: 0,
                    ).format(selectedAmount);
                    amountController.selection = TextSelection.fromPosition(
                        TextPosition(offset: amountController.text.length));
                  },
                  controller: amountController,
                  decoration: InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Text(
                  "Choose by Template",
                  style: blackTextFont.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 14,
                  children: [
                    makeMoneyCard(
                      width: cardWidth,
                      amount: 50000,
                    ),
                    makeMoneyCard(
                      width: cardWidth,
                      amount: 100000,
                    ),
                    makeMoneyCard(
                      width: cardWidth,
                      amount: 150000,
                    ),
                    makeMoneyCard(
                      width: cardWidth,
                      amount: 200000,
                    ),
                    makeMoneyCard(
                      width: cardWidth,
                      amount: 250000,
                    ),
                    makeMoneyCard(
                      width: cardWidth,
                      amount: 500000,
                    ),
                    makeMoneyCard(
                      width: cardWidth,
                      amount: 1000000,
                    ),
                    makeMoneyCard(
                      width: cardWidth,
                      amount: 2500000,
                    ),
                    makeMoneyCard(
                      width: cardWidth,
                      amount: 5000000,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              BlocListener<UserBloc, UserState>(
                listener: (context, userState) async {
                  orderTransactionBloc.add(PostTransaction(
                      userID: (userState as UserLoaded).user.id,
                      title: 'Top Up Wallet',
                      amount: selectedAmount,
                      subtitle:
                          '${dayName(DateTime.now())}, ${DateTime.now().day} ${monthName(DateTime.now())} ${DateTime.now().year}',
                      time: DateTime.now()));

                  await NotificationService.showNotificationNow(
                      1, 'TopUp Success', 'Congratulation');
                },
                child: FlutixButton(
                  margin: const EdgeInsets.symmetric(horizontal: 55),
                  primaryColor: const Color(0xFF3E9D9D),
                  onSurfaceColor: const Color(0xFF3E9D9D),
                  onPressed: (selectedAmount! > 0)
                      ? () {
                          context.read<UserBloc>().add(TopUp(selectedAmount));

                          Navigator.of(context)
                              .push(routeTransition(const SuccessPage(true)));
                        }
                      : null,
                  child: Text(
                    'Top Up My Wallet',
                    style: whiteTextFont.copyWith(
                      fontSize: 16,
                      color: selectedAmount! > 0
                          ? Colors.white
                          : const Color(0xFFBEBEBE),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  MoneyCard makeMoneyCard({int? amount, double? width}) {
    return MoneyCard(
      amount: amount,
      width: width,
      isSelected: amount == selectedAmount,
      onTap: () {
        setState(() {
          if (selectedAmount != amount) {
            selectedAmount = amount;
          } else {
            selectedAmount = 0;
          }
          amountController.text = NumberFormat.currency(
                  locale: 'id_ID', decimalDigits: 0, symbol: 'IDR ')
              .format(selectedAmount);
          amountController.selection = TextSelection.fromPosition(
              TextPosition(offset: amountController.text.length));
        });
      },
    );
  }
}
