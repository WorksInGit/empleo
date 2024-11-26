import 'package:empleo/app/common/selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
           SizedBox(
            height: 50.h,
           ),
            Center(
              child: Container(
                width: 350.w,
                height: 300.h,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/images/empleo.png'))),
              ),
            ),
            Text('Find the Perfect',
                style: GoogleFonts.poppins(
                    fontSize: 30.sp, fontWeight: FontWeight.bold)),
         
            SizedBox(
              height: 40.h,
            ),
            Text('Finding your dream job or hiring professionals'),
            Text('is easier and faster with empleo'),
          SizedBox(
            height: 100.h,
          ),
            GestureDetector(
              onTap: () {
                Get.to(() => SelectionPage());
              },
              child: Container(
                width: 300.w,
                height: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: HexColor('4CA6A8')),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Let's Get Started",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
