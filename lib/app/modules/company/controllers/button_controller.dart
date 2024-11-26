import 'package:get/get.dart';

class ButtonController extends GetxController {
  var showText = false.obs;
  void toggleText() {
    showText.value = !showText.value;
  }
}