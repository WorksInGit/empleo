import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/company/views/company_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  var companyName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var contactNo = ''.obs;
  var about = ''.obs;
  var industry = 'Select your industry'.obs;
  var location = ''.obs;
  var profileImageUrl = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final List<String> industries = [
    'Technology',
    'Healthcare',
    'Finance',
    'Education',
    'Retail',
    'Manufacturing',
    'Transportation',
  ];

  Future<void> pickProfileImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        File file = File(image.path);
        String fileName =
            'profiles/${email.value}_${DateTime.now().millisecondsSinceEpoch}.jpg';

        UploadTask uploadTask = _storage.ref(fileName).putFile(file);

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        profileImageUrl.value = downloadUrl;

        Get.snackbar(
          'Success',
          'Profile image uploaded successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to upload image: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'No image selected!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void register() async {
    if (companyName.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty ||
        confirmPassword.value.isEmpty ||
        contactNo.value.isEmpty ||
        about.value.isEmpty ||
        industry.value == 'Select your industry' ||
        location.value.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (profileImageUrl.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please upload a profile image.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (password.value != confirmPassword.value) {
      Get.snackbar(
        'Error',
        'Passwords do not match.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      await _firestore
          .collection('companies')
          .doc(userCredential.user!.uid)
          .set({
        'companyName': companyName.value,
        'email': email.value,
        'contactNo': contactNo.value,
        'about': about.value,
        'uid': userCredential.user!.uid,
        'industry': industry.value,
        'location': location.value,
        'photoUrl': profileImageUrl.value,
        'status': 0
      });
      await _firestore.collection('totalCompanies').add({
        'uid': userCredential.user!.uid,
        'createdAt': FieldValue.serverTimestamp()
      });

      Get.defaultDialog(
        title: "Verification in Progress",
        middleText: "You will be contacted through mail for further process.",
        textConfirm: "OK",
        backgroundColor: Colors.white,
        titleStyle: GoogleFonts.poppins(fontSize: 18.sp),
        middleTextStyle: GoogleFonts.poppins(fontSize: 15.sp),
        buttonColor: HexColor('4CA6A8'),
        onConfirm: () {
          Get.offAll(CompanyLogin());
        },
      );
    } catch (e) {
      Get.snackbar(
        'Registration Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
