import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  void signUp(BuildContext context) async {
    try { 
      final auth = FirebaseAuth.instance;
      // ignore: unused_local_variable
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
    }
    catch (e) {
      Get.snackbar('Sign-Up Failed', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }


}