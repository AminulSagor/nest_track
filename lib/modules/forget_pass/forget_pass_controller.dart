import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nest_track/modules/otp/otp_view.dart';
import '../../service/auth_service.dart';
import '../update_pass/update_pass_view.dart';

class ForgetPassController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final isLoading = false.obs;

  void handleNext() async {
    if (formKey.currentState?.validate() ?? false) {
      final email = emailController.text.trim();

      isLoading.value = true;

      try {
        final response = await AuthService.sendOtp(email, otpMethod: 'reset');

        if (response['status'] == 'success') {
          Get.snackbar("OTP Sent", response['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
          Get.to(() => const OtpView(), arguments: {'email': email});
        } else {
          Get.snackbar("Error", response['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar("Error", e.toString(),
            backgroundColor: Colors.red, colorText: Colors.white);
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
