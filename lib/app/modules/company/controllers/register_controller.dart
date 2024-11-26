import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var companyName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var contactNo = ''.obs;
  var about = ''.obs;
  var industry = 'Select you industy'.obs;
  var location = ''.obs;
  final List<String> industries = [
    'Technology',
    'Healthcare',
    'Finance',
    'Education',
    'Retail',
    'Manufacturing',
    'Transportation',
  ];
  void register() {
    if (companyName.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty ||
        contactNo.value.isEmpty ||
        location.value.isEmpty) {
      Get.snackbar('Error', 'All fields required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
