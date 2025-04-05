import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../storage/token_storage.dart';

class AuthService {
  static final String baseUrl = dotenv.env['API_BASE_URL']!;

  static Future<Map<String, dynamic>> sendOtp(String email, {String otpMethod = 'signup'}) async {
    final url = Uri.parse('${baseUrl}send_otp.php');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "otp_method": otpMethod,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to send OTP");
    }
  }


  static Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    final url = Uri.parse('${baseUrl}verify_otp.php');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "otp": otp,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("OTP verification failed");
    }
  }

  static Future<Map<String, dynamic>> registerWithOtp(
      String name, String email, String password, String otp) async {
    final url = Uri.parse('${baseUrl}signup.php');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'otp': otp,
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data is Map<String, dynamic>
            ? data
            : {'status': 'error', 'message': 'Invalid response'};
      } else {
        return {
          'status': 'error',
          'message': 'Failed with status ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }


  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('${baseUrl}login.php');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map<String, dynamic> && data['status'] == 'success') {
          final token = data['user']?['token'];
          if (token != null) {
            await TokenStorage.saveToken(token);
          }
        }

        return data;
      } else {
        return {
          'status': 'error',
          'message': 'Login failed with status ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }


  static Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String password,
    required String otp,
  }) async {
    final url = Uri.parse('${baseUrl}reset_password.php');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'otp': otp,
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data is Map<String, dynamic>
            ? data
            : {'status': 'error', 'message': 'Invalid response format'};
      } else {
        return {
          'status': 'error',
          'message': 'Reset failed with status ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }



}
