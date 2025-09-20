// controllers/profile_controller.dart
import 'package:get/get.dart';
import 'package:nest_track/modules/profile/profile_service.dart';
import '../../models/user_model.dart';


class ProfileController extends GetxController {
  Rxn<UserModel> user = Rxn<UserModel>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void fetchUser() async {
    isLoading.value = true;
    user.value = await ProfileService.fetchUserProfile();
    isLoading.value = false;
  }
}
