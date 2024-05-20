import 'package:bwaflutix/features/ticket/presentation/bloc/order_ticket_bloc.dart';
import 'package:bwaflutix/injection_container.dart';

import '../../bloc/user_bloc.dart';
import '../../features/movie/domain/entities/movie_detail.dart';
import '../../models/theater.dart';
import '../../shared/page_transition.dart';
import '../../shared/theme.dart';
import 'select_seat_page.dart';
import '../widgets/date_card.dart';
import '../widgets/selectable_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_string/random_string.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail? movieDetail;

  const SelectSchedulePage(this.movieDetail, {super.key});

  @override
  State<SelectSchedulePage> createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  final orderTicketBloc = sl<OrderTicketBloc>();

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
      body: BlocProvider(
        create: (context) => orderTicketBloc,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Container(
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
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(
                    defaultMargin, 20, defaultMargin, 16),
                child: Text(
                  'Choose Date',
                  style: blackTextFont.copyWith(fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 24),
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
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (_, userState) {
                    if (userState is UserLoaded) {
                      final user = userState.user;
                      return FloatingActionButton(
                        elevation: 0,
                        backgroundColor:
                            isValid ? mainColor : const Color(0xFFE4E4E4),
                        child: Icon(
                          Icons.arrow_forward,
                          color:
                              isValid ? Colors.white : const Color(0xFFBEBEBE),
                        ),
                        onPressed: () {
                          orderTicketBloc.add(InitOrderTicketProcess(
                              movieId: widget.movieDetail?.id,
                              movieTitle: widget.movieDetail?.title,
                              movieVoteAverage: widget.movieDetail?.voteAverage,
                              movieOverview: widget.movieDetail?.overview,
                              moviePosterPath: widget.movieDetail?.posterPath,
                              movieBackdropPath:
                                  widget.movieDetail?.backdropPath,
                              movieLanguage: widget.movieDetail?.language,
                              movieGenres: widget.movieDetail?.genres,
                              id: user.id,
                              theaterName: selectedTheater?.name,
                              time: DateTime(
                                  selectedDate!.year,
                                  selectedDate!.month,
                                  selectedDate!.day,
                                  selectedTime!),
                              bookingCode: randomAlphaNumeric(12).toUpperCase(),
                              name: user.name));

                          if (isValid) {
                            Navigator.of(context).push(
                              routeTransition(
                                BlocProvider.value(
                                  value: orderTicketBloc,
                                  child: const SelectSeatPage(),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];
    for (var theater in dummyTheaters) {
      widgets.add(Container(
        margin: const EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
        child: Text(
          theater.name!,
          style: blackTextFont.copyWith(fontSize: 20),
        ),
      ));
      widgets.add(Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 20),
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
