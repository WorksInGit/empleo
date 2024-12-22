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
    final SignupController signupController = Get.put(SignupController());

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: signupController.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  60.verticalSpace,
                  Center(
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  50.verticalSpace,
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
                        labelText: 'Your name',
                        labelStyle:
                            GoogleFonts.poppins(fontWeight: FontWeight.w200),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                      validator: (value) =>
                          signupController.validateInput(value!, 'name'),
                    ),
                  ),
                  20.verticalSpace,
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
                        labelText: 'Your email address',
                        labelStyle:
                            GoogleFonts.poppins(fontWeight: FontWeight.w200),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                      validator: (value) =>
                          signupController.validateInput(value!, 'email'),
                    ),
                  ),
                  20.verticalSpace,
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
                        obscureText: signupController.isObscureText.value,
                        decoration: InputDecoration(
                          labelText: 'Your password',
                          labelStyle:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
                          suffixIcon: IconButton(
                            onPressed: signupController.toggleVisibility,
                            icon: Icon(
                              signupController.isObscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8')),
                          ),
                        ),
                        validator: (value) =>
                            signupController.validateInput(value!, 'password'),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                    children: [
                      25.horizontalSpace,
                      Text(
                        'Confirm Password',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30).r,
                    child: Obx(
                      () => TextFormField(
                        controller: signupController.confirmPassController,
                        obscureText: signupController.isObscureText2.value,
                        decoration: InputDecoration(
                          labelText: 'Confirm password',
                          labelStyle:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
                          suffixIcon: IconButton(
                            onPressed: signupController.toggleVisibilityConfirm,
                            icon: Icon(
                              signupController.isObscureText2.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8')),
                          ),
                        ),
                        validator: (value) => signupController.validateInput(
                            value!, 'confirm password'),
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  SizedBox(
                    width: 340.w,
                    height: 60.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('4CA6A8'),
                      ),
                      onPressed: () {
                        if (signupController.validatePasswords()) {
                          signupController.signUp(context);
                        } else {
                          Get.snackbar(
                            "Failed",
                            "Passwords do not match",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      child: Text(
                        'CONTINUE',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
