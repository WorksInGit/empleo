import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/company/controllers/add_job_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CompanyHome extends StatelessWidget {
  CompanyHome({super.key});

  final AddJobController controller = Get.put(AddJobController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  Widget build(BuildContext context) {
    final String? companyUid = FirebaseAuth.instance.currentUser?.uid;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  const Spacer(),
                  FutureBuilder<Map<String, String>>(
                    future: controller.fetchCompanyDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError ||
                          snapshot.data == null ||
                          snapshot.data!['photoUrl']!.isEmpty) {
                        return const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.person, color: Colors.grey),
                        );
                      } else {
                        final photoUrl = snapshot.data!['photoUrl']!;
                        return CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(photoUrl),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _buildSearchBar(),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<int>(
                    future: _getJobsCount(companyUid!),
                    builder: (context, snapshot) {
                      final count = snapshot.data?.toString() ?? '0';
                      return _buildStatCard(count, 'Job Posts', 'assets/images/vector.png');
                    },
                  ),
                  SizedBox(width: 20.w),
                  FutureBuilder<int>(
                    future: _getApplicationsCount(companyUid),
                    builder: (context, snapshot) {
                      final count = snapshot.data?.toString() ?? '0';
                      return _buildStatCard(count, 'Applications', 'assets/images/vector2.png');
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                "All Posts",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: Obx(() {
                  final query = searchQuery.value.toLowerCase();
                  return StreamBuilder<QuerySnapshot>(
                    stream: _getJobPosts(companyUid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text("No job posts available."));
                      } else {
                        final jobPosts = snapshot.data!.docs
                            .where((doc) {
                              final job = doc.data() as Map<String, dynamic>;
                              final jobName = (job['jobName'] ?? '').toString().toLowerCase();
                              return jobName.contains(query);
                            })
                            .toList();
                        return ListView.builder(
                          itemCount: jobPosts.length,
                          itemBuilder: (context, index) {
                            final job = jobPosts[index].data() as Map<String, dynamic>;
                            return _buildJobPostCard(
                              job['photoUrl'] ?? 'N/A',
                              job['jobName'] ?? 'N/A',
                              job['timing'] ?? 'N/A',
                              job['salary'] ?? 'N/A',
                            );
                          },
                        );
                      }
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> _getJobsCount(String companyUid) async {
    final snapshot = await _firestore
        .collection('jobs')
        .where('companyUid', isEqualTo: companyUid)
        .get();
    return snapshot.docs.length;
  }

  Future<int> _getApplicationsCount(String companyUid) async {
    final snapshot = await _firestore
        .collection('jobApplications')
        .where('companyUid', isEqualTo: companyUid)
        .get();
    return snapshot.docs.length;
  }

  Stream<QuerySnapshot> _getJobPosts(String companyUid) {
    return _firestore
        .collection('jobs')
        .where('companyUid', isEqualTo: companyUid)
        .snapshots();
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,
      onChanged: (value) {
        searchQuery.value = value;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Search here",
        suffixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  Widget _buildStatCard(String count, String label, String assetPath) {
    return Container(
      width: 160.w,
      height: 170.h,
      decoration: BoxDecoration(
        color: HexColor('4CA6A8'),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  count,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp),
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 50),
            child: Row(
              children: [
                SizedBox(width: 8.w),
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(assetPath))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobPostCard(String photoUrl, String title, String type, String salary) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: Colors.transparent,
            backgroundImage: photoUrl.isNotEmpty
                ? NetworkImage(photoUrl)
                : AssetImage('assets/icons/facebook.png') as ImageProvider,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            "\$$salary/Month",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}