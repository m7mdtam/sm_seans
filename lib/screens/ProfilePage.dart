// ignore_for_file: prefer_const_constructors, unused_import, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_profile_page.dart'; // Ensure the correct path to your EditProfilePage

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ProfilePageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: appBarTextStyle,
        ),
        backgroundColor: Colors.purple[800],
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _navigateToEditProfile(context);
            },
          ),
        ],
      ),
      body: Container(
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
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfilePicture(),
                SizedBox(height: 5.0),
                Text(
                  '$firstName $lastName',
                  style: nameTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.0),
                Text(
                  email,
                  style: emailTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                _buildStatsSection(),
                SizedBox(height: 10.0),
                _buildHistorySection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

mixin ProfilePageMixin on State<ProfilePage> {
  String firstName = "Mohammed";
  String lastName = "Altamimi";
  String email = "mohammedtamimi72@gmail.com";
  int workoutsCount = 50;
  double weight = 75.0;
  int age = 30;
  String selectedHistory = "week";

  // Text Styles
  final TextStyle appBarTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
  );

  final TextStyle nameTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  final TextStyle emailTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
  );

  final TextStyle statValueTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  final TextStyle statLabelTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
  );

  final TextStyle sectionTitleTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  final TextStyle historyButtonTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
  );

  final TextStyle historyDetailTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
  );

  Widget _buildProfilePicture() {
    return CircleAvatar(
      radius: 60.0,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 56.0,
        backgroundColor: Colors.purple[800],
        child: Icon(
          Icons.person,
          size: 60.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Card(
      color: Colors.purple[600]?.withOpacity(0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatCard('Workouts', workoutsCount.toString()),
            _buildStatCard('Weight', '${weight} kg'),
            _buildStatCard('Age', age.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: statValueTextStyle,
        ),
        SizedBox(height: 4.0),
        Text(
          title,
          style: statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildHistorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Workout History',
          style: sectionTitleTextStyle,
        ),
        SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildHistoryButton('Week', 'week'),
            _buildHistoryButton('Month', 'month'),
            _buildHistoryButton('Year', 'year'),
          ],
        ),
        SizedBox(height: 20.0),
        _buildHistoryDetails(),
      ],
    );
  }

  Widget _buildHistoryButton(String title, String type) {
    bool isSelected = selectedHistory == type;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedHistory = type;
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.purple[800] : Colors.white,
        backgroundColor: isSelected ? Colors.white : Colors.purple[600],
        elevation: isSelected ? 5 : 2,
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Text(
        title,
        style: historyButtonTextStyle.copyWith(
          color: isSelected ? Colors.purple[800] : Colors.white,
        ),
      ),
    );
  }

  Widget _buildHistoryDetails() {
    String historyData;
    switch (selectedHistory) {
      case 'week':
        historyData = 'You completed 5 workouts this week. Great job!';
        break;
      case 'month':
        historyData = 'You completed 20 workouts this month. Keep it up!';
        break;
      case 'year':
        historyData = 'You completed 200 workouts this year. Amazing progress!';
        break;
      default:
        historyData = 'Select a time frame to view history.';
    }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.purple[600]?.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            historyData,
            style: historyDetailTextStyle,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.purple[600]?.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            historyData,
            style: historyDetailTextStyle,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.purple[600]?.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            historyData,
            style: historyDetailTextStyle,
          ),
        ),
      ],
    );
  }

  void _navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );
  }
}
