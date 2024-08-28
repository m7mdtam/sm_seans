import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sm_seans/models/data.dart';
import 'package:sm_seans/services/fetchsessiondata.dart';

class PaymentPage extends StatefulWidget {
  final int userId;

  PaymentPage({required this.userId});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Future<UserPaymentSessionInfo?> _futureUserPaymentSessionInfo;
  final PaymentService _paymentService = PaymentService(
      baseUrl: 'https://localhost:7005'); // Replace with your API base URL

  @override
  void initState() {
    super.initState();
    _futureUserPaymentSessionInfo =
        _paymentService.fetchUserPaymentSessionInfo(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[800],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<UserPaymentSessionInfo?>(
        future: _futureUserPaymentSessionInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available.'));
          } else {
            final userPaymentSessionInfo = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(
                    title: 'Total Paid',
                    value:
                        '\$${userPaymentSessionInfo.amountPaid.toStringAsFixed(2)}',
                    color: Colors.green[700],
                  ),
                  SizedBox(height: 16),
                  _buildInfoCard(
                    title: 'Sessions Attended',
                    value:
                        '${userPaymentSessionInfo.sessionsAttended} / ${userPaymentSessionInfo.sessionsAttended + userPaymentSessionInfo.sessionsRemaining}',
                    color: Colors.blue[700],
                  ),
                  SizedBox(height: 16),
                  _buildInfoCard(
                    title: 'Sessions Remaining',
                    value: '${userPaymentSessionInfo.sessionsRemaining}',
                    color: userPaymentSessionInfo.sessionsRemaining <= 3
                        ? Colors.red[700]
                        : Colors.orange[700],
                  ),
                  if (userPaymentSessionInfo.sessionsRemaining <= 3) ...[
                    SizedBox(height: 16),
                    Text(
                      'Reminder: You are low on sessions! Please renew your membership.',
                      style: GoogleFonts.zenDots(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.red[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoCard(
      {required String title, required String value, required Color? color}) {
    return Card(
      elevation: 5,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          title,
          style: GoogleFonts.zenDots(
            textStyle: TextStyle(
              fontSize: 20,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 20,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
