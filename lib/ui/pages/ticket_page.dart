part of 'pages.dart';

class TicketPage extends StatefulWidget {
  final bool isExpiredTicket;

  TicketPage({this.isExpiredTicket = false});

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  late bool isExpiredTickets;

  @override
  void initState() {
    super.initState();
    isExpiredTickets = widget.isExpiredTicket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<TicketBloc, TicketState>(
              builder: (_, ticketState) => Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: TicketViewer(isExpiredTickets
                        ? ticketState.tickets
                            .where((ticket) =>
                                ticket.time.isBefore(DateTime.now()))
                            .toList()
                        : ticketState.tickets
                            .where((ticket) =>
                                !ticket.time.isBefore(DateTime.now()))
                            .toList()),
                  )),
          ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              height: 113,
              decoration: BoxDecoration(color: accentColor1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: defaultMargin, bottom: 32),
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
                                      ? Color(0xFF6F678E)
                                      : Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                if (isExpiredTickets)
                                  isExpiredTickets = !isExpiredTickets;
                              });
                            },
                          ),
                          SizedBox(
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
                                if (!isExpiredTickets)
                                  isExpiredTickets = !isExpiredTickets;
                              });
                            },
                            child: Text(
                              "Oldest",
                              style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  color: isExpiredTickets
                                      ? Colors.white
                                      : Color(0xFF6F678E)),
                            ),
                          ),
                          SizedBox(
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

  TicketViewer(this.tickets);

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
                margin: EdgeInsets.only(right: 16),
                width: 70,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(imageBaseUrl +
                            "w500" +
                            sortedTickets[index].movieDetail!.posterPath!),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width:
                    MediaQuery.of(context).size.width - 2 * defaultMargin - 86,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sortedTickets[index].movieDetail!.title!,
                      style: blackTextFont.copyWith(fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        sortedTickets[index].movieDetail!.genresAndLanguage,
                        style: greyTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      sortedTickets[index].theater!.name!,
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
