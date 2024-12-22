import 'package:empleo/app/modules/user/views/home/job_apply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class ApplyPage extends StatelessWidget {
  final Map<String, dynamic> jobDetails;

  const ApplyPage({required this.jobDetails, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 50.h),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                      jobDetails['photoUrl'] ?? 'https://via.placeholder.com/150',
                    ),
                    radius: 50.r,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    jobDetails['jobName'] ?? 'Job Title Unavailable',
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${jobDetails['companyName'] ?? 'Company Unavailable'} -',
                        style: GoogleFonts.poppins(fontSize: 16.sp),
                      ),
                      Icon(Iconsax.location5, size: 18.sp),
                      Text(
                        jobDetails['location'] ?? 'Location Unavailable',
                        style: GoogleFonts.poppins(fontSize: 16.sp),
                      )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.clock5, size: 18.sp),
                      SizedBox(width: 5.w),
                      Text(
                        jobDetails['mode'] ?? 'Mode Unavailable',
                        style: GoogleFonts.poppins(fontSize: 16.sp),
                      ),
                      SizedBox(width: 10.w),
                      Row(
                        children: [
                          Icon(Icons.currency_rupee_sharp, size: 16.sp),
                          Text(
                            '${jobDetails['salary'] ?? '0'}/m',
                            style: GoogleFonts.poppins(fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TabBar(
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: HexColor('4CA6A8'),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      SizedBox(
                        width: 250.w,
                        child: Tab(text: 'Description'),
                      ),
                      SizedBox(
                        width: 250.w,
                        child: Tab(text: 'Company'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
                      child: TabBarView(
                        children: [
                          Description(
                            skills: jobDetails['skills'],
                            description: jobDetails['qualifications'] ??
                                ['No qualifications specified.'],
                          ),
                          AboutCompany(
                            companyInfo: jobDetails['about'] ??
                                'No company details available.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 660.h, left: 115.w),
                child: SizedBox(
                  width: 170.w,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => JobApply(
                            jobDetails: jobDetails,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('4CA6A8'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'Apply Now',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

class AboutCompany extends StatelessWidget {
  final String companyInfo;

  const AboutCompany({required this.companyInfo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'About',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                companyInfo,
                style: GoogleFonts.poppins(fontSize: 15.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  final dynamic description;
  final dynamic skills;

  const Description({required this.description, required this.skills, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(18.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Qualifications',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 10.h),
              description is List
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: description.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\u2022 ',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  description[index],
                                  style: GoogleFonts.poppins(fontSize: 15.sp),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Text(
                      description ?? 'No qualifications specified.',
                      style: GoogleFonts.poppins(fontSize: 16.sp),
                    ),
              SizedBox(height: 20.h),
              Text(
                'Skills',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 10.h),
              skills is List
                  ? SingleChildScrollView(
                    child: Column(
                      children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: skills.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\u2022 ',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        skills[index],
                                        style: GoogleFonts.poppins(fontSize: 15.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                    ),
                  )
                  : Text(
                      skills ?? 'No skills specified.',
                      style: GoogleFonts.poppins(fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 50.h,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
