import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nest_track/modules/profile/edit_profile/edit_profile_view.dart';
import 'package:nest_track/modules/profile/profile_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Stack(
          children: [
            // Ameba background graphic
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/png/profile_ameba.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final user = controller.user.value;
                  if (user == null) {
                    return const Center(
                      child: Text("Failed to load profile", style: TextStyle(color: Colors.white)),
                    );
                  }

                  return Column(
                    children: [
                      SizedBox(height: 30.h),

                      // Header Row
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Icon(Icons.arrow_back, color: Colors.white, size: 28.sp),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to edit page if needed
                              Get.to(() => EditProfileView());
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Icon(Icons.edit, color: Colors.white, size: 18.sp),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      // Profile image
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 90,),
                          CircleAvatar(
                            radius: 66.r,
                            backgroundColor: Colors.grey.shade200,
                            child: user.profileImage.isNotEmpty
                                ? ClipOval(
                              child: Image.network(
                                user.profileImage,
                                width: 112.r,
                                height: 112.r,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Icon(
                                  Icons.person,
                                  size: 56.r,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                                : Icon(Icons.person, size: 56.r, color: Colors.grey),
                          ),
                        ],
                      ),



                      SizedBox(height: 40.h),

                      // Info tiles
                      _infoTile(Icons.person, "Name", user.name),
                      SizedBox(height: 24.h),
                      _infoTile(Icons.phone, "Phone no.", user.phone, isPhone: true),
                      SizedBox(height: 24.h),
                      _infoTile(Icons.email, "E-Mail", user.email),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value, {bool isPhone = false}) {
    final isEmpty = value.trim().isEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white, size: 48.sp),
        SizedBox(width: 32.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              isPhone && isEmpty
                  ? GestureDetector(
                onTap: () {
                  // Handle update phone logic here
                  Get.to(() => EditProfileView());
                  // Get.to(UpdatePhoneView()); if you have a screen
                },
                child: Text(
                  'Click to update number',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.orangeAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
                  : Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
