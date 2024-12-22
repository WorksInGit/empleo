import 'package:empleo/app/modules/user/controllers/login_controller.dart';
import 'package:empleo/app/modules/user/services/auth_service.dart';
import 'package:empleo/app/modules/user/views/user_bottom_nav.dart';
import 'package:empleo/app/modules/user/views/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class UserLogin extends StatelessWidget {
  UserLogin({super.key});

  final AuthService authService = Get.put(AuthService());
  final LoginController loginController = Get.put(LoginController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 200.h),
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
                  SizedBox(height: 30.h),
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
                        if (!RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text('Password'),
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
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
                    ),
                  ),
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        loginController.isLoading.value = true;
                        final user =
                            await loginController.loginWithEmailAndPassword(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        loginController.isLoading.value = false;
                        if (user != null) {
                          Get.off(
                            BottomNav(),
                            transition: Transition.cupertino,
                            duration: Duration(milliseconds: 500),
                          );
                        }
                      }
                    },
                    child: Obx(() {
                      return Container(
                        width: 340.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: loginController.isLoading.value
                              ? Colors.grey
                              : HexColor('4CA6A8'),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: loginController.isLoading.value
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'LOG IN',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18.sp,
                                  ),
                                ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30.w,
                        height: 1.h,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10.w),
                      Text('Or Continue with'),
                      SizedBox(width: 10.w),
                      Container(
                        width: 30.w,
                        height: 1.h,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      final user = await authService.signInWithGoogle();
                      if (user != null) {
                        Get.to(
                          () => BottomNav(),
                          transition: Transition.cupertino,
                          duration: Duration(milliseconds: 500),
                        );
                      } else {
                        Get.snackbar(
                          'Error',
                          'Google Sign-In failed',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/google.png'),
                        ),
                      ),
                    ),
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
                          Get.to(() => UserSignUp())!.then((_) {
                            emailController.clear();
                            passwordController.clear();
                          });
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
