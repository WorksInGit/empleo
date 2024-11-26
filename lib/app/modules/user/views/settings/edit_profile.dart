import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;


  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store the picked image in _image
      });
    }
  }

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
            child: Stack(
              children: [
                Column(
                  children: [
                   
                    Row(
                      children: [
                        SizedBox(width: 10.w),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Iconsax.arrow_circle_left,
                            size: 30.sp,
                          ),
                        ),
                        SizedBox(width: 90.w),
                        Text(
                          'Edit Profile',
                          style: GoogleFonts.poppins(
                              fontSize: 20.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
        SizedBox(
          height: 20.h,
        ),
                    CircleAvatar(
                      radius: 60.h, // Changed .r to .h for responsive radius
                      backgroundImage: _image != null
                          ? FileImage(_image!) // Show the picked image
                          : AssetImage('assets/images/john.png') as ImageProvider,
                    ),
                    SizedBox(height: 10.h),
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
                      padding: EdgeInsets.symmetric(horizontal: 30.w), // Changed .r to .w for width
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text(
                            'John',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8')),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
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
                      padding: EdgeInsets.symmetric(horizontal: 30.w), // Changed .r to .w for width
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text(
                            'john123@gmail.com',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8')),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
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
                      padding: EdgeInsets.symmetric(horizontal: 30.w), // Changed .r to .w for width
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text(
                            'BCA',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8')),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
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
                      padding: EdgeInsets.symmetric(horizontal: 30.w), // Changed .r to .w for width
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text(
                            '3 Years',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('4CA6A8')),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
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
                      padding: EdgeInsets.symmetric(horizontal: 30.w), // Changed .r to .w for width
                      child: Container(
                        width: 350.w, // Changed .r to .w for width
                        height: 60.h, // Changed .r to .h for height
                        decoration: BoxDecoration(
                          border: Border.all(color: HexColor('4CA6A8')),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100.w, // Changed .r to .w for width
                                    height: 40.h, // Changed .r to .h for height
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15.h), // Changed .r to .h for radius
                                    ),
                                    child: Center(
                                      child: Text(
                                        'UI/UX Designing',
                                        style: GoogleFonts.poppins(fontSize: 11.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Container(
                                    width: 100.w, // Changed .r to .w for width
                                    height: 40.h, // Changed .r to .h for height
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15.h), // Changed .r to .h for radius
                                    ),
                                    child: Center(
                                      child: Text(
                                        'UI/UX Designing',
                                        style: GoogleFonts.poppins(fontSize: 11.sp),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 85.w),
                              child: Icon(Iconsax.close_square5),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 195.w),
                              child: Icon(Iconsax.close_square5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: 200.w, // Changed .r to .w for width
                      height: 40.h, // Changed .r to .h for height
                      decoration: BoxDecoration(
                        color: HexColor('4CA6A8'),
                        borderRadius: BorderRadius.circular(15.h), // Changed .r to .h for radius
                      ),
                      child: Center(
                        child: Text(
                          'Save',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 210.w, top: 150.h),
                  child: IconButton(
                    onPressed: _pickImage, // Trigger image picking
                    icon: Icon(
                      Iconsax.camera5,
                      color: Colors.black,
                      size: 45.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
