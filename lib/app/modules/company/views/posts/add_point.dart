import 'package:empleo/app/modules/company/controllers/point_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class AddPoint extends StatelessWidget {
   AddPoint({super.key});
  final PointController controller = Get.put(PointController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 244, 243, 243),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Add Point',
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                width: 100.w,
                height: 80.h,
                decoration: BoxDecoration(
                    border: Border.all(color: HexColor('4CA6A8'))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(controller.point.value),
                        Icon(
                          Iconsax.star1,
                          color: Colors.amber,
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('5'),
                        Icon(Iconsax.star1, color: Colors.amber)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Enter your point',
                style: GoogleFonts.poppins(
                    fontSize: 17.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                  width: 150.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: HexColor('4CA6A8'))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: TextField(
                      onChanged: (value) {
                        controller.point.value = value;
                      },
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  )),
              SizedBox(
                height: 30.h,
              ),
              Container(
                width: 100.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: HexColor('4CA6A8'),
                    borderRadius: BorderRadius.circular(15.r)),
                child: Center(
                  child: Text(
                    'OK',
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
