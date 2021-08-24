part of 'widgets.dart';

class TicketDetailBackdrop extends StatelessWidget {
  const TicketDetailBackdrop({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                imageBaseUrl + "w780" + ticket.movieDetail!.backdropPath!),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
    );
  }
}
