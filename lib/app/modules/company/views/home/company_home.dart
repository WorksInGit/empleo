import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/common/user_feedback.dart';
import 'package:empleo/app/modules/company/controllers/add_job_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CompanyHome extends StatelessWidget {
   CompanyHome({super.key});

 final AddJobController controller = Get.put(AddJobController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  const Spacer(),
                  FutureBuilder<String>(
                    future: controller.fetchCompanyImage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Show a loading spinner while fetching the image
                      } else if (snapshot.hasError || snapshot.data!.isEmpty) {
                        return const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.person, color: Colors.grey),
                        ); // Fallback icon if no image found or an error occurs
                      } else {
                        return CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(snapshot.data!),
                        ); // Show the fetched image
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
                  _buildStatCard('29', 'Job Posts', 'assets/images/vector.png'),
                  SizedBox(width: 20.w),
                  _buildStatCard(
                      '3', 'Applications', 'assets/images/vector2.png'),
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
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return _buildJobPostCard();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
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

  Widget _buildJobPostCard() {
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
            backgroundImage: const AssetImage('assets/icons/facebook.png'),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ui/Ux Designer",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Full Time",
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
            "\$4500/Month",
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