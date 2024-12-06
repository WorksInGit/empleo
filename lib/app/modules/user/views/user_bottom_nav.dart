import 'package:empleo/app/modules/user/controllers/nav_controller.dart';
import 'package:empleo/app/modules/user/views/application/application.dart';
import 'package:empleo/app/modules/user/views/home/home_page.dart';
import 'package:empleo/app/modules/user/views/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.put(NavController());
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          switch (navController.currentIndex.value) {
            case 0:
              return HomePage();
            case 1:
              return ApplicationPage();
            case 2:
              return SettingsPage();
            default:
              return HomePage();
          }
        }),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r)),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
            child: GNav(
                selectedIndex: navController.currentIndex.value,
                padding: EdgeInsets.all(10.r),
                tabBackgroundColor: Colors.black,
                activeColor: Colors.white,
                gap: 8,
                onTabChange: (index) {
                  navController.changeIndex(index);
                },
                tabs: [
                  GButton(
                    icon: Iconsax.home4,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Iconsax.document,
                    text: 'Application',
                  ),
                  GButton(
                    icon: Iconsax.setting4,
                    text: 'Settings',
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
