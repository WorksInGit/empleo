import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/views/user_bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobApplyController extends GetxController {
  var companyUid;
  var companyPhotoUrl;
  var jobId;
  var companyName;
  var companyEmail;
  var jobName;
  var salary;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  var selectedState = ''.obs;
  var selectedCV = ''.obs;
  File? selectedCVFile;
  final firestore = FirebaseFirestore.instance;

  Future<void> submitApplication() async {
    if (validateForm()) {
      try {
        final userDetails = await fetchUserDetails();
        final userId = userDetails['userId'];
        final userEmail = userDetails['email'];
        final photoUrl = userDetails['photoUrl'];
        final location = userDetails['location'];
        final qualification = userDetails['qualification'];
        final experience = userDetails['experience'];

        String cvUrl = await uploadCVToFirebase();

        await firestore.collection('jobApplications').add({
          'userId': userId,
          'companyPhotoUrl': companyPhotoUrl,
          'salary': salary,
          'jobName': jobName,
          'jobId': jobId,
          'companyUid': companyUid,
          'userEmail': userEmail,
          'photoUrl': photoUrl,
          'location': location,
          'qualification': qualification,
          'experience': experience,
          'companyName': companyName,
          'companyEmail': companyEmail,
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
          'state': selectedState.value,
          'message': messageController.text,
          'cvUrl': cvUrl,
          'timestamp': Timestamp.now(),
          'points': 0,
          'status': 0
        });

        Get.snackbar(
          'Success',
          'Your application has been submitted successfully.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.to(() => BottomNav());
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to submit your application. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<String> uploadCVToFirebase() async {
    if (selectedCVFile == null) {
      throw 'No CV file selected';
    }

    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          'cvs/${DateTime.now().millisecondsSinceEpoch}_${selectedCVFile!.path.split('/').last}');

      final uploadTask = storageRef.putFile(selectedCVFile!);

      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw 'Error uploading CV: $e';
    }
  }

  bool validateForm() {
    if (firstNameController.text.isEmpty) {
      showError('Please enter your first name');
      return false;
    }
    if (lastNameController.text.isEmpty) {
      showError('Please enter your last name');
      return false;
    }
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      showError('Please enter a valid email');
      return false;
    }
    if (selectedState.value.isEmpty) {
      showError('Please select your state');
      return false;
    }
    if (selectedCV.value.isEmpty) {
      showError('Please upload your CV');
      return false;
    }
    return true;
  }

  void showError(String message) {
    Get.snackbar(
      'Validation Error',
      message,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  Future<Map<String, String>> fetchUserDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          final data = doc.data();
          return {
            'userId': data?['uid'] ?? '',
            'photoUrl': data?['photoUrl'] ?? '',
            'name': data?['name'] ?? '',
            'location': data?['location'] ?? '',
            'qualification': data?['qualification'] ?? '',
            'email': data?['email'] ?? '',
            'experience': data?['experience'] ?? ''
          };
        }
      }
    } catch (e) {
      print('Error fetching company details: $e');
    }
    return {'photoUrl': '', 'companyName': ''};
  }
}
