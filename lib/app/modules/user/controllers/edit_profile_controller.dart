import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final qualificationController = TextEditingController();
  final experienceController = TextEditingController();
  final skillsController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  var profileImageUrl = RxString('');
  var isUploading = RxBool(false);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        isUploading.value = true;

        final storageRef = FirebaseStorage.instance.ref().child(
            'profile_pictures/${DateTime.now().millisecondsSinceEpoch}.jpg');
        final uploadTask = storageRef.putFile(File(image.path));

        await uploadTask;

        final imageUrl = await storageRef.getDownloadURL();

        profileImageUrl.value = imageUrl;
      } catch (e) {
        Get.snackbar("Error", "Failed to upload image",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } finally {
        isUploading.value = false;
      }
    }
  }

  void updateProfile(String uid) async {
    final skills =
        skillsController.text.split(',').map((e) => e.trim()).toList();

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': nameController.text,
        'email': emailController.text,
        'qualification': qualificationController.text,
        'experience': experienceController.text,
        'skills': skills,
        'photoUrl':
            profileImageUrl.value.isEmpty ? null : profileImageUrl.value,
        'phone': int.parse(phoneController.text),
        'location': locationController.text
      });

      Get.snackbar("Success", "Profile updated successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.transparent,
          colorText: Colors.black);
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
