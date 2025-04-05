import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../utils/validation_util.dart';
import 'update_pass_controller.dart';

class UpdatePassView extends StatelessWidget {
  final controller = Get.put(UpdatePassController());

  UpdatePassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFDC6A11), Colors.black],
              stops: [0.0, 0.4],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Image.asset('assets/images/png/reset_icon.png', width: 80, height: 80),
                  const SizedBox(height: 40),
                  const Text(
                    "Enter Your Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/line_login.svg'),
                      const Icon(Icons.arrow_drop_down, color: Colors.green, size: 50),
                      SvgPicture.asset('assets/svg/line_login.svg'),
                    ],
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: controller.passwordController,
                    validator: ValidationUtil.validatePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter your new password",
                      filled: true,
                      fillColor: Colors.black,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Obx(() => controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : buildResetButton()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResetButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8B1A1A), Color(0xFF2B0A0A)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: controller.handleReset,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Center(
            child: Text(
              "Reset",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
