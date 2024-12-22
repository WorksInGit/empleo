import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/views/home/apply_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userUid = user?.uid;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 244, 243, 243),
          body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userUid)
                .snapshots(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: HexColor('4CA6A8')),
                );
              }

              if (!userSnapshot.hasData || userSnapshot.data == null) {
                return Center(child: Text('User data not found.'));
              }

              var userData = userSnapshot.data!;
              String profileUrl = userData['photoUrl'] ?? '';
              String userSkill;
              if (userData['skills'] is List) {
                userSkill = (userData['skills'] as List).join(', ');
              } else {
                userSkill = userData['skills'] ?? '';
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        SizedBox(width: 20.w),
                        Text(
                          'Hello ${userData['name']} 👋',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 20.sp),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 23,
                          backgroundImage: profileUrl.isNotEmpty
                              ? NetworkImage(profileUrl)
                              : const AssetImage('assets/icons/person.png')
                                  as ImageProvider,
                        ),
                        SizedBox(width: 20.w),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          label:
                              Text('Search here', style: GoogleFonts.poppins()),
                          suffixIcon: const Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SectionTitle(
                      title: 'Recommended For You',
                      onShowAllPressed: () {},
                    ),
                    SizedBox(
                      height: 200.h,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('jobs')
                            .orderBy('createdAt', descending: true)
                            .snapshots(),
                        builder: (context, jobsSnapshot) {
                          if (jobsSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: HexColor('4CA6A8')),
                            );
                          }

                          var jobs = jobsSnapshot.data?.docs ?? [];
                          var recommendedJobs = jobs.where((job) {
                            var jobSkills = job['skills'] is List
                                ? List<String>.from(
                                    (job['skills'] as List).map((e) {
                                      return e.toString();
                                    }),
                                  )
                                : <String>[];
                            return jobSkills.contains(userSkill);
                          }).toList();

                          if (recommendedJobs.isEmpty) {
                            recommendedJobs = jobs.take(3).toList();
                          }

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: recommendedJobs.length,
                            itemBuilder: (context, index) {
                              var job = recommendedJobs[index];
                              return JobCard(jobData: job);
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SectionTitle(
                      title: 'Recent Posts',
                      onShowAllPressed: () {},
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('jobs')
                          .orderBy('createdAt', descending: false)
                          .limit(5)
                          .snapshots(),
                      builder: (context, recentJobsSnapshot) {
                        if (recentJobsSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                color: HexColor('4CA6A8')),
                          );
                        }

                        var recentJobs = recentJobsSnapshot.data?.docs ?? [];
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recentJobs.length,
                          itemBuilder: (context, index) {
                            var job = recentJobs[index];
                            return RecentJobCard(jobData: job);
                          },
                        );
                      },
                    ),
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

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onShowAllPressed;

  const SectionTitle(
      {required this.title, required this.onShowAllPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20.w),
        Text(title,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, fontSize: 23.sp)),
        const Spacer(),
        TextButton(onPressed: onShowAllPressed, child: const Text('Show All')),
        SizedBox(width: 15.w),
      ],
    );
  }
}

class JobCard extends StatelessWidget {
  final QueryDocumentSnapshot jobData;

  const JobCard({required this.jobData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: () {
          Get.to(
            ApplyPage(
              jobDetails: jobData.data() as Map<String, dynamic>,
            ),
            transition: Transition.cupertino,
            duration: const Duration(milliseconds: 500),
          );
        },
        child: Container(
          height: 50,
          width: 300.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(jobData['photoUrl']),
                radius: 20.r,
                backgroundColor: Colors.transparent,
              ),
              Text(
                jobData['companyName'],
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                jobData['jobName'],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Icon(Icons.location_on, size: 15.sp, color: Colors.grey),
                  SizedBox(width: 5.w),
                  Text(
                    jobData['location'],
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Icon(Icons.currency_rupee_sharp, size: 15.sp),
                  Text(
                    '${jobData['salary']}/m',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                ],
              ),
            ],
          ),
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      child: Container(
        width: 370.w,
        height: 65.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(width: 20.w),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(jobData['photoUrl']),
              radius: 20.r,
            ),
            SizedBox(width: 20.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(jobData['jobName'],
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text(jobData['mode'],
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w300)),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Icon(Icons.currency_rupee_sharp, size: 13.sp),
                Text('${jobData['salary']}/m',
                    style: GoogleFonts.poppins(fontSize: 14.sp)),
              ],
            ),
            SizedBox(width: 20.w),
          ],
        ),
      ),
    );
  }
}
