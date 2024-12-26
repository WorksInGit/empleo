import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var showText = false.obs;
  void toggleText() {
    showText.value = !showText.value;
  }
    Future<void> updateApplicationStatus(String applicationId, int status) async {
  try {
    await _firestore.collection('jobApplications').doc(applicationId).update({
      'status': status,
    });
    Get.snackbar(
      'Success',
      'Application status updated successfully.',
      backgroundColor: Colors.transparent,
      colorText: Colors.black,
    );
  } catch (e) {
    Get.snackbar(
      'Error',
      'Failed to update application status. Please try again.',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
}