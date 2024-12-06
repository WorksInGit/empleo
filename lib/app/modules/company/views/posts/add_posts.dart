import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/company/controllers/add_job_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class AddPosts extends StatelessWidget {
  AddPosts({super.key});

  final AddJobController controller = Get.put(AddJobController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 244, 243, 243),
          body: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 20.w),
                      const Icon(Iconsax.arrow_circle_left4, size: 30),
                      SizedBox(width: 100.w),
                      Text(
                        'Add Job',
                        style: GoogleFonts.poppins(
                            fontSize: 25.sp, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(height: 30.h),
                  _buildLabel('Job Name'),
                  _buildTextField(
                    controller: controller.jobNameController,
                    hintText: 'Enter job name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a job name';
                      }
                      return null;
                    },
                  ),
                  _buildLabel('Qualification'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: controller.qualificationInputController,
                          decoration: InputDecoration(
                              hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, fontSize: 13.sp),
                              hintText: 'Type and press Enter to add',
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('4CA6A8')))),
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty) {
                              controller.addQualification(value.trim());
                              controller.qualificationInputController.clear();
                            }
                          },
                        ),
                        10.verticalSpace,
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            children: controller.qualifications
                                .map((qual) => Chip(
                                      backgroundColor: Colors.white,
                                      label: Text(qual),
                                      deleteIcon: const Icon(Icons.close),
                                      onDeleted: () =>
                                          controller.qualifications.remove(qual),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () {
                      if (controller.qualifications.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30).r,
                          child: Text(
                            'Please add at least one qualification',
                            style: TextStyle(color: Colors.red, fontSize: 12.sp),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  _buildLabel('Salary'),
                  _buildTextField(
                    controller: controller.salaryController,
                    hintText: 'Enter salary',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a salary';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    prefixIcon: Icons.currency_rupee,
                  ),
                  _buildLabel('Timing'),
                  _buildDropdown(
                    value: controller.selectedTiming.value,
                    items: ["Full-time", "Part-time"],
                    onChanged: (value) {
                      controller.selectedTiming.value = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a timing';
                      }
                      return null;
                    },
                  ),
                  _buildLabel('Mode'),
                  _buildDropdown(
                    value: controller.selectedMode.value,
                    items: ["Office", "Remote"],
                    onChanged: (value) {
                      controller.selectedMode.value = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a mode';
                      }
                      return null;
                    },
                  ),
                  _buildLabel('Location'),
                  _buildTextField(
                    controller: controller.locationController,
                    hintText: 'Enter location',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      if (controller.formKey.currentState!.validate() &&
                          controller.qualifications.isNotEmpty) {
                        controller.addJobToFirestore();
                      }
                    },
                    child: Container(
                      width: 150.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: HexColor('4CA6A8'),
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Center(
                        child: Text(
                          'ADD',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 10, top: 10).r,
      child: Row(
        children: [
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    FormFieldValidator<String>? validator,
    IconData? prefixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30).r,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: HexColor('4CA6A8'))
              : null,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor('4CA6A8'))),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?>? onChanged,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30).r,
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('4CA6A8')))),
        validator: validator,
      ),
    );
  }
}