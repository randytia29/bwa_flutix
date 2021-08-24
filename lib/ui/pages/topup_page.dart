part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController(text: 'IDR 0');
  int? selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeBloc>().add(
        ChangeTheme(ThemeData().copyWith(primaryColor: Color(0xFFE4E4E4))));
    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: defaultMargin),
                  height: 24,
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back, size: 24, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Top Up",
                      style: blackTextFont.copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 20),
              child: TextField(
                onChanged: (text) {
                  String temp = '';
                  for (int i = 0; i < text.length; i++) {
                    temp += text.isDigit(i) ? text[i] : '';
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
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Text(
                "Choose by Template",
                style: blackTextFont.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(
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
            SizedBox(
              height: 100,
            ),
            BlocListener<UserBloc, UserState>(
              listener: (context, userState) async {
                await FlutixTransactionServices.saveTransaction(FlutixTransaction(
                    userID: (userState as UserLoaded).user.id,
                    title: 'Top Up Wallet',
                    amount: selectedAmount,
                    subtitle:
                        '${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}',
                    time: DateTime.now()));
              },
              child: FlutixButton(
                margin: EdgeInsets.symmetric(horizontal: 55),
                primaryColor: Color(0xFF3E9D9D),
                onSurfaceColor: Color(0xFF3E9D9D),
                child: Text(
                  'Top Up My Wallet',
                  style: whiteTextFont.copyWith(
                    fontSize: 16,
                    color:
                        selectedAmount! > 0 ? Colors.white : Color(0xFFBEBEBE),
                  ),
                ),
                onPressed: (selectedAmount! > 0)
                    ? () {
                        context.read<UserBloc>().add(TopUp(selectedAmount));

                        Navigator.of(context)
                            .push(routeTransition(SuccessPage(true)));
                      }
                    : null,
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
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
