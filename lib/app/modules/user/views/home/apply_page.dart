import 'package:empleo/app/modules/user/views/home/job_apply.dart';
import 'package:empleo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class ApplyPage extends StatelessWidget {
  const ApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(height: 100.h),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/google.png'),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                'Product Lead Manager',
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Google -',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                  Icon(Iconsax.location5, size: 16.sp),
                  Text(
                    'Anderi, Mumbai',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.clock5, size: 16.sp),
                  SizedBox(width: 5.w),
                  Text(
                    'Full Time',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                  SizedBox(width: 10.w),
                  Row(
                    children: [
                      Icon(
                        Icons.currency_rupee_sharp,
                        size: 15.sp,
                      ),
                      Text('1200/m', style: GoogleFonts.poppins(fontSize: 14.sp))
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              TabBar(
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: HexColor('4CA6A8'),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                labelStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  SizedBox(
                    width: 250.w,
                    child: Tab(text: 'Description'),
                  ),
                  SizedBox(
                    width: 250.w,
                    child: Tab(text: 'Company'),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Description(),
                    AboutCompany(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(7.w),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    'Qualification :',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
            _buildListItem('Exceptional communication skill and team'),
            _buildListItem('working skill'),
            _buildListItem('Exceptional communication skill and team'),
            _buildListItem('working skill'),
            _buildListItem('Exceptional communication skill and team'),
            _buildListItem('working skill'),
            SizedBox(height: 30.h),
            GestureDetector(
              onTap: () {
                Get.to(() => JobApply());
              },
              child: Container(
                width: 300.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: HexColor('4CA6A8'),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Center(
                  child: Text(
                    'Apply Now',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        children: [
          SizedBox(width: 20.w),
          Icon(
            Icons.circle,
            size: 13.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutCompany extends StatelessWidget {
  const AboutCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'About',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Google is a multinational company in the silicon valley of '
                'California and one of the leading companies in the technology industry.',
                style: GoogleFonts.poppins(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
