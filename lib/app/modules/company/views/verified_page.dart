import 'package:empleo/app/common/selection_page.dart';
import 'package:empleo/app/modules/company/views/company_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class VerifiedPage extends StatelessWidget {
  const VerifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
         body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             Center(
              child: Image.asset('assets/images/image4.png'),
             ),
             Text('Verified successfully', style: GoogleFonts.poppins(fontSize: 25.sp,
             fontWeight: FontWeight.bold
             ),),
               SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor('4CA6A8'),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {
                      Get.to(() => CompanyNav());
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
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