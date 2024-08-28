import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sessions',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[800],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Text(
          'Your Sessions',
          style: GoogleFonts.zenDots(
            textStyle: TextStyle(
              fontSize: 24,
              color: Colors.purple[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
