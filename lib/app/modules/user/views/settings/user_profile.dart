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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: HexColor('4CA6A8'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text('Profile'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => EditProfile(uid: user!.uid));
              },
              icon: Icon(
                Iconsax.edit5,
                size: 30.sp,
              ),
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
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

            var userData = snapshot.data!;
            String name = userData['name'] ?? 'John Doe';
            String email = userData['email'] ?? 'No email provided';
            String qualification = userData['qualification'] ?? 'Not available';
            String experience = userData['experience'] ?? 'No experience';
            List skills = userData['skills'] ?? [];
            String phone = userData['phone'].toString();
            String location = userData['location'] ?? 'No Location Provided';
            String profileUrl = userData['photoUrl'];

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 60.r,
                    backgroundImage: profileUrl.isNotEmpty
                        ? NetworkImage(profileUrl)
                        : (user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : AssetImage('assets/icons/person.png')
                                as ImageProvider),
                    
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 25.w),
                      Text(
                        'Name',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      controller: TextEditingController(text: name),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: null,
                        hintText: name,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 25.w),
                      Text(
                        'Email',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      controller: TextEditingController(text: email),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: null,
                        hintText: email,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 25.w),
                      Text(
                        'Qualification',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      controller: TextEditingController(text: qualification),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: null,
                        hintText: qualification,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 25.w),
                      Text(
                        'Experience',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      controller: TextEditingController(text: experience),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: null,
                        hintText: experience,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 25.w),
                      Text(
                        'Skills',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Container(
                      width: 350.w,
                      height: 60.h,
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
                                width: 80.w,
                                height: 40.h,
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
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 25.w),
                      Text(
                        'Contact Number',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      controller: TextEditingController(text: phone),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: null,
                        hintText: phone,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 25.w),
                      Text(
                        'Location',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      controller: TextEditingController(text: location),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: null,
                        hintText: location,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
