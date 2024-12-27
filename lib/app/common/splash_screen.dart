import 'package:empleo/app/common/landing_page.dart';
import 'package:empleo/app/modules/user/views/user_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _checkLoginStatus();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200.r,
                height: 200.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50).r,
                  image: const DecorationImage(
                    image: AssetImage('assets/icons/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkLoginStatus() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); 
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (isLoggedIn) {
        Get.offAll(() => BottomNav(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 1000));
      } else {
        Get.offAll(() => LandingPage(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 1000));
      }
    } catch (e) {
      print("Error checking login status: $e");
      Get.offAll(() => LandingPage(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 1000));
    }
  }
}