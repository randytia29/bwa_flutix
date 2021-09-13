part of 'pages.dart';

class TicketDetailPage extends StatefulWidget {
  final Ticket ticket;

  TicketDetailPage(this.ticket);

  @override
  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 24,
              margin: EdgeInsets.only(top: 20, left: defaultMargin, bottom: 20),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Ticket Details",
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
            Screenshot(
              controller: screenshotController,
              child: TicketDetailCard(ticket: widget.ticket),
            ),
            FlutixButton(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              primaryColor: mainColor,
              child: Text(
                'Share',
                style: whiteTextFont.copyWith(fontSize: 16),
              ),
              onPressed: () async {
                Uint8List? imageBytes = await screenshotController.capture();

                // await saveImage(imageBytes!);

                await shareImage(imageBytes!);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> saveImage(Uint8List imageBytes) async {
    await [Permission.storage].request();

    String time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    await ImageGallerySaver.saveImage(imageBytes,
        name: '${widget.ticket.movieTitle}_$time');
  }

  Future<void> shareImage(Uint8List bytes) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File imagePath = File('${directory.path}/flutix.jpg');
    imagePath.writeAsBytesSync(bytes);

    await Share.shareFiles([imagePath.path]);
  }
}
