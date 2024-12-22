import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/company/views/posts/applicant_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CompanyApplications extends StatelessWidget {
  CompanyApplications({super.key, this.id});
  final String companyId = FirebaseAuth.instance.currentUser!.uid;
  final String? id;
  String? companyName;
  String? companyEmail;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        body: StreamBuilder<DocumentSnapshot>(
          stream:
              FirebaseFirestore.instance.collection('jobs').doc(id).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: HexColor('4CA6A8'),
              ));
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error fetching jobs.'));
            }

            if (!snapshot.hasData) {
              return Center(child: Text('No job posts available.'));
            }
            print(id);
            final jobs = snapshot.data!;
            String? photoUrl = jobs['photoUrl'];
            companyName = jobs['companyName'];
            companyEmail = jobs['companyEmail'];
            return Padding(
              padding: EdgeInsets.only(top: 110.h, left: 20.w, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.transparent,
                      backgroundImage: photoUrl != null
                          ? NetworkImage(photoUrl)
                          : AssetImage('assets/icons/logo.png'),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    jobs['jobName'],
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 18),
                          SizedBox(width: 6.w),
                          Text(
                            jobs['timing'],
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.w),
                      Row(
                        children: [
                          Text(
                            "\₹${jobs['salary']}/m",
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Applications",
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('jobApplications')
                          .where('companyUid', isEqualTo: companyId)
                          .where('jobId', isEqualTo: id)
                          .where('status', isEqualTo: 0)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No applications found.'));
                        }
                        final applications = snapshot.data!.docs;

                        return ListView.builder(
                          itemCount: applications.length,
                          itemBuilder: (context, index) {
                            final application = applications[index];
                            final applicantName =
                                application['firstName'] ?? 'Unknown';
                            final qualification =
                                application['qualification'] ?? 'N/A';
                            final location =
                                application['location'] ?? 'Unknown';
                            final photoUrl = application['photoUrl'] ??
                                'assets/images/default_user.png';
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  ApplicantProfile(
                                    applicantId: application.id,
                                  ),
                                  transition: Transition.cupertino,
                                  duration: Duration(milliseconds: 500),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40.r,
                                        height: 40.r,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: photoUrl.startsWith('http')
                                                ? NetworkImage(photoUrl)
                                                : AssetImage(photoUrl)
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              applicantName,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              qualification,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        location,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
