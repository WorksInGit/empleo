import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddJobController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxString selectedTiming = "Full-time".obs; // State for Timing Dropdown
  final RxString selectedMode = "Office".obs;
  final TextEditingController qualificationInputController =
      TextEditingController();
  final TextEditingController jobNameController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  var qualifications = <String>[].obs;

  void addQualification(String text) {
    qualifications.add(text);
  }

  Future<void> addJobToFirestore() async {
    try {
      // Fetch company profile image
      final companyImage = await fetchCompanyImage();

      // Add job details with company image
      await FirebaseFirestore.instance.collection('jobs').add({
        'jobName': jobNameController.text.trim(),
        'qualifications': qualifications.toList(),
        'salary': salaryController.text.trim(),
        'timing': selectedTiming.value,
        'mode': selectedMode.value,
        'location': locationController.text.trim(),
        'photoUrl': companyImage,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Success', 'Job added successfully!',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add job: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<String> fetchCompanyImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch company data from Firestore
        final doc = await FirebaseFirestore.instance
            .collection('companies')
            .doc(user.uid) // Assuming the company's data is stored by user UID
            .get();
        return doc.data()?['photoUrl'] ??
            ''; // 'photoUrl' is the field containing the image URL
      }
    } catch (e) {
      print('Error fetching company image: $e');
    }
    return ''; // Return an empty string if no image is found
  }
}