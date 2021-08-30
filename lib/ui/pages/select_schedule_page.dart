part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final Movie? movie;

  SelectSchedulePage(this.movie);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  late List<DateTime> dates;
  DateTime? selectedDate;
  int? selectedTime;
  Theater? selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
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
            ),
            Container(
              margin: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
              child: Text(
                'Choose Date',
                style: blackTextFont.copyWith(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24),
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (_, index) => Container(
                  margin: EdgeInsets.only(
                      left: index == 0 ? defaultMargin : 0,
                      right: index == dates.length - 1 ? defaultMargin : 16),
                  child: DateCard(
                    dates[index],
                    isSelected: selectedDate == dates[index],
                    onTap: () {
                      setState(() {
                        selectedDate = dates[index];
                      });
                    },
                  ),
                ),
              ),
            ),
            generateTimeTable(),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) => FloatingActionButton(
                  elevation: 0,
                  backgroundColor: isValid ? mainColor : Color(0xFFE4E4E4),
                  child: Icon(
                    Icons.arrow_forward,
                    color: isValid ? Colors.white : Color(0xFFBEBEBE),
                  ),
                  onPressed: () {
                    if (isValid) {
                      Navigator.of(context).push(
                        routeTransition(
                          SelectSeatPage(
                            Ticket(
                                widget.movie,
                                selectedTheater,
                                DateTime(
                                    selectedDate!.year,
                                    selectedDate!.month,
                                    selectedDate!.day,
                                    selectedTime!),
                                randomAlphaNumeric(12).toUpperCase(),
                                null,
                                (userState as UserLoaded).user.name,
                                null),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];
    for (var theater in dummyTheaters) {
      widgets.add(Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
        child: Text(
          theater.name!,
          style: blackTextFont.copyWith(fontSize: 20),
        ),
      ));
      widgets.add(Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemCount: schedule.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.only(
                left: index == 0 ? defaultMargin : 0,
                right: index == schedule.length - 1 ? defaultMargin : 16),
            child: SelectableBox(
              '${schedule[index]}:00',
              height: 50,
              isSelected:
                  selectedTheater == theater && selectedTime == schedule[index],
              isEnabled: schedule[index] > DateTime.now().hour ||
                  selectedDate!.day != DateTime.now().day,
              onTap: () {
                setState(() {
                  selectedTheater = theater;
                  selectedTime = schedule[index];
                  isValid =
                      (selectedTime! <= DateTime.now().hour) ? false : true;
                });
              },
            ),
          ),
        ),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
