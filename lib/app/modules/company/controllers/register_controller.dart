import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/company/views/verification_waiting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterController extends GetxController {
  var companyName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var contactNo = ''.obs;
  var about = ''.obs;
  var industry = 'Select your industry'.obs;
  var location = ''.obs;
  var profileImageUrl = ''.obs; // To store uploaded profile image URL

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

  // Method to pick a profile image
  Future<void> pickProfileImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        File file = File(image.path);
        String fileName = 'profiles/${email.value}_${DateTime.now().millisecondsSinceEpoch}.jpg';

        // Upload the image to Firebase Storage
        UploadTask uploadTask = _storage.ref(fileName).putFile(file);

        // Wait for upload completion and get the download URL
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

  // Register method with profile image upload check
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
      // Create user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      // Save company data to Firestore
      await _firestore.collection('companies').doc(userCredential.user!.uid).set({
        'companyName': companyName.value,
        'email': email.value,
        'contactNo': contactNo.value,
        'about': about.value,
        'industry': industry.value,
        'location': location.value,
        'photoUrl': profileImageUrl.value, // Save profile image URL
        'status': 0
      });

      // Navigate to the VerificationTimer page
      Get.to(() => VerificationWaiting());
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