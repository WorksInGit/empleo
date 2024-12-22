import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/company/views/company_bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var obscureText = true.obs;
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

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

    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

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
        int status = companyDoc.get('status') ?? 0;
        if (status == 1) {
          Get.off(
            CompanyNav(),
            transition: Transition.fadeIn,
            duration: Duration(milliseconds: 500),
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
      isLoading.value = false;
    }
  }
}
