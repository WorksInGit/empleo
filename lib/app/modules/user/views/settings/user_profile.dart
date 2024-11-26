import 'package:empleo/app/modules/user/views/settings/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(),));
                    },
                    icon: Icon(
                      Iconsax.edit5, size: 30.sp,) // Adjusted with ScreenUtil
                  ),
                ],
              ),
              SizedBox(height: 30.h), // Adjusted with ScreenUtil
              CircleAvatar(
                radius: 60.r, // Adjusted with ScreenUtil
                backgroundImage: AssetImage('assets/images/john.png'),
              ),
              SizedBox(height: 20.h), // Adjusted with ScreenUtil
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
                  decoration: InputDecoration(
                      label: Text(
                        'John',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')))),
                ),
              ),
              SizedBox(height: 20.h), // Adjusted with ScreenUtil
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
                  decoration: InputDecoration(
                      label: Text(
                        'john123@gmail.com',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')))),
                ),
              ),
              SizedBox(height: 20.h), // Adjusted with ScreenUtil
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
                  decoration: InputDecoration(
                      label: Text(
                        'BCA',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')))),
                ),
              ),
              SizedBox(height: 20.h), // Adjusted with ScreenUtil
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
                  decoration: InputDecoration(
                      label: Text(
                        '3 Years',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')))),
                ),
              ),
              SizedBox(height: 20.h), // Adjusted with ScreenUtil
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
                        border: Border.all(color: HexColor('4CA6A8'))),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 100.w, // Adjusted with ScreenUtil
                                height: 40.h, // Adjusted with ScreenUtil
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15).r),
                                child: Center(
                                    child: Text(
                                  'Ui/Ux Designing',
                                  style: GoogleFonts.poppins(fontSize: 11),
                                )),
                              ),
                              SizedBox(width: 10.w), // Adjusted with ScreenUtil
                              Container(
                                width: 100.w, // Adjusted with ScreenUtil
                                height: 40.h, // Adjusted with ScreenUtil
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15).r),
                                child: Center(
                                    child: Text(
                                  'Ui/Ux Designing',
                                  style: GoogleFonts.poppins(fontSize: 11),
                                )),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 85.w), // Adjusted with ScreenUtil
                          child: Icon(Iconsax.close_square5),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 195.w), // Adjusted with ScreenUtil
                          child: Icon(Iconsax.close_square5),
                        )
                      ],
                    ),
                  )),
              SizedBox(height: 20.h), // Adjusted with ScreenUtil
            ],
          ),
        ),
      ),
    );
  }
}
