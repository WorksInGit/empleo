import 'package:empleo/app/common/selection_page.dart';
import 'package:empleo/app/modules/company/views/posts/add_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class ShortlistedProfile extends StatelessWidget {
  const ShortlistedProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                    width: 20.w,
                  ),
                      Icon(Iconsax.arrow_circle_left4, size: 30.sp,)
                    ],
                  ),
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: AssetImage('assets/images/john.png'),
                  ),
                   Row(
                    children: [
                      25.horizontalSpace,
                      Text(
                        'Name',
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
                            'John',
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
                        'Email',
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
                            'john123@gmail.com',
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
                            'BCA',
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
                        'Experience',
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
                            '3 Years',
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
                            'Kochi, Kerala',
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
                        'Cover Letter',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30).r,
                    child: TextFormField(
                      maxLines: 3,
                      decoration: InputDecoration(
                          label: Text(
                            'I Love Being a part of the creative process and the challanges of making complicated product very simple to use.',
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
                      'CV',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                10.verticalSpace,
                Container(
                  width: 330.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                  border: Border.all(color: HexColor('4CA6A8'))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tab to View', style: GoogleFonts.poppins(),),
                      Icon(Iconsax.document5, color: HexColor('4CA6A8'),)
                    ],
                  ),
                ),
                20.verticalSpace,
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 650, left: 150),
              child: Row(
                children: [
                  IconButton(onPressed: () {
              Get.to(() => AddPoint());
                  }, icon: Icon(Iconsax.shield_tick5, size: 60.sp,)),
                   
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
