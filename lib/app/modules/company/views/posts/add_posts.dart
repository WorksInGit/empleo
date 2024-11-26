import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class AddPosts extends StatelessWidget {
  const AddPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        body: SingleChildScrollView(
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
                  Icon(
                    Iconsax.arrow_circle_left4,
                    size: 30,
                  ),
                  SizedBox(
                    width: 100.w,
                  ),
                  Text(
                    'Add Job',
                    style: GoogleFonts.poppins(
                        fontSize: 25.sp, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
               Row(
                children: [
                  25.horizontalSpace,
                  Text(
                    'Job Name',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30).r,
                child: TextFormField(
                  decoration: InputDecoration(
                      
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')))),
                ),
              ),
              20.verticalSpace,
               Row(
                children: [
                  25.horizontalSpace,
                  Text(
                    'Qualification',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30).r,
                child: TextFormField(
          maxLines: 4,
                  decoration: InputDecoration(
                      
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')))),
                ),
              ),
              20.verticalSpace,
               Row(
                children: [
                  25.horizontalSpace,
                  Text(
                    'Salary',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30).r,
                child: TextFormField(
                  decoration: InputDecoration(
                      
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')))),
                ),
              ),
              20.verticalSpace,
               Row(
                children: [
                  25.horizontalSpace,
                  Text(
                    'Timing',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30).r,
                child: TextFormField(
                  decoration: InputDecoration(
                      
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
                      
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')))),
                ),
              ),
              20.verticalSpace,
              Container(
                width: 150.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: HexColor('4CA6A8'),
                  borderRadius: BorderRadius.circular(15.r)
                ),
                child: Center(child: Text('ADD', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),)),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
