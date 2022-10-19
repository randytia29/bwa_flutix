import 'dart:io';
import 'dart:typed_data';

import 'package:bwaflutix/features/ticket/domain/entities/ticket.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/theme.dart';
import '../widgets/flutix_button.dart';
import '../widgets/ticket_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class TicketDetailPage extends StatefulWidget {
  final Ticket? ticket;

  const TicketDetailPage(this.ticket, {Key? key}) : super(key: key);

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
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
              margin: const EdgeInsets.only(
                  top: 20, left: defaultMargin, bottom: 20),
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
                      icon: const Icon(Icons.arrow_back),
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
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              primaryColor: mainColor,
              child: Text(
                'Share',
                style: whiteTextFont.copyWith(fontSize: 16),
              ),
              onPressed: () async {
                Uint8List? imageBytes = await screenshotController.capture();

                if (imageBytes != null) {
                  await shareImage(imageBytes);
                }
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
        name: '${widget.ticket!.movieTitle}_$time');
  }

  Future<void> shareImage(Uint8List bytes) async {
    Directory directory = await getApplicationDocumentsDirectory();

    File filePath = File('${directory.path}/flutix.jpg');
    filePath.writeAsBytesSync(bytes);

    XFile imagePath = XFile(filePath.path);

    await Share.shareXFiles([imagePath]);
  }
}
