import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../views/user_bottom_nav.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final user = await AuthService().loginWithEmailAndPassword(email, password);
      if (user != null) {
        Get.offAll(() => BottomNav());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
    isLoading.value = true;
    try {
      final user = await AuthService().signInWithGoogle();
      if (user != null) {
        Get.offAll(() => BottomNav());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}