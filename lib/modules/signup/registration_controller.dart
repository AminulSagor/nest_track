import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../service/auth_service.dart';


class RegistrationController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;

  Future<void> sendOtp() async {
    isLoading.value = true;
    try {
      final response = await AuthService.sendOtp(emailController.text.trim());

      if (response['status'] == 'success') {
        Get.snackbar("Success", response['message'], backgroundColor: Colors.green, colorText: Colors.white);
        // Navigate to OTP screen if needed
        Get.toNamed(AppPages.otp, arguments: {
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        });
      } else {
        Get.snackbar("Error", response['message'], backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error akhane", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
      print("the error is $e");
    } finally {
      isLoading.value = false;
    }
  }
}
