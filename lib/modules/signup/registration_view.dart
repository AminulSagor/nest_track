import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nest_track/modules/signup/registration_controller.dart';
import '../../routes/app_pages.dart';
import '../../utils/validation_util.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(RegistrationController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFDC6A11),
              Colors.black,
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Transform.translate(
                      offset: Offset(200, 50),
                      child: SvgPicture.asset(
                        'assets/svg/dotted_line.svg',
                      ),
                    ),
                    const Text(
                      "Upload Your Information",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 60, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),

                    buildLabel("Name"),
                    buildTextField("Enter Your Name", controller: controller.nameController, validator: ValidationUtil.validateName),

                    buildLabel("Email"),
                    buildTextField("Enter Your Email", controller: controller.emailController, validator: ValidationUtil.validateEmail),

                    buildLabel("Password"),
                    buildTextField("Enter Your Password", controller: controller.passwordController, obscure: true, validator: ValidationUtil.validatePassword),

                    buildLabel("Confirm Password"),
                    buildTextField("Repeat The same Password", controller: controller.confirmPasswordController, obscure: true, validator: (value) {
                      if (value != controller.passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    }),

                    const SizedBox(height: 40),

                    Container(
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
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.sendOtp();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Center(
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    GestureDetector(
                      onTap: () => Get.toNamed(AppPages.signUp),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Login with ",
                              style: TextStyle(color: Colors.green, fontSize: 14),
                            ),
                            TextSpan(
                              text: "Different Account ?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
        child: Text(
          label,
          style: TextStyle(color: Color(0xFF8E8E8E)),
        ),
      ),
    );
  }

  Widget buildTextField(String hint,
      {bool obscure = false,
        required TextEditingController controller,
        String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.black,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
