import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PointController extends GetxController {
  var point = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    resetPoint();
  }

  void resetPoint() {
    point.value = '0';
  }

  Future<void> savePointToFirestore(String applicationId) async {
    if (point.value.isEmpty) {
      Get.snackbar('Error', 'Point cannot be empty',
          backgroundColor: const Color.fromARGB(255, 244, 67, 54),
          colorText: const Color.fromARGB(255, 255, 255, 255));
      return;
    }

    final parsedPoint = int.tryParse(point.value);
    if (parsedPoint == null || parsedPoint < 1 || parsedPoint > 5) {
      Get.snackbar('Error', 'Point must be between 0 and 5',
          backgroundColor: const Color.fromARGB(255, 244, 67, 54),
          colorText: const Color.fromARGB(255, 255, 255, 255));
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('jobApplications')
          .doc(applicationId)
          .update({
        'points': parsedPoint,
      });

      Get.snackbar('Success', 'Points updated successfully',
          backgroundColor: const Color.fromARGB(255, 76, 175, 80),
          colorText: const Color.fromARGB(255, 255, 255, 255));
    } catch (e) {
      Get.snackbar('Error', 'Failed to update points: $e',
          backgroundColor: const Color.fromARGB(255, 244, 67, 54),
          colorText: const Color.fromARGB(255, 255, 255, 255));
    }
  }
}
