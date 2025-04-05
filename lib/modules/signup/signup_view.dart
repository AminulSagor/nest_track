import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../utils/validation_util.dart';
import 'signup_controller.dart';

class SignupView extends StatelessWidget {
  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
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
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 60, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Enter Your Email and Password \nto login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.5,
                    ),
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
                  buildLabel("Email"),
                  TextFormField(
                    controller: controller.emailController,
                    validator: ValidationUtil.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: buildInputDecoration("Enter Your Email"),
                  ),
                  buildLabel("Password"),
                  TextFormField(
                    controller: controller.passwordController,
                    validator: ValidationUtil.validatePassword,
                    obscureText: true,
                    decoration: buildInputDecoration("Enter Your Password"),
                  ),
                  const SizedBox(height: 50),
                  buildGradientButton("Login", controller.submitForm),
                  const SizedBox(height: 16),
                  const Text(
                    "Or",
                    style: TextStyle(
                      color: Color(0xFFBDCA06),
                      fontSize: 20,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppPages.registration),
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                        color: Color(0xFF06CA41),
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppPages.forgetPass),
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Color(0xFF06CA41),
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 6, left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(label, style: const TextStyle(color: Color(0xFF8E8E8E))),
      ),
    );
  }

  InputDecoration buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.black,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
    );
  }

  Widget buildGradientButton(String text, VoidCallback onTap) {
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
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Center(
            child: Text(
              "Login",
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
