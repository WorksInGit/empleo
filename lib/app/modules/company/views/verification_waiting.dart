import 'package:empleo/app/modules/company/controllers/approval_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationWaiting extends StatelessWidget {
   VerificationWaiting({super.key});
final ApprovalController controller = Get.put(ApprovalController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
         body: Obx(
          () {
          if (controller.status.value == 0) {
            return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Center(
                child: Image.asset('assets/images/timer.png'),
               ),
               Text('Request under verification', style: GoogleFonts.poppins(fontSize: 25.sp,
               fontWeight: FontWeight.bold
               ),),
                
           
             ],
           );
  } 
      return SizedBox.shrink();
          }
         ),
      ),
    );
  }
}