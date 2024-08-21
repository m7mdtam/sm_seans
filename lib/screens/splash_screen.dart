import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'log_in.dart'; // Make sure this path is correct

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 190, 197, 195), // Light background
                Color.fromARGB(255, 200, 140, 231), // Light purple
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90,
                ),
                // Image with rounded borders using ClipRRect
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(100.0), // Circular borders
                  child: Image.asset(
                    'lib/images/logom.jpeg', // Make sure you have an image in this path
                    height: 200, // Adjust size as needed
                    width: 200, // Adjust size as needed
                    fit: BoxFit
                        .cover, // Ensures the image covers the whole space
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'GYMMate',
                  style: GoogleFonts.zenDots(
                    textStyle: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800],
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'Get ready to take your fitness journey to the next level with FitLife, your all-in-one gym companion.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color:
                          Colors.purple[800]?.withOpacity(0.7), // Light color
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 142, 80, 198),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
