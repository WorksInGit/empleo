import 'package:empleo/app/common/landing_page.dart';
import 'package:empleo/app/modules/user/views/user_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            70.verticalSpace,
            Center(
              child: Text(
                'Tell About You',
                style: GoogleFonts.poppins(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            70.verticalSpace,
            Row(
              children: [
                25.horizontalSpace,
                Text(
                  'Your Qualification',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30).r,
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text(
                      'Eg: Diploma',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('4CA6A8')))),
              ),
            ),
            20.verticalSpace,
            Row(
              children: [
                25.horizontalSpace,
                Text(
                  'Your Experience',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30).r,
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text(
                      'Eg: 2 Years',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('4CA6A8')))),
              ),
            ),
            20.verticalSpace,
            Row(
              children: [
                25.horizontalSpace,
                Text(
                  'Your Skills',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30).r,
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text(
                      'Eg: 2 Years',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('4CA6A8')))),
              ),
            ),
            20.verticalSpace,
            Row(
              children: [
                25.horizontalSpace,
                Text(
                  'Location',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30).r,
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text(
                      'Eg: Gujarat, India',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('4CA6A8')))),
              ),
            ),
            50.verticalSpace,
              GestureDetector(
                  onTap: (){
               Get.to(() => BottomNav());
                  },
                  child: Container(
                    width: 340.r,
                    height: 60.r,
                    decoration: BoxDecoration(
                        color: HexColor('4CA6A8'),
                        borderRadius: BorderRadius.circular(15).r),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w800,
                            fontSize: 18.sp
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
}
