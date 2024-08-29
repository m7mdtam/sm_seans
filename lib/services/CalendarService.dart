// ignore_for_file: file_names

import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:sm_seans/services/auth.dart';

class CalendarService {
  Future<List<calendar.Event>> getEvenets() async {
    final authClient = await getAuthClient();
    final calendarApi = calendar.CalendarApi(authClient);

    final now = DateTime.now();
    final startTime = DateTime(now.year, now.month, now.day);
    final endTime = startTime.add(Duration(days: 1));

    final events = await calendarApi.events.list(
      'primary',
      singleEvents: true,
      orderBy: 'startTime',
    );

    return events.items ?? [];
  }
}
