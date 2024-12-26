import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/company/controllers/add_job_controller.dart';
import 'package:empleo/app/modules/company/controllers/button_controller.dart';
import 'package:empleo/app/modules/company/views/posts/add_posts.dart';
import 'package:empleo/app/modules/company/views/posts/company_applications.dart';
import 'package:empleo/app/modules/company/views/posts/company_shortlisted.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class CompanyPosts extends StatelessWidget {
  CompanyPosts({super.key});
  final controller = Get.find<AddJobController>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
          titleTextStyle: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.h.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TabBar(
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                      color: HexColor('4CA6A8'),
                      borderRadius: BorderRadius.circular(15.r)),
                  labelStyle: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: [
                    Container(
                        width: 250.w,
                        child: Tab(
                          text: 'Your Posts',
                        )),
                    Container(
                        width: 250.w,
                        child: Tab(
                          text: 'Short Listed',
                        )),
                  ]),
            ),
            20.h.verticalSpace,
            Expanded(
              child: TabBarView(
                children: [YourPosts(), ShortListed()],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor('4CA6A8'),
          onPressed: () {
            controller.clearAllControllers();
            Get.to(() => AddPosts());
          },
          child: Icon(
            Iconsax.add5,
            size: 40.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class YourPosts extends StatelessWidget {
  const YourPosts({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonController controller = Get.put(ButtonController());
    final String companyId = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('jobs')
          .where('companyUid', isEqualTo: companyId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error fetching jobs.'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No job posts available.'));
        }

        final jobs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final job = jobs[index];
            return GestureDetector(
              onTap: () {
                Get.to(
                  CompanyApplications(
                    id: job.id,
                  ),
                  transition: Transition.cupertino,
                  duration: Duration(milliseconds: 500),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(job['photoUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job['jobName'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  job['location'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.toggleText();
                            },
                            icon: Obx(
                              () => Icon(
                                controller.showText.value
                                    ? Icons.cancel
                                    : Icons.more_vert,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Obx(
                            () {
                              if (controller.showText.value) {
                                return IconButton(
                                  onPressed: () async {
                                    try {
                                      QuerySnapshot applicationsSnapshot =
                                          await FirebaseFirestore.instance
                                              .collection('jobApplications')
                                              .where('jobId', isEqualTo: job.id)
                                              .get();

                                      for (var application
                                          in applicationsSnapshot.docs) {
                                        await FirebaseFirestore.instance
                                            .collection('jobApplications')
                                            .doc(application.id)
                                            .delete();
                                      }

                                      await FirebaseFirestore.instance
                                          .collection('jobs')
                                          .doc(job.id)
                                          .delete();

                                      Get.snackbar(
                                        'Success',
                                        'Job post deleted successfully.',
                                        backgroundColor: Colors.transparent,
                                        colorText: Colors.black,
                                      );

                                      // Update controller value
                                      controller.showText.value = false;
                                    } catch (e) {
                                      Get.snackbar(
                                        'Error',
                                        'Failed to delete job post: $e',
                                        backgroundColor: Colors.transparent,
                                        colorText: Colors.red,
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${job['salary']} Monthly',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ShortListed extends StatelessWidget {
  const ShortListed({super.key});

  @override
  Widget build(BuildContext context) {
    final String companyId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('jobs')
          .where('companyUid', isEqualTo: companyId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error fetching jobs.'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No job posts available.'));
        }

        final jobs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final job = jobs[index];
            return GestureDetector(
              onTap: () {
                Get.to(
                  CompanyShortlistedApplications(
                    id: job.id,
                  ),
                  transition: Transition.cupertino,
                  duration: Duration(milliseconds: 500),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(job['photoUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job['jobName'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  job['location'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${job['salary']} Monthly',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
