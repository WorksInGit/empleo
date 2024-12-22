import 'package:empleo/app/modules/company/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CompanyRegister extends StatelessWidget {
  CompanyRegister({super.key});
  final RegisterController controller = Get.put(RegisterController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Register',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () => controller.pickProfileImage(),
                      child: Obx(
                        () => CircleAvatar(
                          radius: 50.r,
                          backgroundColor: Colors.transparent,
                          backgroundImage: controller
                                  .profileImageUrl.value.isNotEmpty
                              ? NetworkImage(controller.profileImageUrl.value)
                              : null,
                          child: controller.profileImageUrl.value.isEmpty
                              ? Icon(
                                  Icons.camera_alt,
                                  color: HexColor('4CA6A8'),
                                  size: 30.sp,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    label: 'Company Name',
                    hintText: 'Enter your company name',
                    onChanged: (value) => controller.companyName.value = value,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Field required'
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    label: 'Email',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => controller.email.value = value,
                    validator: (value) =>
                        !GetUtils.isEmail(value ?? '') ? 'Invalid email' : null,
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    onChanged: (value) => controller.password.value = value,
                    validator: (value) => value == null || value.length < 6
                        ? 'Min 6 characters'
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    label: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    obscureText: true,
                    onChanged: (value) =>
                        controller.confirmPassword.value = value,
                    validator: (value) => value != controller.password.value
                        ? 'Passwords do not match'
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    label: 'Contact Number',
                    hintText: 'Enter your phone number',
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    onChanged: (value) => controller.contactNo.value = value,
                    validator: (value) => value == null || value.length != 10
                        ? 'Invalid number'
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    label: 'About',
                    hintText: 'Write about your company',
                    maxLines: 3,
                    onChanged: (value) => controller.about.value = value,
                  ),
                  SizedBox(height: 16.h),
                  _buildDropdownField(
                    label: 'Industry',
                    hintText: 'Select your sector',
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    label: 'Location',
                    hintText: 'Eg: Andheri, Mumbai',
                    onChanged: (value) => controller.location.value = value,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Field required'
                        : null,
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('4CA6A8'),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.register();
                        }
                      },
                      child: Text(
                        'REGISTER',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
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
    required String label,
    required String hintText,
    bool obscureText = false,
    int maxLines = 1,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          obscureText: obscureText,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            counterText: '',
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor('4CA6A8'), width: 2.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Obx(
          () => DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            value: controller.industry.value == 'Select your industry'
                ? null
                : controller.industry.value,
            hint: Text(
              hintText,
              style: GoogleFonts.poppins(fontSize: 14.sp),
            ),
            items: controller.industries
                .map((industry) =>
                    DropdownMenuItem(value: industry, child: Text(industry)))
                .toList(),
            onChanged: (value) => controller.industry.value = value!,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('4CA6A8'), width: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
