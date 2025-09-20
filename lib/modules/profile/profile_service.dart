// services/profile_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/user_model.dart';
import '../../storage/token_storage.dart';


class ProfileService {
  static const String baseUrl = "https://www.neststrack.com/api";

  static Future<UserModel?> fetchUserProfile() async {
    final token = await TokenStorage.getToken(); // Get bearer token
    final response = await http.get(
      Uri.parse('$baseUrl/get_user_details.php'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['status'] == 'success') {
        return UserModel.fromJson(body['user']);
      }
    }
    return null;
  }
}
