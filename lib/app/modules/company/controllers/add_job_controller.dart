import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddJobController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxString selectedTiming = "Full-time".obs;
  final RxString selectedMode = "Office".obs;

  final TextEditingController qualificationInputController = TextEditingController();
  final TextEditingController jobNameController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController skillInputController = TextEditingController();

  var qualifications = <String>[].obs;
  var skills = <String>[].obs;

  void addQualification(String text) {
    qualifications.add(text);
  }

  void addSkill(String text) {
    skills.add(text);
  }

  void clearAllControllers() {
    jobNameController.clear();
    qualificationInputController.clear();
    salaryController.clear();
    locationController.clear();
    skillInputController.clear();
    qualifications.clear();
    skills.clear();
    selectedTiming.value = "Full-time";
    selectedMode.value = "Office";
  }

  Future<void> addJobToFirestore() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final companyDetails = await fetchCompanyDetails();
      final companyName = companyDetails['companyName'];
      final companyEmail = companyDetails['email'];
      final photoUrl = companyDetails['photoUrl'];
      final about = companyDetails['about'];
      final uid = companyDetails['companyUid'];

      final docRef = FirebaseFirestore.instance.collection('jobs').doc();

      await docRef.set({
        'jobId': docRef.id,
        'companyUid': uid,
        'companyName': companyName,
        'companyEmail': companyEmail,
        'jobName': jobNameController.text.trim(),
        'qualifications': qualifications.toList(),
        'skills': skills.toList(),
        'salary': salaryController.text.trim(),
        'timing': selectedTiming.value,
        'mode': selectedMode.value,
        'location': locationController.text.trim(),
        'photoUrl': photoUrl,
        'about': about,
        'createdAt': FieldValue.serverTimestamp(),
      });

      clearAllControllers();
      Get.snackbar('Success', 'Job added successfully!',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add job: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<Map<String, String>> fetchCompanyDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('companies')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          final data = doc.data();
          return {
            'photoUrl': data?['photoUrl'] ?? '',
            'companyName': data?['companyName'] ?? '',
            'about': data?['about'] ?? '',
            'email': data?['email'] ?? '',
            'companyUid': user.uid
          };
        }
      }
    } catch (e) {
      print('Error fetching company details: $e');
    }
    return {'photoUrl': '', 'companyName': ''};
  }
}
