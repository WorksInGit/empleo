import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/company/views/company_bottom_nav.dart';
import 'package:empleo/app/modules/company/views/home/company_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginPageController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var obscureText = true.obs;
  var isLoading = false.obs; // Loading state

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  // Login method
  void login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and Password are required.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true; // Start loading
    try {
      // Sign in with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      // Fetch company data from Firestore
      DocumentSnapshot companyDoc = await _firestore
          .collection('companies')
          .doc(userCredential.user!.uid)
          .get();

      if (!companyDoc.exists) {
        Get.snackbar(
          'Error',
          'Company not found.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        // Check the `status` field
        int status = companyDoc.get('status') ?? 0;
        if (status == 1) {
          Get.off(
          CompanyNav(),
          transition: Transition.fadeIn, // Specify the transition
          duration:
              Duration(milliseconds: 500), // Optional: set animation duration
        );
        } else {
          Get.snackbar(
            'Error',
            'Your account is not approved yet.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}