import 'package:empleo/app/common/views/feedbacks_page.dart';
import 'package:empleo/app/modules/company/controllers/login_controller.dart';
import 'package:empleo/app/modules/company/views/settings/company_faq.dart';
import 'package:empleo/app/modules/company/views/settings/company_profile.dart';
import 'package:empleo/app/modules/company/views/settings/support_page.dart';
import 'package:empleo/app/modules/user/views/settings/about_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CompanySettings extends StatelessWidget {
  CompanySettings({super.key});
  final LoginPageController controller = Get.put(LoginPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        titleTextStyle: GoogleFonts.poppins(
            fontSize: 20.sp, fontWeight: FontWeight.w500, color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
      ),
      backgroundColor: Color.fromARGB(255, 244, 243, 243),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.all(15.w),
            child: Row(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CompanyProfile(),
                        transition: Transition.cupertino,
                        duration: Duration(milliseconds: 500)
                        );
                      },
                      child: Container(
                        width: 250.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.h)),
                        child: Row(
                          children: [
                            SizedBox(width: 10.w),
                            Icon(
                              Iconsax.profile_circle5,
                              size: 40.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Profile',
                              style: GoogleFonts.poppins(),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                       Get.to(() => FeedbacksPage(),
                        transition: Transition.cupertino,
                        duration: Duration(milliseconds: 500)
                       );
                      },
                      child: Container(
                        width: 250.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.h)),
                        child: Row(
                          children: [
                            SizedBox(width: 10.w),
                            Icon(
                              Iconsax.activity5,
                              size: 40.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Feedback',
                              style: GoogleFonts.poppins(),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CompanyFaq(),
                         transition: Transition.cupertino,
                        duration: Duration(milliseconds: 500)
                        );
                      },
                      child: Container(
                        width: 250.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.h)),
                        child: Row(
                          children: [
                            SizedBox(width: 10.w),
                            Icon(
                              Iconsax.message_question5,
                              size: 40.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'FAQ',
                              style: GoogleFonts.poppins(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                       Get.to(() => AboutApp(),
                        transition: Transition.cupertino,
                        duration: Duration(milliseconds: 500)
                       );
                      },
                      child: Container(
                        width: 250.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.h)),
                        child: Row(
                          children: [
                            SizedBox(width: 10.w),
                            Icon(
                              Iconsax.medal5,
                              size: 40.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'About',
                              style: GoogleFonts.poppins(),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SupportPage(),
                         transition: Transition.cupertino,
                        duration: Duration(milliseconds: 500)
                        );
                      },
                      child: Container(
                        width: 250.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Row(
                          children: [
                            SizedBox(width: 10.w),
                            Icon(
                              Iconsax.support5,
                              size: 40.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Support and Assistance',
                              style: GoogleFonts.poppins(),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () => controller.logOut(),
                      child: Container(
                        width: 250.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Row(
                          children: [
                            SizedBox(width: 10.w),
                            Icon(
                              Iconsax.logout5,
                              size: 40.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'LogOut',
                              style: GoogleFonts.poppins(),
                            )
                          ],
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
