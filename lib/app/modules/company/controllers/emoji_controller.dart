import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EmojiController extends GetxController {
  var selectedEmojiIndex = (-1).obs;
  final TextEditingController controller = TextEditingController();
  void selectEmoji(int index) {
    selectedEmojiIndex.value = index;
  }
  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  
}