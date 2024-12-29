import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/controllers/home_controller.dart';
import 'package:empleo/app/modules/user/views/home/apply_page.dart';
import 'package:empleo/app/modules/user/views/home/show_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 244, 243, 243),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Obx(() {
                  var userData = controller.userData.value;
                  var displayName = userData?['name'] ?? 'User';
                  var photoURL = userData?['photoUrl'];
                  return Row(
                    children: [
                      SizedBox(width: 20.w),
                      Text(
                        'Hello ${displayName} 👋',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 20.sp),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 23,
                        backgroundImage: photoURL != null
                            ? NetworkImage(photoURL!)
                            : const AssetImage('assets/icons/person.png')
                                as ImageProvider,
                      ),
                      SizedBox(width: 20.w),
                    ],
                  );
                }),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextField(
                    onChanged: controller.searchJobs,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: BorderSide(
                              color: HexColor('4CA6A8'), width: 0.5)),
                      filled: true,
                      label: Text('Search here',
                          style: GoogleFonts.poppins(color: Colors.black)),
                      suffixIcon: const Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.searchText.isNotEmpty &&
                      controller.searchResults.isEmpty) {
                    return Center(
                      child: Text(
                        'No results found',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }

                  return controller.searchText.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.searchResults.length,
                          itemBuilder: (context, index) {
                            var job = controller.searchResults[index];
                            return RecentJobCard(jobData: job);
                          },
                        )
                      : Column(
                          children: [
                            if (controller.recommendedJobs.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SectionTitle(
                                    title: 'Recommended for You',
                                    onShowAllPressed: () {
                                      Get.to(
                                        () => ShowAllJobs(
                                          title: 'Recommended Jobs',
                                          jobs: controller.recommendedJobs,
                                        ),
                                        transition: Transition.cupertino,
                                        duration:
                                            const Duration(milliseconds: 500),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 200.h,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.recommendedJobs.length,
                                      itemBuilder: (context, index) {
                                        var job =
                                            controller.recommendedJobs[index];
                                        return JobCard(jobData: job);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: 20.h),
                            if (controller.recommendedJobs.isNotEmpty)
                              SectionTitle(
                                title: 'Recent Posts',
                                onShowAllPressed: () {
                                  Get.to(
                                    () => ShowAllJobs(
                                      title: 'Recent Posts',
                                      jobs: controller.recentJobs,
                                    ),
                                    transition: Transition.cupertino,
                                    duration: const Duration(milliseconds: 500),
                                  );
                                },
                              ),
                            if (!controller.recommendedJobs.isNotEmpty)
                              Column(
                                children: [
                                  const Text(
                                      'We all have down times, no jobs to fetch !'),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Icon(
                                    Icons.hourglass_empty,
                                    size: 40.sp,
                                  )
                                ],
                              ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.recentJobs.length,
                              itemBuilder: (context, index) {
                                var job = controller.recentJobs[index];
                                return RecentJobCard(jobData: job);
                              },
                            ),
                          ],
                        );
                }),
              ],
            ),
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
