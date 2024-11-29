import 'package:get/get.dart';

class FieldController extends GetxController {
  var isObscureText = true.obs;
  var isObscureText2 = true.obs;
  void toggleVisibility() {
    isObscureText.value = !isObscureText.value;
  }
  
   void toggleVisibilityConfirm() {
    isObscureText2.value = !isObscureText2.value;
  }
  

}