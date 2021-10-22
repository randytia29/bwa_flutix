import 'package:bwaflutix/features/ticket/domain/entities/ticket.dart';
import 'package:bwaflutix/features/ticket/presentation/bloc/ticket_bloc.dart';
import 'package:bwaflutix/injection_container.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// import '../../bloc/ticket_bloc.dart';
import '../../core/util/convert_to_string.dart';
import '../../shared/page_transition.dart';
import '../../shared/shared_value.dart';
import '../../shared/theme.dart';
import 'ticket_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketPage extends StatefulWidget {
  final bool isExpiredTicket;

  const TicketPage({Key? key, this.isExpiredTicket = false}) : super(key: key);

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final ticketBloc = sl<TicketBloc>();

  late bool isExpiredTickets;

  @override
  void initState() {
    super.initState();
    isExpiredTickets = widget.isExpiredTicket;
    ticketBloc.add(FetchTicket());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ticketBloc,
        child: Stack(
          children: [
            BlocBuilder<TicketBloc, TicketState>(builder: (_, ticketState) {
              if (ticketState is TicketLoading) {
                return const SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
              if (ticketState is TicketEmpty) {
                return const Center(
                  child: Text('kosong'),
                );
              }
              if (ticketState is TicketLoaded) {
                final tickets = ticketState.tickets;

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: TicketViewer(isExpiredTickets
                      ? tickets!
                          .where(
                              (ticket) => ticket.time.isBefore(DateTime.now()))
                          .toList()
                      : tickets!
                          .where(
                              (ticket) => !ticket.time.isBefore(DateTime.now()))
                          .toList()),
                );
              }
              return Container();
            }),
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 113,
                decoration: const BoxDecoration(color: accentColor1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: defaultMargin, bottom: 32),
                      child: Text(
                        "My Tickets",
                        style: whiteTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              child: Text(
                                "Newest",
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: isExpiredTickets
                                        ? const Color(0xFF6F678E)
                                        : Colors.white),
                              ),
                              onTap: () {
                                setState(() {
                                  if (isExpiredTickets) {
                                    isExpiredTickets = !isExpiredTickets;
                                  }
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                                height: 4,
                                width: MediaQuery.of(context).size.width / 2,
                                color: isExpiredTickets
                                    ? Colors.transparent
                                    : accentColor2)
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (!isExpiredTickets) {
                                    isExpiredTickets = !isExpiredTickets;
                                  }
                                });
                              },
                              child: Text(
                                "Oldest",
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: isExpiredTickets
                                        ? Colors.white
                                        : const Color(0xFF6F678E)),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                                height: 4,
                                width: MediaQuery.of(context).size.width / 2,
                                color: isExpiredTickets
                                    ? accentColor2
                                    : Colors.transparent)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;

  const TicketViewer(this.tickets, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sortedTickets = tickets;
    sortedTickets
        .sort((ticket1, ticket2) => ticket1.time.compareTo(ticket2.time));
    return ListView.builder(
      itemCount: sortedTickets.length,
      itemBuilder: (_, index) => GestureDetector(
        onTap: () async {
          Navigator.of(context)
              .push(routeTransition(TicketDetailPage(sortedTickets[index])));
        },
        child: Container(
          margin: EdgeInsets.only(
              top: index == 0 ? 154 : 0,
              bottom: index == sortedTickets.length - 1 ? 100 : 20),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                width: 70,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(imageBaseUrl +
                            "w500" +
                            sortedTickets[index].moviePosterPath),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width:
                    MediaQuery.of(context).size.width - 2 * defaultMargin - 86,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sortedTickets[index].movieTitle,
                      style: blackTextFont.copyWith(fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        genresAndLanguage(sortedTickets[index].movieGenres,
                            sortedTickets[index].movieLanguage),
                        style: greyTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      sortedTickets[index].theaterName,
                      style: greyTextFont.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
