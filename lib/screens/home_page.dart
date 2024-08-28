// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sm_seans/models/data.dart';
import 'package:sm_seans/screens/AppointmentsPage.dart';
import 'package:sm_seans/screens/PaymentsPage.dart';
import 'package:sm_seans/screens/ProfilePage.dart';
import 'package:sm_seans/screens/SessionsPage.dart';
import 'package:sm_seans/screens/logoutPage.dart';
import 'package:sm_seans/screens/log_in.dart';
import 'package:sm_seans/services/tokenUserIdservice.dart';

// Ensure this is imported

class HomePage extends StatelessWidget {
  final String userName = "John Doe";
  final String userEmail = "johndoe@example.com";
  final String userQRCode =
      'https://example.com/qr-code'; // Replace with actual QR code data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[800],
        iconTheme:
            IconThemeData(color: Colors.white), // Menu icon color to white
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // "MENU" Text with the same font as "GYMMATE"
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                'MENU',
                style: GoogleFonts.zenDots(
                  // Same font as "GYMMATE" in splash screen
                  textStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.purple[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey), // Divider after "MENU"

            // Home ListTile
            ListTile(
              leading: Icon(Icons.home, color: Colors.purple[800]),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),

            // Appointments ListTile
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.purple[800]),
              title: Text('Appointments'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentsPage()),
                );
              },
            ),

            // Sessions ListTile
            ListTile(
              leading: Icon(Icons.access_time, color: Colors.purple[800]),
              title: Text('Sessions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionsPage()),
                );
              },
            ),

            // Payments ListTile
            ListTile(
              leading: Icon(Icons.payment, color: Colors.purple[800]),
              title: Text('Payments'),
              onTap: () async {
                final authService =
                    AuthService(); // Make sure to initialize the authService here
                final userId =
                    await authService.getUserId(); // Get the saved userId

                if (userId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                          userId: userId), // Pass userId to PaymentPage
                    ),
                  );
                } else {
                  // Handle the case where userId is null (if needed)
                  print('Error: userId is null');
                }
              },
            ),

            // Profile ListTile
            ListTile(
              leading: Icon(Icons.person, color: Colors.purple[800]),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),

            // Log Out ListTile
            ListTile(
              leading: Icon(Icons.logout, color: Colors.purple[800]),
              title: Text('Log Out'),
              onTap: () {
                showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.purple[800],
                  child: CircleAvatar(
                    radius: 55.0,
                    backgroundColor: Colors.white,
                    child: Text(
                      userName[0],
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.purple[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800],
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  userEmail,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  'Your QR Code',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800],
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
