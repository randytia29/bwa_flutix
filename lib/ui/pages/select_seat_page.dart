part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  SelectSeatPage(this.ticket);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

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
                  margin: EdgeInsets.only(top: 16, left: defaultMargin),
                  height: 24,
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back, size: 24, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: defaultMargin),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          widget.ticket.movie!.title,
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
                              image: NetworkImage(imageBaseUrl +
                                  'w154' +
                                  widget.ticket.movie!.posterPath),
                              fit: BoxFit.cover),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 277,
              height: 84,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('assets/screen.png'))),
            ),
            generateSeats(),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor:
                    selectedSeats.length > 0 ? mainColor : Color(0xFFE4E4E4),
                child: Icon(
                  Icons.arrow_forward,
                  color: selectedSeats.length > 0
                      ? Colors.white
                      : Color(0xFFBEBEBE),
                ),
                onPressed: selectedSeats.length > 0
                    ? () {
                        Navigator.of(context).push(routeTransition(CheckoutPage(
                            widget.ticket.copyWith(seats: selectedSeats))));
                      }
                    : null,
              ),
            ),
            SizedBox(
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
                )),
      ));
      widgets.add(SizedBox(
        height: 16,
      ));
    }
    return Column(
      children: widgets,
    );
  }
}
