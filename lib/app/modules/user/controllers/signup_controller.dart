import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/views/about_page.dart';
import 'package:empleo/app/modules/user/views/user_bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text Controllers for Signup Page
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();
  var qualificationController = TextEditingController();
  var experienceController = TextEditingController();


  // Obscure Text Observables for Password Fields
  var isObscureText = true.obs;
  var isObscureText2 = true.obs;

  // Form Key for Validation
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  // Observable variables for About Page
  var location = ''.obs;
  var qualification = ''.obs;
  var experience = ''.obs;
  var phone = ''.obs;
  var skills = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    clearAllControllers();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    qualificationController.dispose();
    experienceController.dispose();
    super.onClose();
  }

  // Clear all input fields
  void clearAllControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPassController.clear();
    qualificationController.clear();
    experienceController.clear();
  }

  // Toggle Password Visibility
  void toggleVisibility() => isObscureText.value = !isObscureText.value;
  void toggleVisibilityConfirm() => isObscureText2.value = !isObscureText2.value;

  // Validation Helpers
  String? validateInput(String value, String field) {
    if (value.trim().isEmpty) {
      return 'Please enter your $field';
    }
    return null;
  }

  bool validatePasswords() {
    return passwordController.text.trim() == confirmPassController.text.trim();
  }

  // Sign-Up and Save to Firestore
  Future<void> signUp(BuildContext context) async {
    if (!validatePasswords()) {
      Get.snackbar(
        "Error",
        "Passwords do not match.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (formKey.currentState?.validate() ?? false) {
      // Show Loading Dialog
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      try {
        // Create User in Firebase Authentication
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        print("User created: ${userCredential.user?.uid}");

        // Save User Details to Firestore
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'uid': userCredential.user?.uid,
          'location': location.value,
          'qualification': qualification.value,
          'experience': experience.value,
          'skills': skills.value,
          'phone': phone.value,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Close loading dialog and navigate to AboutPage
        Get.back(); // Close loading dialog
        Get.to(AboutPage(uid: userCredential.user!.uid,)); // Navigate to AboutPage

        // Clear data from fields
        clearAllControllers();
      } on FirebaseAuthException catch (e) {
        Get.back(); // Close loading dialog
        Get.snackbar(
          "Error",
          e.message ?? "An error occurred, please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  // Function to save AboutPage data to Firestore after Signup
  Future<void> saveAboutPageData(String uid) async {
    try {
      // Save AboutPage details to Firestore
      await _firestore.collection('users').doc(uid).update({
        'location': location.value,
        'qualification': qualification.value,
        'experience': experience.value,
        'skills': skills.value,
        'phone': int.parse(phone.value),
        'photoUrl': '',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Optional: Provide success feedback
      Get.snackbar(
        "Successfull",
        ".",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.to(() => BottomNav());
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update profile. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}