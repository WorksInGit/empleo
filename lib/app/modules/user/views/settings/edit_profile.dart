import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/controllers/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';


class EditProfile extends StatelessWidget {
  final String uid; // Pass UID of the current user
  EditProfile({Key? key, required this.uid}) : super(key: key);

  final controller = Get.put(EditProfileController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: HexColor('4CA6A8'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Edit Profile',
            style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: HexColor('4CA6A8'),));
            }

            if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('Failed to load profile data'));
            }

            final userData = snapshot.data!;
            controller.nameController.text = userData['name'] ?? '';
            controller.emailController.text = userData['email'] ?? '';
            controller.qualificationController.text = userData['qualification'] ?? '';
            controller.experienceController.text = userData['experience'] ?? '';
            controller.skillsController.text = (userData['skills'] as List).join(', ');
            controller.phoneController.text = userData['phone'].toString();
            controller.locationController.text = userData['location'] ?? '';
            controller.profileImageUrl.value = userData['photoUrl'] ?? ''; 

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              return CircleAvatar(
                                radius: 60.r, // Adjusted with ScreenUtil
                                backgroundImage: controller.profileImageUrl.value.isNotEmpty
                                    ? NetworkImage(controller.profileImageUrl.value)
                                    : AssetImage('assets/icons/person.png') as ImageProvider,
                                child: controller.isUploading.value
                                    ? CircularProgressIndicator(color: HexColor('4CA6A8'),) // Show progress indicator if uploading
                                    : null,
                              );
                            }),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 195.w, top: 80.h),
                          child: IconButton(
                            onPressed: () {
                              controller.pickImage(); // Pick image when icon is pressed
                            },
                            icon: Icon(Iconsax.edit5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    buildLabel('Name'),
                    buildTextField(controller.nameController, 'Enter your name'),
                    SizedBox(height: 20.h),
                    buildLabel('Email'),
                    buildTextField(controller.emailController, 'Enter your email'),
                    SizedBox(height: 20.h),
                    buildLabel('Qualification'),
                    buildTextField(controller.qualificationController, 'Enter your qualification'),
                    SizedBox(height: 20.h),
                    buildLabel('Experience'),
                    buildTextField(controller.experienceController, 'Enter your experience'),
                    SizedBox(height: 20.h),
                    buildLabel('Skills'),
                    buildTextField(controller.skillsController, 'Enter skills (comma-separated)'),
                    SizedBox(height: 20.h),
                    
                  // Location

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Number',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: controller.phoneController,
                        onChanged: (value) => controller.phoneController.text = value,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.mobile4),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor('4CA6A8'))),
                        ),
                      ),
                    ],
                  ),
                  buildLabel('Location'),
                  buildTextField(controller.locationController, 'Enter your location'),
                  SizedBox(height: 30.h),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor('4CA6A8'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.h),
                        ),
                        onPressed: () {
                          controller.updateProfile(uid); // Update profile with new data
                        },
                        child: Text(
                          'Save Changes',
                          style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor('4CA6A8')),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor('4CA6A8'), width: 2.w),
        ),
      ),
    );
  }
}