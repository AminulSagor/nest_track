import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import 'landing_controller.dart';

class LandingView extends GetView<LandingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6D5C5C),
      body: Stack(
        children: [
          // Fullscreen background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/png/landing_page.png',
              fit: BoxFit.cover,
            ),
          ),

          // Content on top of image
          SafeArea(
            child: Column(
              children: [
                // Top section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(height: 100),
                          SizedBox(width: 30),
                          SvgPicture.asset(
                            'assets/svg/logo.svg',
                            height: 37,
                            width: 31,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              Text(
                                "Nest",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0, -8),
                                child: Text(
                                  "Track",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/dropdown.svg',
                            height: 37,
                            width: 31,
                          ),
                          SizedBox(width: 40,),
                        ],
                      ),
                    ],
                  ),
                ),

                Spacer(),

                // Bottom section
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Natural habitat",
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                          SizedBox(height: 10,),
                          Transform.translate(
                            offset: Offset(-30, 0),
                            child: SvgPicture.asset(
                              'assets/svg/dotted_line.svg',

                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Every Egg\nHas a Story–\nWe Help You Tell It",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                                color: Color(0xFFC0C0C0),
                            ),
                          ),


                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-60, -40),
                      child: GestureDetector(
                        onTap: () => Get.toNamed(AppPages.signUp),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(0xFFC0C0C0), width: 2),
                          ),
                          child: Icon(Icons.arrow_forward, color: Color(0xFFC0C0C0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
