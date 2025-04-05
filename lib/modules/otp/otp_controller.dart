import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../service/auth_service.dart';

class OtpController extends GetxController {
  // Four text fields for OTP digits
  final List<TextEditingController> otpFields = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  final isLoading = false.obs;

  late String email;
  late String name;
  late String password;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    name = args['name'] ?? '';       // Safe fallback
    email = args['email'] ?? '';
    password = args['password'] ?? '';
  }

  Future<void> verifySimpleOtp() async {
    final otp = otpFields.map((c) => c.text.trim()).join();

    if (otp.length != 4 || otp.contains(RegExp(r'[^0-9]'))) {
      Get.snackbar("Error", "Please enter a valid 4-digit OTP",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final response = await AuthService.verifyOtp(email, otp);
      if (response['status'] == 'success') {
        Get.snackbar("Verified", response['message'],
            backgroundColor: Colors.green, colorText: Colors.white);

        // If this is reset password flow
        if (name.isEmpty && password.isEmpty) {
          Get.toNamed(AppPages.updatePass, arguments: {
            'email': email,
            'otp': otp,
          });

        } else {
          // Continue to register if it's signup flow
          final registerResponse = await AuthService.registerWithOtp(name, email, password, otp);

          if (registerResponse['status'] == 'success') {
            Get.snackbar("Registered", registerResponse['message'],
                backgroundColor: Colors.green, colorText: Colors.white);
            Get.toNamed(AppPages.home);
          } else {
            Get.snackbar("Registration Failed", registerResponse['message'],
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        }
      } else {
        Get.snackbar("Error", response['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onClose() {
    for (final c in otpFields) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.onClose();
  }
}
