import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'otp_controller.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  late final OtpController otpController;
  late String email;

  @override
  void initState() {
    super.initState();
    otpController = Get.put(OtpController());
    final args = Get.arguments as Map<String, dynamic>;
    email = args['email'];
  }



  @override
  void dispose() {
    for (final controller in otpController.otpFields) {
      controller.dispose();
    }
    Get.delete<OtpController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1,
                      colors: [
                        Color(0xFFF8A435),
                        Color(0xFF1A1A1A),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -100,
                        right: -100,
                        child: Image.asset(
                          'assets/images/png/otp_circle.png',
                          width: 300,
                          height: 300,
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              const SizedBox(height: 100),
                              SvgPicture.asset('assets/svg/otp_girl.svg', width: 280),
                              const SizedBox(height: 40),
                              const Text(
                                "OTP Verification",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  style: TextStyle(color: Colors.white70, fontSize: 14),
                                  children: [
                                    TextSpan(
                                      text: "We Will send you a one time password on\nthis ",
                                    ),
                                    TextSpan(
                                      text: "Email",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                email,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(4, (index) {
                                  return Container(
                                    width: 60,
                                    height: 60,
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    child: TextField(
                                      controller: otpController.otpFields[index],
                                      focusNode: otpController.focusNodes[index],
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 1,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        counterText: "",
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(100),
                                          borderSide: const BorderSide(color: Color(0xFFF59C1D), width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(100),
                                          borderSide: const BorderSide(color: Colors.orange, width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty && index < 3) {
                                          FocusScope.of(context).requestFocus(otpController.focusNodes[index + 1]);
                                        } else if (value.isEmpty && index > 0) {
                                          FocusScope.of(context).requestFocus(otpController.focusNodes[index - 1]);
                                        }
                                      },
                                    ),
                                  );
                                }),
                              ),
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
                                  onTap: () => otpController.verifySimpleOtp(),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Center(
                                      child: Text(
                                        "Submit",
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
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
