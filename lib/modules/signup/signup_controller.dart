import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../service/auth_service.dart';
import '../../storage/token_storage.dart';
import '../../utils/validation_util.dart';
import '../../routes/app_pages.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      Get.snackbar("Logging In", "Please wait...",
          backgroundColor: Colors.blue, colorText: Colors.white);

      final response = await AuthService.login(email, password);

      if (response['status'] == 'success') {
        final token = response['user']?['token'];
        if (token != null) {
          await TokenStorage.saveToken(token);
          Get.offAllNamed(AppPages.home); // Navigate to home
          Get.snackbar('Success', 'Login successful!',
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar('Error', 'Token not found!',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar('Login Failed', response['message'] ?? 'Unknown error',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }
}
