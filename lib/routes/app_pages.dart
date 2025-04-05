import 'package:get/get.dart';
import 'package:nest_track/modules/forget_pass/forget_pass_view.dart';
import 'package:nest_track/modules/home/home_view.dart';
import 'package:nest_track/modules/login/login_view.dart';
import 'package:nest_track/modules/otp/otp_view.dart';
import 'package:nest_track/modules/signup/registration_view.dart';
import 'package:nest_track/modules/signup/signup_view.dart';
import 'package:nest_track/modules/update_pass/update_pass_view.dart';
import '../modules/landing/landing_view.dart';

class AppPages {
  static const INITIAL = '/';
  static const signUp = '/signup';
  static const registration = '/registration';
  static const login = '/login';
  static const otp = '/otp';
  static const updatePass = '/update_pass';
  static const home = '/home';
  static const forgetPass = '/forget_pass';

  static final routes = [
    GetPage(
      name: '/',
      page: () => LandingView(),
    ),
    GetPage(
      name: signUp,
      page: () => SignupView(),
    ),
    GetPage(
      name: registration,
      page: () => RegistrationView(),
    ),
    GetPage(
      name: login,
      page: () => LoginView(),
    ),
    GetPage(
      name: otp,
      page: () => OtpView(),
    ),
    GetPage(
      name: updatePass,
      page: () => UpdatePassView(),
    ),
    GetPage(
      name: home,
      page: () => HomeView(),
    ),
    GetPage(
      name: forgetPass,
      page: () => ForgetPassView(),
    ),
  ];
}
