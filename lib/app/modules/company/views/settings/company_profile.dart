import 'package:empleo/app/modules/company/views/settings/edit_company_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 120.w),
                Text(
                  'Profile',
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 30.w),
                IconButton(
                    onPressed: () {
                      Get.to(() => EditCompanyProfile());
                    },
                    icon: Icon(
                      Iconsax.edit5,
                      size: 30.sp,
                    ))
              ],
            ),
            SizedBox(height: 30.h),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 60.r,
              backgroundImage: AssetImage('assets/icons/google.png'),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                SizedBox(width: 25.w),
                Text(
                  'Company Name',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text(
                      'Nexus',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('4CA6A8')))),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                SizedBox(width: 25.w),
                Text(
                  'Email Address',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text(
                      'nexus@gmail.com',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('4CA6A8')))),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                SizedBox(width: 25.w),
                Text(
                  'Contact Number',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text(
                      '+91 802038384',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('4CA6A8')))),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                SizedBox(width: 25.w),
                Text(
                  'Industry',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text(
                      'IT',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('4CA6A8')))),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                SizedBox(width: 25.w),
                Text(
                  'Location',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text(
                      'Andheri, Mumbai',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('4CA6A8')))),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
