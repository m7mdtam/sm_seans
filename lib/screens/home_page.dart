import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AppointmentsPage.dart';
import 'PaymentsPage.dart';
import 'ProfilePage.dart';
import 'SessionsPage.dart';
import 'logoutPage.dart';
import '../services/tokenUserIdservice.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        backgroundColor: Colors.purple[800],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                'MENU',
                style: GoogleFonts.zenDots(
                  textStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.purple[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.home, color: Colors.purple[800]),
              title: Text(
                'Home',
                style: GoogleFonts.montserrat(),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.purple[800]),
              title: Text(
                'Appointments',
                style: GoogleFonts.montserrat(),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.access_time, color: Colors.purple[800]),
              title: Text(
                'Sessions',
                style: GoogleFonts.montserrat(),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.payment, color: Colors.purple[800]),
              title: Text(
                'Payments',
                style: GoogleFonts.montserrat(),
              ),
              onTap: () async {
                final authService = AuthService();
                final userId = await authService.getUserId();
                if (userId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(userId: userId),
                    ),
                  );
                } else {
                  print('Error: userId is null');
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.purple[800]),
              title: Text(
                'Profile',
                style: GoogleFonts.montserrat(),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.purple[800]),
              title: Text(
                'Log Out',
                style: GoogleFonts.montserrat(),
              ),
              onTap: () {
                showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[700]!,
              Colors.purple[400]!,
              Colors.purple[200]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 55.0,
                  backgroundColor: Colors.purple[800],
                  child: Text(
                    userName[0],
                    style: GoogleFonts.montserrat(
                      fontSize: 50.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                userName,
                style: GoogleFonts.montserrat(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                userEmail,
                style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Your QR Code',
                style: GoogleFonts.montserrat(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              QrImageView(
                data: userQRCode,
                version: QrVersions.auto,
                size: 270.0,
                gapless: false,
                errorStateBuilder: (cxt, err) {
                  return Container(
                    child: Center(
                      child: Text(
                        'Uh oh! Something went wrong...',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

mixin HomePageMixin on State<HomePage> {
  final String userName = "Mohammed altamimi"; // Test username

  final String userEmail = "mohammedtamimi72@gmail.com"; // Test email

  final String userQRCode =
      'https://localhost:7005/api/user/26'; // Test QR Code
}
