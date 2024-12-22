import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        body: Column(
          children: [
            15.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Applications',
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            30.h.verticalSpace,
            Row(
              children: [
                20.w.horizontalSpace,
                Text(
                  'Your Applications',
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp, fontWeight: FontWeight.w500),
                )
              ],
            ),
            30.h.verticalSpace,
            TabBar(
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
                        text: 'Applied',
                      )),
                  Container(
                      width: 250.w,
                      child: Tab(
                        text: 'Short Listed',
                      )),
                  Container(
                      width: 250.w,
                      child: Tab(
                        text: 'Hiried',
                      )),
                ]),
            20.h.verticalSpace,
            Expanded(
                child:
                    TabBarView(children: [Applied(), ShortListed(), Hired()]))
          ],
        ),
      ),
    );
  }
}

class Applied extends StatefulWidget {
  const Applied({super.key});

  @override
  State<Applied> createState() => _AppliedState();
}

class _AppliedState extends State<Applied> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('jobApplications')
            .where('userId', isEqualTo: currentUserId)
            .where('status', isEqualTo: 0)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: HexColor('4CA6A8')),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No applications found!',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
            );
          }

          final applications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final application =
                  applications[index].data() as Map<String, dynamic>;
              final companyName = application['companyName'] ?? 'N/A';
              final jobTitle = application['jobName'] ?? 'N/A';
              final location = application['location'] ?? 'N/A';
              final salary = application['salary'] ?? 'N/A';
              final logoUrl =
                  application['companyPhotoUrl'] ?? 'assets/icons/logo.png';

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Container(
                  width: 300.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          20.w.horizontalSpace,
                          Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: logoUrl.startsWith('http')
                                    ? NetworkImage(logoUrl)
                                    : AssetImage(logoUrl) as ImageProvider,
                              ),
                            ),
                          ),
                          20.w.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              20.h.verticalSpace,
                              Text(
                                companyName,
                                style: GoogleFonts.poppins(),
                              ),
                              Text(
                                jobTitle,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                location,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.currency_rupee_sharp,
                            size: 13.sp,
                          ),
                          Text('$salary/Monthly'),
                          20.w.horizontalSpace
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ShortListed extends StatefulWidget {
  const ShortListed({super.key});

  @override
  State<ShortListed> createState() => _ShortListedState();
}

class _ShortListedState extends State<ShortListed> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('jobApplications')
            .where('userId', isEqualTo: currentUserId)
            .where('status', isEqualTo: 1)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: HexColor('4CA6A8')),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No applications found!',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
            );
          }

          final applications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final application =
                  applications[index].data() as Map<String, dynamic>;
              final companyName = application['companyName'] ?? 'N/A';
              final jobTitle = application['jobName'] ?? 'N/A';
              final location = application['location'] ?? 'N/A';
              final salary = application['salary'] ?? 'N/A';
              final logoUrl =
                  application['companyPhotoUrl'] ?? 'assets/icons/logo.png';

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Container(
                  width: 300.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          20.w.horizontalSpace,
                          Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: logoUrl.startsWith('http')
                                    ? NetworkImage(logoUrl)
                                    : AssetImage(logoUrl) as ImageProvider,
                              ),
                            ),
                          ),
                          20.w.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              20.h.verticalSpace,
                              Text(
                                companyName,
                                style: GoogleFonts.poppins(),
                              ),
                              Text(
                                jobTitle,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                location,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.currency_rupee_sharp,
                            size: 13.sp,
                          ),
                          Text('$salary/Monthly'),
                          20.w.horizontalSpace
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Hired extends StatefulWidget {
  const Hired({super.key});

  @override
  State<Hired> createState() => _HiredState();
}

class _HiredState extends State<Hired> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('jobApplications')
            .where('userId', isEqualTo: currentUserId)
            .where('status', isEqualTo: 2)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: HexColor('4CA6A8')),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No hired applications found!',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
            );
          }

          final applications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final application =
                  applications[index].data() as Map<String, dynamic>;
              final companyName = application['companyName'] ?? 'N/A';
              final jobTitle = application['jobName'] ?? 'N/A';
              final location = application['location'] ?? 'N/A';
              final salary = application['salary'] ?? 'N/A';
              final logoUrl =
                  application['companyPhotoUrl'] ?? 'assets/icons/logo.png';
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Container(
                  width: 300.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          20.w.horizontalSpace,
                          Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: logoUrl.startsWith('http')
                                    ? NetworkImage(logoUrl)
                                    : AssetImage(logoUrl) as ImageProvider,
                              ),
                            ),
                          ),
                          20.w.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              20.h.verticalSpace,
                              Text(
                                companyName,
                                style: GoogleFonts.poppins(),
                              ),
                              Text(
                                jobTitle,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                location,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                width: 70.r,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  color: HexColor('4CA6A8'),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Center(
                                  child: Text(
                                    'Hired',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.currency_rupee_sharp,
                            size: 13.sp,
                          ),
                          Text('$salary/Monthly'),
                          20.w.horizontalSpace
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
