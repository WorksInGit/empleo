import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditCompanyProfile extends StatefulWidget {
  const EditCompanyProfile({super.key});

  @override
  State<EditCompanyProfile> createState() => _EditCompanyProfileState();
}

class _EditCompanyProfileState extends State<EditCompanyProfile> {
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      
                     
                      Text(
                        'Edit Profile',
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 60.h,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : AssetImage('assets/icons/google.png')
                            as ImageProvider,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SizedBox(width: 25.w),
                      Text(
                        'Company Name',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                          'Nexus',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
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
                        'Email Address',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                          'nexus@gmail.com',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
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
                        'Contact Number',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                          '+91 88388433',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
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
                        'About',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        label: Text(
                          'Nexus is a multinational company which has its branches all over the world',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
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
                        'Industry',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text('Andheri, Mumbai'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('4CA6A8')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: 200.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: HexColor('4CA6A8'),
                      borderRadius: BorderRadius.circular(15.h),
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
                  onPressed: _pickImage,
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
    );
  }
}
