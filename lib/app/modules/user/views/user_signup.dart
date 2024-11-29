import 'package:empleo/app/modules/user/controllers/about_page_controller.dart';
import 'package:empleo/app/modules/user/controllers/field_controller.dart';
import 'package:empleo/app/modules/user/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class UserSignUp extends StatelessWidget {
  const UserSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutPageController());
    final controller2 = Get.put(FieldController());
    final SignupController signupController = Get.put(SignupController());


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
                  120.verticalSpace,
                  Center(
                    child: Text(
                      'Sign Up',
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
                        'Name',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30).r,
                    child: TextFormField(
                      controller: signupController.nameController,
                      decoration: InputDecoration(
                        label: Text(
                          'Your name',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8'))),
                      ),
                      validator: (value) => controller.validateInput(value!, 'name'),
                    ),
                  ),
                  20.verticalSpace,
                  // Experience
                  Row(
                    children: [
                      25.horizontalSpace,
                      Text(
                        'Email Address',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30).r,
                    child: TextFormField(
                      controller: signupController.emailController,
                      decoration: InputDecoration(
                        label: Text(
                          'Your email address',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8'))),
                      ),
                      validator: (value) =>
                          controller.validateInput(value!, 'email'),
                    ),
                  ),
                  20.verticalSpace,
                  // Skills
                  Row(
                    children: [
                      25.horizontalSpace,
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30).r,
                    child: Obx(
                      () => TextFormField(
                        controller: signupController.passwordController,
                        obscureText: controller2.isObscureText.value,
                        decoration: InputDecoration(
                          label: Text(
                            'Your password',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w200),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller2.toggleVisibility();
                            },
                            icon: Icon(controller2.isObscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor('4CA6A8'))),
                        ),
                        validator: (value) =>
                            controller.validateInput(value!, 'password'),
                      ),
                    ),
                  ),

                 
                  30.verticalSpace,
                  SizedBox(
                      width: 340.w,
                      height: 60.h,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor('4CA6A8')),
                          onPressed: () {
                            controller.submitSignUp();
                          },
                          child: Text(
                            'CONTINUE',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 18.sp,
                            ),
                          ))),
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
