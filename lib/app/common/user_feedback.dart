import 'package:empleo/app/common/selection_page.dart';
import 'package:empleo/app/modules/company/controllers/emoji_controller.dart';
import 'package:empleo/app/modules/company/views/company_register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class UserFeedback extends StatelessWidget {
  final EmojiController controller = Get.put(EmojiController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Feedback',
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Give Feedback",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 20.h),
                Text(
                  "How was your experience with the app?*",
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildEmojiButton(0, "🥴"),
                    _buildEmojiButton(1, "😐"),
                    _buildEmojiButton(2, "🤩"),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  "What would you like to share with us?*",
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: 10.h),
                Obx(() {
                  return TextField(
                    controller: controller.controller,
                    enabled: controller.selectedEmojiIndex.value != -1,
                    decoration: InputDecoration(
                      hintText: "Enter your feedback here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    maxLines: 3,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiButton(int index, String emoji) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.selectEmoji(index);
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: controller.selectedEmojiIndex == index
                ? HexColor('4CA6A8')
                : Colors.white,
            border: Border.all(
              color: controller.selectedEmojiIndex == index
                  ? Colors.teal
                  : Colors.grey,
            ),
          ),
          padding: EdgeInsets.all(16.w),
          child: Text(
            emoji,
            style: TextStyle(fontSize: 32.sp),
          ),
        ),
      ),
    );
  }
}
