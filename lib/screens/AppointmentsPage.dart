import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:sm_seans/services/CalendarService.dart';
import 'package:sm_seans/services/auth.dart';

class AppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage>
    with AppointmentsPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointments',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[800],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(_errorMessage, style: TextStyle(color: Colors.red)))
              : _appointments.isEmpty
                  ? Center(child: Text('No appointments today.'))
                  : ListView.builder(
                      itemCount: _appointments.length,
                      itemBuilder: (context, index) {
                        final event = _appointments[index];
                        final start = event.start?.dateTime ?? DateTime.now();
                        final end = event.end?.dateTime ?? DateTime.now();
                        final formattedStart = DateFormat.jm().format(start);
                        final formattedEnd = DateFormat.jm().format(end);

                        return Card(
                          margin: EdgeInsets.all(8),
                          elevation: 5,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              event.summary ?? 'No Title',
                              style: GoogleFonts.zenDots(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time: $formattedStart - $formattedEnd',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Location: ${event.location ?? 'No Location'}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            tileColor: Colors.purple[50],
                          ),
                        );
                      },
                    ),
    );
  }
}

mixin AppointmentsPageMixin on State<AppointmentsPage> {
  final CalendarService _calendarService = CalendarService();
  List<calendar.Event> _appointments = [];
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    try {
      final appointments = await _calendarService.getEvenets();
      print('Fetched ${appointments.length} appointments.');
      setState(() {
        _appointments = appointments;
        _loading = false;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
      setState(() {
        _loading = false;
        _errorMessage = 'Failed to load appointments. Please try again later.';
      });
    }
  }
}
