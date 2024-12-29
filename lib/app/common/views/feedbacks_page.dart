import 'package:empleo/app/common/controllers/feedback_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class FeedbacksPage extends StatelessWidget {
  final FeedbackController feedbackController = Get.put(FeedbackController());
  final TextEditingController feedbackControllerText = TextEditingController();

  var selectedEmoji = ''.obs;
  var selectedEmojiIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Feedback',
              style: GoogleFonts.poppins(),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
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
                      _buildEmojiButton(0, "🥴", 0),
                      _buildEmojiButton(1, "😐", 1),
                      _buildEmojiButton(2, "🤩", 2),
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
                      controller: feedbackControllerText,
                      enabled: selectedEmoji.value.isNotEmpty,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: BorderSide(
                                color: HexColor('4CA6A8'), width: 0.5.w)),
                        hintText: "Enter your feedback here...",
                        focusColor: HexColor('4CA6A8'),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(8.0.r),
                        ),
                      ),
                      maxLines: 3,
                    );
                  }),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor('4CA6A8'),
                        ),
                        onPressed: () {
                          feedbackController.submitFeedback(
                              selectedEmojiIndex.value,
                              selectedEmoji.value,
                              feedbackControllerText.text);
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiButton(int index, String emoji, int emojiIndex) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          selectedEmoji.value = emoji;
          selectedEmojiIndex.value = emojiIndex;
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedEmoji.value == emoji
                ? HexColor('4CA6A8')
                : Colors.white,
            border: Border.all(
              width: 2,
              color: selectedEmoji.value == emoji
                  ? HexColor('4CA6A8')
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
