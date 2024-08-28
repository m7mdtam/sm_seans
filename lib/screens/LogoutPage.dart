import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sm_seans/screens/log_in.dart';
import 'package:sm_seans/screens/sign_up.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Log Out'),
        content: Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
          TextButton(
            child: Text('Log Out'),
            onPressed: () async {
              // Perform logout logic here
              await _invalidateToken();

              // Clear the token from local storage
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('auth_token');

              Navigator.of(context).pop(); // Dismiss the dialog
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LogIn()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      );
    },
  );
}

Future<void> _invalidateToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');

  if (token != null) {
    final response = await http.post(
      Uri.parse('https://localhost:7005/api/Auth/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Token invalidated successfully');
    } else {
      print('Failed to invalidate token');
    }
  }
}
