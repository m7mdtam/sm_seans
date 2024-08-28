// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

final _clinetId = ClientId(
    '319610165409-cdhk8n5nj578p6rpi4n60nq6ijkqnk39.apps.googleusercontent.com',
    '');
final _scopes = [CalendarApi.calendarScope];

Future<AuthClient> getAuthClient() async {
  final completer = Completer<AuthClient>();
  await clientViaUserConsent(_clinetId, _scopes, (url) {
    launch(url);
  }).then((client) {
    completer.complete(client);
  }).catchError((error) {
    completer.completeError(error);
  });
  return completer.future;
}
