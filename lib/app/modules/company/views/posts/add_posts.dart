import 'package:empleo/app/modules/company/controllers/add_job_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 244, 243, 243),
            title: const Text('Add Job'),
            centerTitle: true,
            surfaceTintColor: HexColor('4CA6A8'),
          ),
          backgroundColor: const Color.fromARGB(255, 244, 243, 243),
          body: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
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
                  _buildTagInputField(
                    context,
                    'Type and press Enter to add',
                    controller.qualificationInputController,
                    controller.addQualification,
                    controller.qualifications,
                    'Please add at least one qualification',
                  ),
                  _buildLabel('Skills'),
                  _buildTagInputField(
                    context,
                    'Type and press Enter to add',
                    controller.skillInputController,
                    controller.addSkill,
                    controller.skills,
                    'Please add at least one skill',
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
                    onTap: () async {
                      if (controller.formKey.currentState!.validate() &&
                          controller.qualifications.isNotEmpty &&
                          controller.skills.isNotEmpty) {
                        await controller.addJobToFirestore();
                        Get.snackbar('Success', 'Job added successfully!',
                            backgroundColor: Colors.transparent,
                            colorText: Colors.black);

                        Navigator.pop(context);
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

  Widget _buildTagInputField(
    BuildContext context,
    String hintText,
    TextEditingController inputController,
    Function(String) onAdd,
    RxList<String> list,
    String errorMessage,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: inputController,
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('4CA6A8')),
              ),
            ),
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                onAdd(value.trim());
                inputController.clear();
              }
            },
          ),
          10.verticalSpace,
          Obx(
            () => Wrap(
              spacing: 8,
              children: list
                  .map((item) => Chip(
                        backgroundColor: Colors.white,
                        label: Text(item),
                        deleteIcon: const Icon(Icons.close),
                        onDeleted: () => list.remove(item),
                      ))
                  .toList(),
            ),
          ),
          Obx(
            () => list.isEmpty
                ? Text(errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 12.sp))
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
