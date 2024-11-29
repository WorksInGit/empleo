import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/controllers/field_controller.dart';
import 'package:empleo/app/modules/user/services/auth_service.dart';
import 'package:empleo/app/modules/user/views/about_page.dart';
import 'package:empleo/app/modules/user/views/user_bottom_nav.dart';
import 'package:empleo/app/modules/user/views/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class UserLogin extends StatelessWidget {
  UserLogin({super.key});
  final AuthService authService = AuthService();
  FieldController controller = Get.put(FieldController());

  // Controllers for email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey, // Assign the form key
              child: Column(
                children: [
                  SizedBox(
                    height: 200.h,
                  ),
                  Center(
                    child: Text(
                      'Welcome Back!',
                      style: GoogleFonts.poppins(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text('Fill your Details to continue'),
                  30.verticalSpace,
                  // Email Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: Text('Email Address'),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        // Regular expression for email validation
                        if (!RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Obx(() {
                      return TextFormField(
                        controller: passwordController,
                        obscureText: controller.isObscureText.value,
                        decoration: InputDecoration(
                          label: Text('Password'),
                          prefixIcon: Icon(Icons.lock),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.toggleVisibility();
                            },
                            icon: Icon(controller.isObscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      );
                    }),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  // Login Button
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, perform login action
                        print('Email: ${emailController.text}');
                        print('Password: ${passwordController.text}');
                      } else {
                        // Form validation failed
                        Get.snackbar(
                          'Invalid Input',
                          'Please fix the errors in the form',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: Container(
                      width: 340.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                          color: HexColor('4CA6A8'),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          'LOG IN',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30.w,
                        height: 1.h,
                        color: Colors.black,
                      ),
                      10.horizontalSpace,
                      Text('Or Continue with'),
                      10.horizontalSpace,
                      Container(
                        width: 30.w,
                        height: 1.h,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  // Google Sign-In
                  GestureDetector(
                    onTap: () async {
                      final user = await authService.signInWithGoogle();
                      if (user != null) {
                        final userDoc = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .get();
                        if (userDoc.exists &&
                            userDoc.data() != null &&
                            userDoc.data()!.containsKey('skills')) {
                          Get.off(() => BottomNav());
                        } else {
                          Get.off(() => AboutPage());
                        }
                      } else {
                        Get.snackbar(
                          "Sign-In Failed",
                          "Please try again",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/google.png'))),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => UserSignUp());
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                            color: HexColor('4CA6A8'),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
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