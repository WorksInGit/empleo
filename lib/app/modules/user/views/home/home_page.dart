import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/views/home/apply_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current user from FirebaseAuth
    final user = FirebaseAuth.instance.currentUser;
    

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 244, 243, 243),
          body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid) // Use current user's UID
              .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(color: HexColor('4CA6A8'),);
              }
               var userData = snapshot.data!;
                String profileUrl = userData['photoUrl'];
              return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Hello ${userData['name']}',  // Display the user's name
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 20.sp),
                      ),
                      Text('👋'),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 23,
                        backgroundImage: profileUrl.isNotEmpty
                            ? NetworkImage(profileUrl)  // Use the user's photo if available
                            : AssetImage('assets/icons/person.png') as ImageProvider,  // Default icon
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          label: Text(
                            'Search here',
                            style: GoogleFonts.poppins(),
                          ),
                          suffixIcon: Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Recommended For You',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 23.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      TextButton(onPressed: () {}, child: Text('Show All'))
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ApplyPage());
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                              ),
                              Container(
                                width: 300.w,
                                height: 200.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 40.w,
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/icons/google.png'))),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Google',
                                            style: GoogleFonts.poppins(),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Lead Product Manager',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.currency_rupee_sharp,
                                            size: 15.sp,
                                          ),
                                          Text('20000/m'),
                                          5.horizontalSpace,
                                          Text(
                                            'Andheri, Mumbai',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Recent Post',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 23.sp),
                      ),
                      Spacer(),
                      TextButton(onPressed: () {}, child: Text('Show All')),
                      SizedBox(
                        width: 15.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    padding: EdgeInsets.symmetric(horizontal: 20).r,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: 370.w,
                            height: 75.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/icons/facebook.png'))),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15.w,
                                    ),
                                    Text(
                                      'Ui/Ux Designer',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Full Time',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee_sharp,
                                      size: 13,
                                    ),
                                    Text(
                                      '20000/Month',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15.sp),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            );
            },

          ),
        ),
      ),
    );
  }
}
