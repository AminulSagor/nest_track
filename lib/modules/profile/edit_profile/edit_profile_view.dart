import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'edit_profile_controller.dart';

class EditProfileView extends StatelessWidget {
  final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Stack(
            children: [
              // Background color split
              Column(
                children: [
                  Container(
                    height: 185.h,
                    color: const Color(0xFFDC6A11), // Orange Top
                  ),
                  Container(
                    height: 700.h, // Adjust as needed
                    color: Colors.black, // Bottom black
                  ),
                ],
              ),

              // Foreground UI content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Back button + title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white),
                            ),
                            child: Icon(Icons.arrow_back, color: Colors.white,size: 38,),
                          ),
                        ),
                        Text("Edit Profile",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp)),
                        SizedBox(width: 24), // Symmetry
                      ],
                    ),

                    SizedBox(height: 30.h),

                    // Profile Image
                    // Profile Image
                    GestureDetector(
                      onTap: controller.pickImage,
                      child: CircleAvatar(
                        radius: 60.r,
                        backgroundColor: Colors.white,
                        child: controller.pickedImage.value != null
                            ? ClipOval(
                          child: Image.file(
                            controller.pickedImage.value!,
                            width: 112.r,
                            height: 112.r,
                            fit: BoxFit.cover,
                          ),
                        )
                            : (controller.user.value?.profileImage.isNotEmpty == true
                            ? ClipOval(
                          child: Image.network(
                            controller.user.value!.profileImage,
                            width: 112.r,
                            height: 112.r,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.person,
                              size: 40.sp,
                              color: Colors.grey,
                            ),
                          ),
                        )
                            : Icon(Icons.person, size: 40.sp, color: Colors.grey)),
                      ),
                    ),



                    SizedBox(height: 6.h),
                    Text("Change Picture", style: TextStyle(color: Colors.white)),

                    SizedBox(height: 30.h),

                    // Fields
                    _buildInput("Username", controller.nameController),
                    SizedBox(height: 20.h),
                    _buildInput("Email I’d", controller.emailController),
                    SizedBox(height: 20.h),
                    _buildInput("Phone Number", controller.phoneController),

                    SizedBox(height: 30.h),

                    GestureDetector(
                      onTap: () => Get.toNamed('/ChangePassword'),
                      child: Text(
                        "Change password ?",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    GestureDetector(
                      onTap: () => controller.checkEmailBeforeUpdate(),

                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF8B1F1F), // dark red
                              Color(0xFF2C0F0F), // deeper tone for right
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.white38),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      }),
    );
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.sp)),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.circular(10.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orangeAccent),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ],
    );
  }
}
