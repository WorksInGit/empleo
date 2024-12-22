import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:empleo/app/modules/company/controllers/button_controller.dart';
import 'package:empleo/app/modules/company/views/posts/add_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShortlistedProfile extends StatelessWidget {
  ShortlistedProfile({super.key, this.applicantId});
  final String? applicantId;
  final ButtonController controller = Get.put(ButtonController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('jobApplications')
                    .doc(applicantId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: HexColor('4CA6A8'),
                    ));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Center(child: Text('No Profile data found.'));
                  }
                  var data = snapshot.data;
                  return Column(
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      CircleAvatar(
                        radius: 60.r,
                        backgroundImage: data?['photoUrl'] != null
                            ? NetworkImage(data?['photoUrl'])
                            : const AssetImage('assets/images/john.png'),
                      ),
                      Row(
                        children: [
                          25.horizontalSpace,
                          Text(
                            'Name',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30).r,
                        child: TextFormField(
                          decoration: InputDecoration(
                              label: Text(
                                data?['firstName'],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w200),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('4CA6A8')))),
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          25.horizontalSpace,
                          Text(
                            'Email',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30).r,
                        child: TextFormField(
                          decoration: InputDecoration(
                              label: Text(
                                data?['email'],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w200),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('4CA6A8')))),
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          25.horizontalSpace,
                          Text(
                            'Your Qualification',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30).r,
                        child: TextFormField(
                          decoration: InputDecoration(
                              label: Text(
                                data?['qualification'],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w200),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('4CA6A8')))),
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          25.horizontalSpace,
                          Text(
                            'Experience',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30).r,
                        child: TextFormField(
                          decoration: InputDecoration(
                              label: Text(
                                data?['experience'],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w200),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('4CA6A8')))),
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          25.horizontalSpace,
                          Text(
                            'Location',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30).r,
                        child: TextFormField(
                          decoration: InputDecoration(
                              label: Text(
                                data?['location'],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w200),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('4CA6A8')))),
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          25.horizontalSpace,
                          Text(
                            'Cover Letter',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30).r,
                        child: TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                              label: Text(
                                data?['message'],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w200),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('4CA6A8')))),
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          25.horizontalSpace,
                          Text(
                            'CV',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      Container(
                        width: 330.w,
                        height: 120.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: HexColor('4CA6A8')),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tap to View CV',
                              style: GoogleFonts.poppins(),
                            ),
                            IconButton(
                              icon: Icon(Iconsax.document5,
                                  color: HexColor('4CA6A8')),
                              onPressed: () {
                                if (data?['cvUrl'] != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CVViewer(
                                        pdfUrl: data?['cvUrl'],
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('No CV available'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (data?['cvUrl'] != null) {
                            final url = data?['cvUrl'];
                            try {
                              Directory? downloadDirectory =
                                  Directory('/storage/emulated/0/Download');
                              if (!await downloadDirectory.exists()) {
                                await downloadDirectory.create(recursive: true);
                              }
                              int counter = 1;
                              String filePath =
                                  '${downloadDirectory.path}/${data?['firstName']}_CV.pdf';
                              while (await File(filePath).exists()) {
                                filePath =
                                    '${downloadDirectory.path}/${data?['firstName']}_CV_$counter.pdf';
                                counter++;
                              }

                              Dio dio = Dio();
                              await dio.download(url, filePath,
                                  onReceiveProgress: (received, total) {
                                if (total != -1) {
                                  double progress = (received / total) * 100;
                                  if (progress % 5 == 0) {
                                    Get.snackbar(
                                      'Downloading...',
                                      'Progress: ${(progress).toStringAsFixed(2)}%',
                                      backgroundColor: Colors.transparent,
                                      colorText: Colors.black,
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                }
                              });
                              Get.snackbar(
                                'Success',
                                'CV Downloaded Successfully.',
                                backgroundColor: Colors.transparent,
                                colorText: Colors.black,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } catch (e) {
                              Get.snackbar(
                                'Failed',
                                'Error downloading CV: $e',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              print('Error: $e');
                            }
                          } else {
                            Get.snackbar(
                              'Failed',
                              'No CV available to download',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        icon: Icon(Icons.download, color: Colors.white),
                        label: Text(
                          'Download CV',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor('4CA6A8'),
                        ),
                      ),
                      100.verticalSpace,
                    ],
                  );
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 640.h, left: 150.w),
                child: IconButton(
                  onPressed: () {
                    Get.to(
                      AddPoint(
                        applicationId: applicantId!,
                      ),
                      transition: Transition.cupertino,
                      duration: Duration(milliseconds: 500),
                    );
                  },
                  icon: Icon(
                    Iconsax.add_circle5,
                    size: 80.sp,
                    color: HexColor('4CA6A8'),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class CVViewer extends StatelessWidget {
  const CVViewer({super.key, required this.pdfUrl});
  final String pdfUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('CV', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: HexColor('4CA6A8'),
      ),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
