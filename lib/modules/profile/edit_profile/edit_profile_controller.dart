import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nest_track/models/user_model.dart';
import 'package:nest_track/modules/profile/edit_profile/edit_profile_service.dart';
import 'package:nest_track/modules/profile/profile_service.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final isLoading = false.obs;
  final pickedImage = Rx<File?>(null);
  final user = Rxn<UserModel>();

  String? previousEmail;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  void fetchUserDetails() async {
    isLoading.value = true;
    final fetchedUser = await ProfileService.fetchUserProfile();

    if (fetchedUser != null) {
      user.value = fetchedUser;
      nameController.text = fetchedUser.name;
      emailController.text = fetchedUser.email;
      phoneController.text = fetchedUser.phone ?? '';
      previousEmail = fetchedUser.email; // Store current email
    }

    isLoading.value = false;
  }

  void pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      pickedImage.value = File(file.path);
    }
  }

  void checkEmailBeforeUpdate() async {
    isLoading.value = true;

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    final response = await EditProfileService.checkEmailForOtp(email);

    isLoading.value = false;

    if (response['status'] == 'success') {
      final responseCode = response['response_code'];

      if (responseCode == 0) {
        // Email unchanged, update profile directly (no OTP required)
        updateProfile(
          name: name,
          email: email,
          phone: phone,
          otp: null,
        );
      } else if (responseCode == 1) {
        // Email updated, go to OTP page
        Get.toNamed('/otp', arguments: {
          'email': email,
          'fromEditProfile': true,
          'onVerified': (String otpCode) {
            updateProfile(
              name: name,
              email: email,
              phone: phone,
              otp: otpCode,
            );
          },
        });
      } else {
        Get.snackbar("Error", "Invalid response code",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar("Error", response['message'] ?? "Email check failed",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
    String? otp,
  }) async {
    isLoading.value = true;

    final result = await EditProfileService.updateProfile(
      name: name,
      email: email,
      phone: phone.isEmpty ? null : phone,
      imageFile: pickedImage.value,
      otp: otp,
    );

    isLoading.value = false;

    if (result['status'] == 'success') {
      Get.snackbar("Success", "Profile updated successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Error", result['message'] ?? "Update failed",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}

