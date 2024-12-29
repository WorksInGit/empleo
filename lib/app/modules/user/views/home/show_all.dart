import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/views/home/apply_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowAllJobs extends StatelessWidget {
  const ShowAllJobs({Key? key, required this.title, required this.jobs})
      : super(key: key);

  final String title;
  final List jobs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            title,
            style: GoogleFonts.poppins(color: Colors.black),
          ),
        ),
        body: jobs.isEmpty
            ? Center(
                child: Text(
                  'No jobs available',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return RecentJobCard(jobData: jobs[index]);
                },
              ),
      ),
    );
  }
}

class RecentJobCard extends StatelessWidget {
  final QueryDocumentSnapshot jobData;

  const RecentJobCard({required this.jobData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          ApplyPage(
            jobDetails: jobData.data() as Map<String, dynamic>,
          ),
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 500),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: Colors.transparent,
                backgroundImage: jobData['photoUrl'].isNotEmpty
                    ? NetworkImage(jobData['photoUrl'])
                    : const AssetImage('assets/icons/facebook.png')
                        as ImageProvider,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jobData['jobName'],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      jobData['mode'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "₹${jobData['salary']}/Month",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
