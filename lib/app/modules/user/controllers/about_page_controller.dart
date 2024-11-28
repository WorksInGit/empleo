import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/views/user_bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AboutPageController extends GetxController {
  var qualification = ''.obs;
  var experience = ''.obs;
  var skills = ''.obs;
  var location = ''.obs;

  final formKey = GlobalKey<FormState>();

  String? validateInput(String value, String field) {
    if (value.isEmpty) {
      return 'Please enter your $field';
    }
    return null;
  }

  submitForm() async {
    if (formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'qualification': qualification.value,
          'experience': experience.value,
          'skills': skills.value,
          'location': location.value,
        });

        Get.off(() => BottomNav());
      }
    }
  }
}
