import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/services/auth_service.dart';
import 'package:empleo/app/modules/user/views/settings/about_app.dart';
import 'package:empleo/app/modules/user/views/settings/user_faq.dart';
import 'package:empleo/app/common/user_feedback.dart';
import 'package:empleo/app/modules/user/views/settings/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SettingsPage extends StatelessWidget {
   SettingsPage({super.key});
final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 243, 243),
        body: Column(
          children: [
            SizedBox(height: 15.h), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Settings',
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 20.h), 
            Padding(
              padding: EdgeInsets.all(15.w), 
              child: Row(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserProfile(),
                              ));
                        },
                        child: Container(
                          width: 250.w, 
                          height: 50.h, 
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.h)), 
                          child: Row(
                            children: [
                              SizedBox(width: 10.w), 
                              Icon(
                                Iconsax.profile_circle5,
                                size: 40.sp, 
                              ),
                              SizedBox(width: 10.w), 
                              Text(
                                'Profile',
                                style: GoogleFonts.poppins(),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h), 
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserFeedback(),));
                        },
                        child: Container(
                          width: 250.w, 
                          height: 50.h, 
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.h)), 
                          child: Row(
                            children: [
                              SizedBox(width: 10.w), 
                              Icon(
                                Iconsax.activity5,
                                size: 40.sp, 
                              ),
                              SizedBox(width: 10.w), 
                              Text(
                                'Feedback',
                                style: GoogleFonts.poppins(),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h), 
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserFaq(),));
                        },
                        child: Container(
                          width: 250.w, 
                          height: 50.h, 
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.h)), 
                          child: Row(
                            children: [
                              SizedBox(width: 10.w), 
                              Icon(
                                Iconsax.message_question5,
                                size: 40.sp, 
                              ),
                              SizedBox(width: 10.w), 
                              Text(
                                'FAQ',
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h), 
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AboutApp(),));
                        },
                        child: Container(
                          width: 250.w, 
                          height: 50.h, 
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.h)), 
                          child: Row(
                            children: [
                              SizedBox(width: 10.w), 
                              Icon(
                                Iconsax.medal5,
                                size: 40.sp, 
                              ),
                              SizedBox(width: 10.w), 
                              Text(
                                'About',
                                style: GoogleFonts.poppins(),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h), 
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
                          width: 250.w, 
                          height: 50.h, 
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.h)), 
                          child: Row(
                            children: [
                              SizedBox(width: 10.w), 
                              Icon(
                                Iconsax.logout5,
                                size: 40.sp, 
                              ),
                              SizedBox(width: 10.w), 
                              Text(
                                'LogOut',
                                style: GoogleFonts.poppins(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
