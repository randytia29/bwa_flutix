import 'dart:io';
import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';

String? apiKey = dotenv.env['TMDB_API_KEY'];
String imageBaseUrl = 'https://image.tmdb.org/t/p/';
String baseUrl = 'api.themoviedb.org';
File? imageFileToUpload;
Size samsungJ6 = Size(720, 1480);
