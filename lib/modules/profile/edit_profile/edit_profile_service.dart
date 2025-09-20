import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../storage/token_storage.dart';

class EditProfileService {
  static Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
    String? phone,
    File? imageFile,
    String? otp,
  }) async {
    var uri = Uri.parse('https://www.neststrack.com/api/update_profile.php');

    final token = await TokenStorage.getToken(); // Auth token

    var request = http.MultipartRequest('POST', uri)
      ..fields['name'] = name
      ..fields['email'] = email;

    if (phone != null && phone.isNotEmpty) {
      request.fields['phone'] = phone;
    }

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('profile_image', imageFile.path));
    }

    request.headers['Authorization'] = 'Bearer $token';

    if (otp != null) {
      request.headers['otp'] = otp;
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    return jsonDecode(response.body);
  }


  static Future<Map<String, dynamic>> checkEmailForOtp(String email) async {
    final token = await TokenStorage.getToken();

    final response = await http.put(
      Uri.parse('https://www.neststrack.com/api/send_otp_for_update.php'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email}),
    );

    return jsonDecode(response.body);
  }

}
