import 'package:empleo/app/modules/company/views/company_login.dart';
import 'package:empleo/app/modules/user/views/user_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: 400.w,
              height: 420.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/image1.png'), fit: BoxFit.cover)),
            ),
            80.verticalSpace,
            GestureDetector(
              onTap: (){
                Get.to(() => UserLogin());
              },
              child: Container(
                width: 330.w,
                height: 100.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15).r,
                    color: HexColor('4CA6A8')),
                child: Row(
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/image2.png'))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'JOB SEEKERS',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Finding a job here never',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'been easier than before',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
            height: 30.h,
          ),
            GestureDetector(
              onTap: () {
                Get.to(() => CompanyLogin());
              },
              child: Container(
                width: 330.w,
                height: 100.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: HexColor('4CA6A8')),
                child: Row(
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/image3.png'))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'COMPANY',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Let's recruit your great",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'candidate faster here',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
