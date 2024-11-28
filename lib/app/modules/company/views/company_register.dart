import 'package:empleo/app/modules/company/controllers/register_controller.dart';
import 'package:empleo/app/modules/company/views/verification_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class CompanyRegister extends StatelessWidget {
   CompanyRegister({super.key});
  final RegisterController controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusScope.of(context).unfocus();
      },
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  label: 'Company Name',
                  hintText: 'Enter your company name',
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  label: 'Password',
                  hintText: 'Enter your password',
                  obscureText: true,
                ),
                SizedBox(height: 16.h),
                Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Number',
            style: TextStyle(

              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
        TextField(
        obscureText: false,
      keyboardType: TextInputType.phone,
      maxLength: 10,
        decoration: InputDecoration(
          
      hintText: 'Phone Number',
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red, // Change this to your desired color
          width: 2.0, // You can also change the width of the border
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue, // Color when the TextField is focused
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: HexColor('4CA6A8'), // Color when the TextField is enabled but not focused
          width: 2.0,
        ),
      ),
      prefixIcon: Icon(Iconsax.mobile4),
        ),
      ),
      
        ],
      ),
                SizedBox(height: 16.h),
                _buildTextField(
                  label: 'About',
                  hintText: 'Write about your company',
                  maxLines: 3,
                ),
                SizedBox(height: 16.h),
                _buildDropdownField(
                  label: 'Industry',
                  hintText: 'Select your sector',
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  label: 'Location',
                  hintText: 'Eg: Texas, America',
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
                      Get.to(() => VerificationTimer());
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
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    bool obscureText = false,
    Widget? prefixIcon,
    int maxLines = 1,
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
      TextField(
  obscureText: obscureText,
  maxLines: maxLines,
  decoration: InputDecoration(
    hintText: hintText,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red, // Change this to your desired color
        width: 2.0, // You can also change the width of the border
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue, // Color when the TextField is focused
        width: 2.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: HexColor('4CA6A8'), // Color when the TextField is enabled but not focused
        width: 2.0,
      ),
    ),
    prefixIcon: prefixIcon,
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Obx(
                () =>  Text(
                  controller.industry.value,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: 'IT',
                  child: Text('IT', style: TextStyle(fontSize: 14.sp)),
                ),
                DropdownMenuItem(
                  value: 'Healthcare',
                  child: Text('Healthcare', style: TextStyle(fontSize: 14.sp)),
                ),
                DropdownMenuItem(
                  value: 'Finance',
                  child: Text('Finance', style: TextStyle(fontSize: 14.sp)),
                ),
                DropdownMenuItem(
                  value: 'Education',
                  child: Text('Education', style: TextStyle(fontSize: 14.sp)),
                ),
              ],
              onChanged: (value) {
               controller.industry.value = value!;
              },
            ),
          ),
        ),
      ],
    );
  }
}
