import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sm_seans/screens/edit_profile_page.dart';

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
          style: TextStyle(color: Colors.white),
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
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfilePicture(),
                  SizedBox(height: 12.0),
                  Text(
                    '$firstName $lastName',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _buildStatsSection(),
                  Divider(height: 40.0, color: Colors.white70),
                  _buildHistorySection(context),
                ],
              ),
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

  Widget _buildProfilePicture() {
    return CircleAvatar(
      radius: 60.0,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 55.0,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard(
            'Workouts', workoutsCount.toString(), Colors.purple[100]!),
        VerticalDivider(
          width: 20.0,
          color: Colors.white70,
          thickness: 1.0,
        ),
        _buildStatCard('Weight', '${weight}kg', Colors.purple[100]!),
        VerticalDivider(
          width: 20.0,
          color: Colors.white70,
          thickness: 1.0,
        ),
        _buildStatCard('Age', age.toString(), Colors.purple[100]!),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color textColor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: textColor.withOpacity(0.8),
          ),
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
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20.0),
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
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedHistory = type;
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor:
            selectedHistory == type ? Colors.purple[800] : Colors.white,
        backgroundColor:
            selectedHistory == type ? Colors.white : Colors.purple[400],
      ),
      child: Text(title),
    );
  }

  Widget _buildHistoryDetails() {
    String historyData = '';
    if (selectedHistory == 'week') {
      historyData =
          'Showing workout history for this week ...............................................................................................................................';
    } else if (selectedHistory == 'month') {
      historyData =
          'Showing workout history for this month...............................................................................................................................';
    } else if (selectedHistory == 'year') {
      historyData =
          'Showing workout history for this year.....................................................................................................................................';
    }
    return Text(
      historyData,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );
  }
}
