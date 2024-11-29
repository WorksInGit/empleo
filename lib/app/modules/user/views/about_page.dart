import 'package:empleo/app/modules/user/controllers/about_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutPageController());

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
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
                  // Qualification
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
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8'))),
                      ),
                      onChanged: (value) =>
                          controller.qualification.value = value,
                      validator: (value) =>
                          controller.validateInput(value!, 'qualification'),
                    ),
                  ),
                  20.verticalSpace,
                  // Experience
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
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8'))),
                      ),
                      onChanged: (value) => controller.experience.value = value,
                      validator: (value) =>
                          controller.validateInput(value!, 'experience'),
                    ),
                  ),
                  20.verticalSpace,
                  // Skills
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
                          'Eg: Flutter, Dart',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8'))),
                      ),
                      onChanged: (value) {
                        controller.skills.value =
                            value.split(',').map((e) => e.trim()).toList();
                      },
                      validator: (value) =>
                          controller.validateInput(value!, 'skills'),
                    ),
                  ),
                  20.verticalSpace,
                  // Location

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Number',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          onChanged: (value) => controller.phone.value = value,
                          validator: (value) =>
                              controller.validateInput(value!, 'phone'),
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.mobile4),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: HexColor('4CA6A8'))),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          'Eg: Trivandrum, Kerala',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8'))),
                      ),
                      onChanged: (value) => controller.location.value = value,
                      validator: (value) =>
                          controller.validateInput(value!, 'location'),
                    ),
                  ),
                  30.verticalSpace,
                  SizedBox(
                  width: 340.w,
                  height: 60.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: HexColor('4CA6A8')),
                    onPressed: () {
                      controller.submitForm();
                    }, child: Text('CONTINUE',   style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18.sp,
                          ),))),
                  SizedBox(
                    height: 30.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
