import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/user/views/about_page.dart';
import 'package:empleo/app/modules/user/views/user_bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();
  var qualificationController = TextEditingController();
  var experienceController = TextEditingController();

  var isObscureText = true.obs;
  var isObscureText2 = true.obs;

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

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

  void clearAllControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPassController.clear();
    qualificationController.clear();
    experienceController.clear();
  }

  void toggleVisibility() => isObscureText.value = !isObscureText.value;
  void toggleVisibilityConfirm() =>
      isObscureText2.value = !isObscureText2.value;

  String? validateInput(String value, String field) {
    if (value.trim().isEmpty) {
      return 'Please enter your $field';
    }
    return null;
  }

  bool validatePasswords() {
    return passwordController.text.trim() == confirmPassController.text.trim();
  }

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
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        await userCredential.user?.updateProfile(
          displayName: nameController.text,
          photoURL: '',
        );
        print("User created: ${userCredential.user?.uid}");

        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'uid': '',
          'location': location.value,
          'qualification': qualification.value,
          'experience': experience.value,
          'skills': skills,
          'phone': phone.value,
          'createdAt': FieldValue.serverTimestamp(),
        });

        Get.back();
        Get.to(AboutPage(
          uid: userCredential.user!.uid,
        ));

        clearAllControllers();
      } on FirebaseAuthException catch (e) {
        Get.back();
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

  Future<void> saveAboutPageData(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'location': location.value,
        'qualification': qualification.value,
        'uid': user?.uid,
        'experience': experience.value,
        'skills': skills,
        'phone': int.parse(phone.value),
        'photoUrl': user?.photoURL ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'status': 1
      });
      await _firestore
          .collection('totalUsers')
          .add({'uid': uid, 'createdAt': FieldValue.serverTimestamp()});
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
