import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sm_seans/models/data.dart';
import 'package:sm_seans/services/tokenUserIdservice.dart';

class PaymentService {
  final String baseUrl;

  PaymentService({required this.baseUrl});

  Future<UserPaymentSessionInfo?> fetchUserPaymentSessionInfo(
      int userId) async {
    final authService = AuthService();

    final user_id = await authService.getUserId();
    final url = Uri.parse('$baseUrl/api/Payment/user/$user_id');
    final savedToken = await authService.getAuthToken();

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        // Add authentication header if necessary
        'Authorization': 'Bearer $savedToken',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserPaymentSessionInfo.fromJson(data);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user payment and session info: $e');
      return null;
    }
  }
}
