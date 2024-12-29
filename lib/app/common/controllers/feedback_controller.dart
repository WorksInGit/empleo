import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  final TextEditingController feedbackController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> submitFeedback(
      int emojiIndex, String selectedEmoji, String feedbackText) async {
    if (selectedEmoji.isNotEmpty && feedbackText.isNotEmpty) {
      try {
        User? currentUser = _auth.currentUser;
        if (currentUser == null) {
          Get.snackbar('Error', 'No user logged in');
          return;
        }

        String userName = currentUser.displayName ?? 'Anonymous';
        String profileUrl = currentUser.photoURL ?? '';

        Map<String, dynamic> feedbackData = {
          'emoji': selectedEmoji,
          'emojiIndex': emojiIndex,
          'feedbackText': feedbackText,
          'userName': userName,
          'profileUrl': profileUrl,
          'createdAt': FieldValue.serverTimestamp(),
        };

        await FirebaseFirestore.instance
            .collection('feedbacks')
            .add(feedbackData);

        selectedEmoji = '';
        Get.back();

        Get.snackbar('Success', 'Feedback submitted successfully');
      } catch (e) {
        Get.snackbar('Error', 'Failed to submit feedback: $e');
      }
    } else {
      Get.snackbar('Error', 'Please select an emoji and provide feedback');
    }
  }
}
