import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/services/auth_service.dart';
import 'package:empleo/app/modules/user/views/about_page.dart';
import 'package:empleo/app/modules/user/views/user_bottom_nav.dart';
import 'package:empleo/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class UserLogin extends StatelessWidget {
  UserLogin({super.key});
  final AuthService authService = AuthService();

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: Text('Email Address'),
                        prefixIcon: Icon(Icons.email),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: Text('Password'),
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        suffixIcon: Icon(Icons.visibility_off)),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .delete();
                      print("User data cleared from Firestore.");
                    }
                    authService.signOut();
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
                GestureDetector(
                  onTap: () async {
                    final user = await authService.signInWithGoogle();

                    if (user != null) {
                      // Get the user's document from Firestore
                      final userDoc = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .get();

                      if (userDoc.exists) {
                        // Check if the 'skills' field exists in the document
                        if (userDoc.data() != null &&
                            userDoc.data()!.containsKey('skills')) {
                          // User has a profile and 'skills' field exists, navigate to BottomNav
                          Get.off(() => BottomNav());
                        } else {
                          // User doesn't have the 'skills' field, navigate to AboutPage
                          Get.off(() => AboutPage());
                        }
                      } else {
                        // If the document doesn't exist, navigate to AboutPage for new users
                        Get.off(() => AboutPage());
                      }
                    } else {
                      // Show error message if sign-in failed
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
                        
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          color:
                              HexColor('4CA6A8'), // Blue color for the button
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
    );
  }
}
