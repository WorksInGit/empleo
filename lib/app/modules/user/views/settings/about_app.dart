import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'About',
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icons/logo.png')),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Empleo",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Divider(thickness: 1),
              SizedBox(height: 20.h),
              Text(
                "What is Empleo?",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Empleo is a modern job board application designed to connect job seekers with companies offering exciting career opportunities. "
                "Our platform streamlines the application process by allowing users to apply for job postings, submit their CVs, and track their application status all in one place.",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              SizedBox(height: 20.h),
              Text(
                "Key Features:",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              BulletPoint(text: "Search for job postings by title."),
              BulletPoint(text: "Easily apply to jobs by filling in your details and uploading your CV."),
              BulletPoint(text: "Track your application progress in the 'Application' section."),
              BulletPoint(text: "Receive notifications after get hired."),
              SizedBox(height: 20.h),
              Text(
                "Our Mission:",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "At Empleo, our mission is to simplify the job search experience, enabling users to find meaningful career opportunities quickly and efficiently while helping companies discover top talent.",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              SizedBox(height: 20.h),
              Text(
                "Contact Us:",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "For any queries, suggestions, or support, feel free to reach out to us at:",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.teal),
                  SizedBox(width: 10.w),
                  Text(
                    "zannank856@gmail.com",
                    style: TextStyle(fontSize: 16.sp, color: Colors.teal),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyle(fontSize: 18.sp, color: Colors.teal),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
