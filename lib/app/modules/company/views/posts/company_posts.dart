import 'dart:ffi';

import 'package:empleo/app/modules/company/controllers/button_controller.dart';
import 'package:empleo/app/modules/company/views/posts/add_posts.dart';
import 'package:empleo/app/modules/company/views/posts/company_applications.dart';
import 'package:empleo/app/modules/company/views/posts/company_shortlisted.dart';
import 'package:empleo/app/modules/user/controllers/nav_controller.dart';
import 'package:empleo/app/modules/user/views/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class CompanyPosts extends StatelessWidget {
  const CompanyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Posts',
                  style: GoogleFonts.poppins(
                      fontSize: 30.sp, fontWeight: FontWeight.w500),
                )
              ],
            ),
            20.h.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TabBar(
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                      color: HexColor('4CA6A8'),
                      borderRadius: BorderRadius.circular(15.r)),
                  labelStyle: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: [
                    Container(
                        width: 250.w,
                        child: Tab(
                          text: 'Your Posts',
                        )),
                    Container(
                        width: 250.w,
                        child: Tab(
                          text: 'Short Listed',
                        )),
                  ]),
            ),
            20.h.verticalSpace,
            Expanded(
              child: TabBarView(
                children: [YourPosts(), ShortListed()],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor('4CA6A8'),
          onPressed: () {
            Get.to(() => AddPosts());
          },
          child: Icon(
            Iconsax.add5,
            size: 40.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class YourPosts extends StatelessWidget {
  const YourPosts({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonController controller = Get.put(ButtonController());
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(() => CompanyApplications());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/icons/google.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Google',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'UI/UX Desingner',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Andheri Mumbai',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.toggleText();
                            },
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black54,
                            ),
                          ),
                          Obx(
                            () {
                              return controller.showText.value
                                  ? ElevatedButton(
                                      onPressed: () {}, child: Text('Delete'))
                                  : SizedBox();
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '20000 Monthly',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ShortListed extends StatelessWidget {
  const ShortListed({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonController controller = Get.put(ButtonController());
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(() => CompanyShortlisted());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/icons/google.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Google',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'UI/UX Desingner',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Andheri Mumbai',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                     Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.toggleText();
                            },
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black54,
                            ),
                          ),
                          Obx(
                            () {
                              return controller.showText.value
                                  ? ElevatedButton(
                                      onPressed: () {}, child: Text('Delete'))
                                  : SizedBox();
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '20000 Monthly',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
