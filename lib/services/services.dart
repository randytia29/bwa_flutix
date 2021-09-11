import 'dart:convert';

import 'package:bwaflutix/models/credit.dart';
import 'package:bwaflutix/models/movie.dart';

import '../main.dart';
import '../models/models.dart';
import '../shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../extensions/extensions.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

part 'auth_services.dart';
part 'flutix_transaction_services.dart';
part 'movie_services.dart';
part 'ticket_services.dart';
part 'user_services.dart';
part 'notification_service.dart';
