import 'package:empleo/app/modules/company/views/company_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../controllers/login_controller.dart';

class CompanyLogin extends StatelessWidget {
  CompanyLogin({super.key});
  final LoginPageController controller = Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 160.h),
                  Center(
                    child: Text(
                      'Welcome Back!',
                      style: GoogleFonts.poppins(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'Fill your Details to continue',
                    style: GoogleFonts.poppins(fontSize: 16.sp),
                  ),
                  SizedBox(height: 30.h),
                  // Email TextField
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) => controller.email.value = value,
                  ),
                  SizedBox(height: 20.h),
                  // Password TextField
                  Obx(
                    () => TextFormField(
                      obscureText: controller.obscureText.value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          onPressed: controller.toggleObscureText,
                          icon: Icon(
                            controller.obscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      onChanged: (value) => controller.password.value = value,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  // Login Button with Loading Spinner
                  SizedBox(
                    width: 340.w,
                    height: 60.h,
                    child: Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor('4CA6A8'),
                        ),
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                                controller.login();
                              },
                        child: controller.isLoading.value
                            ? SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                'LOG IN',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.sp,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(color: Colors.black),
                        ),
                      ),
                      Text('Or'),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Register Button
                  SizedBox(
                    width: 340.w,
                    height: 60.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('4CA6A8'),
                      ),
                      onPressed: () {
                        Get.to(() => CompanyRegister());
                      },
                      child: Text(
                        'REGISTER',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}