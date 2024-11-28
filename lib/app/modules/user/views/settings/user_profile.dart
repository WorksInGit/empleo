import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/views/settings/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class UserProfile extends StatefulWidget {
   UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final user = FirebaseAuth.instance.currentUser;
   // Get the current user

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid) // Use current user's UID
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text('No profile data available'));
            }

            // Get the user data
            var userData = snapshot.data!;
            String name = userData['name'] ?? 'John Doe';
            String email = userData['email'] ?? 'No email provided';
            String qualification = userData['qualification'] ?? 'Not available';
            String experience = userData['experience'] ?? 'No experience';
            List skills = userData['skills'] ?? [];
            String profileUrl = userData['photoUrl'];

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.h), // Adjusted with ScreenUtil
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Iconsax.arrow_circle_left,
                          size: 30.sp, // Adjusted with ScreenUtil
                        ),
                      ),
                      SizedBox(width: 30.w), // Adjusted with ScreenUtil
                      Text(
                        'Profile',
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 30.w), // Adjusted with ScreenUtil
                      IconButton(
                        onPressed: () {
                          Get.to(() => EditProfile(uid: user!.uid));
                        },
                        icon: Icon(
                          Iconsax.edit5,
                          size: 30.sp,
                        ), // Adjusted with ScreenUtil
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h), // Adjusted with ScreenUtil
             CircleAvatar(
  radius: 60.r, // Adjusted with ScreenUtil
  backgroundImage: profileUrl.isNotEmpty
      ? NetworkImage(profileUrl)
      : (user?.photoURL != null
          ? NetworkImage(user!.photoURL!)
          : AssetImage('assets/images/john.png') as ImageProvider),
  child: profileUrl.isEmpty
      ? CircularProgressIndicator() // Show loading spinner while image is uploading
      : SizedBox.shrink(), // Hide spinner once image is loaded
),
                  SizedBox(height: 20.h), // Adjusted with ScreenUtil
                  // Name Section
                  Row(
                    children: [
                      SizedBox(width: 25.w), // Adjusted with ScreenUtil
                      Text(
                        'Name',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h), // Adjusted with ScreenUtil
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w), // Adjusted with ScreenUtil
                    child: TextFormField(
                      controller: TextEditingController(text: name),
                      enabled: false, // Make read-only
                      decoration: InputDecoration(
                        labelText: null, // No label
                        hintText: name, // Placeholder as hint
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h), // Adjusted with ScreenUtil
                  // Email Section
                  Row(
                    children: [
                      SizedBox(width: 25.w), // Adjusted with ScreenUtil
                      Text(
                        'Email',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h), // Adjusted with ScreenUtil
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w), // Adjusted with ScreenUtil
                    child: TextFormField(
                      controller: TextEditingController(text: email),
                      enabled: false, // Make read-only
                      decoration: InputDecoration(
                        labelText: null, // No label
                        hintText: email, // Placeholder as hint
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h), // Adjusted with ScreenUtil
                  // Qualification Section
                  Row(
                    children: [
                      SizedBox(width: 25.w), // Adjusted with ScreenUtil
                      Text(
                        'Qualification',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h), // Adjusted with ScreenUtil
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w), // Adjusted with ScreenUtil
                    child: TextFormField(
                      controller: TextEditingController(text: qualification),
                      enabled: false, // Make read-only
                      decoration: InputDecoration(
                        labelText: null, // No label
                        hintText: qualification, // Placeholder as hint
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h), // Adjusted with ScreenUtil
                  // Experience Section
                  Row(
                    children: [
                      SizedBox(width: 25.w), // Adjusted with ScreenUtil
                      Text(
                        'Experience',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h), // Adjusted with ScreenUtil
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w), // Adjusted with ScreenUtil
                    child: TextFormField(
                      controller: TextEditingController(text: experience),
                      enabled: false, // Make read-only
                      decoration: InputDecoration(
                        labelText: null, // No label
                        hintText: experience, // Placeholder as hint
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h), // Adjusted with ScreenUtil
                  // Skills Section
                  Row(
                    children: [
                      SizedBox(width: 25.w), // Adjusted with ScreenUtil
                      Text(
                        'Skills',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h), // Adjusted with ScreenUtil
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w), // Adjusted with ScreenUtil
                    child: Container(
                      width: 350.w, // Adjusted with ScreenUtil
                      height: 60.h, // Adjusted with ScreenUtil
                      decoration: BoxDecoration(
                        border: Border.all(color: HexColor('4CA6A8')),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: skills.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                              ),
                              Container(
                                width: 80.w, // Adjusted with ScreenUtil
                                height: 40.h, // Adjusted with ScreenUtil
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15).r,
                                ),
                                child: Center(
                                    child: Text(
                                  skills[index],
                                  style: GoogleFonts.poppins(fontSize: 11),
                                )),
                              ),
                              SizedBox(
                                width: 10.w,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h), // Adjusted with ScreenUtil
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
