import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../service/auth_service.dart';
import '../../utils/validation_util.dart';

class UpdatePassController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  late String email;
  late String otp;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'] ?? '';
    otp = Get.arguments['otp'] ?? '';
  }

  Future<void> handleReset() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final res = await AuthService.resetPassword(
        email: email,
        password: passwordController.text.trim(),
        otp: otp,
      );

      if (res['status'] == 'success') {
        Get.snackbar('Success', res['message'], backgroundColor: Colors.green, colorText: Colors.white);
        Get.toNamed(AppPages.signUp);
      } else {
        Get.snackbar('Error', res['message'], backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
