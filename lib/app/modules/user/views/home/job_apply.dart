import 'dart:io';
import 'package:empleo/app/modules/user/controllers/job_apply_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class JobApply extends StatelessWidget {
  final jobDetails;
  JobApply({super.key, this.jobDetails});
  final JobApplyController controller = Get.put(JobApplyController());
  @override
  Widget build(BuildContext context) {
    controller.companyName = jobDetails['companyName'];
    controller.companyPhotoUrl = jobDetails['photoUrl'];
    controller.companyEmail = jobDetails['companyEmail'];
    controller.companyUid = jobDetails['companyUid'];
    controller.jobId = jobDetails['jobId'];
    controller.jobName = jobDetails['jobName'];
    controller.salary = jobDetails['salary'];
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: HexColor('4CA6A8'),
            title: Text('Apply'),
            titleTextStyle: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTextField(
                        controller: controller.firstNameController,
                        hint: 'First Name',
                        width: 150.w,
                      ),
                      _buildTextField(
                        controller: controller.lastNameController,
                        hint: 'Last Name',
                        width: 150.w,
                      ),
                    ],
                  ),
                  40.h.verticalSpace,
                  _buildTextField(
                    controller: controller.emailController,
                    hint: 'Your Email',
                  ),
                  40.h.verticalSpace,
                  _buildStatePicker(context),
                  40.h.verticalSpace,
                  _buildTextField(
                    controller: controller.messageController,
                    hint: 'Message',
                    maxLines: 4,
                  ),
                  40.h.verticalSpace,
                  _buildCVPicker(),
                  30.h.verticalSpace,
                  Center(
                    child: GestureDetector(
                      onTap: controller.submitApplication,
                      child: Container(
                        width: 330.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: HexColor('4CA6A8'),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Center(
                          child: Text(
                            'Apply Now',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    double? width,
    int maxLines = 1,
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor('4CA6A8')),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor('4CA6A8')),
          ),
        ),
      ),
    );
  }

  Widget _buildStatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => _showStateSelectionModal(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: HexColor('4CA6A8')),
          borderRadius: BorderRadius.circular(5.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.selectedState.value.isEmpty
                    ? 'Select your state'
                    : controller.selectedState.value,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: controller.selectedState.value.isEmpty
                      ? Colors.grey
                      : Colors.black,
                ),
              ),
              Icon(Iconsax.arrow_down5, size: 20.sp, color: Colors.black),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCVPicker() {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        width: double.infinity,
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: HexColor('4CA6A8')),
        ),
        child: Center(
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.selectedCV.value.isEmpty
                      ? 'Upload Here'
                      : controller.selectedCV.value,
                  style: GoogleFonts.poppins(fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                Icon(Iconsax.document5, color: HexColor('4CA6A8'), size: 30.sp),
              ],
            );
          }),
        ),
      ),
    );
  }

  void _showStateSelectionModal(BuildContext context) {
    final states = [
      'Andhra Pradesh',
      'Kerala',
      'Tamil Nadu',
      'Delhi',
      'Karnataka',
    ];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 400.h,
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Search state',
                  border: OutlineInputBorder(),
                ),
              ),
              10.h.verticalSpace,
              Expanded(
                child: ListView.builder(
                  itemCount: states.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        states[index],
                        style: GoogleFonts.poppins(fontSize: 14.sp),
                      ),
                      onTap: () {
                        controller.selectedState.value = states[index];
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      controller.selectedCV.value = result.files.single.name;
      controller.selectedCVFile = File(result.files.single.path!);
    }
  }
}
