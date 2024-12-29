import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/common/views/selection_page.dart';
import 'package:empleo/app/modules/company/views/company_bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var obscureText = true.obs;
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and Password are required.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      DocumentSnapshot companyDoc = await _firestore
          .collection('companies')
          .doc(userCredential.user!.uid)
          .get();

      if (!companyDoc.exists) {
        Get.snackbar(
          'Error',
          'Company not found.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        int status = companyDoc.get('status') ?? 0;
        if (status == 1) {
          await saveLoginState();

          Get.offAll(
            CompanyNav(),
            transition: Transition.fadeIn,
            duration: Duration(milliseconds: 500),
          );
        } else if (status == -1) {
          Get.defaultDialog(
            title: 'Registration Rejected',
            middleText:
                'Your profile has been rejected. Please check your mail for more details.',
            onConfirm: () {
              Get.back();
            },
            textConfirm: 'OK',
            confirmTextColor: Colors.white,
            backgroundColor: Colors.white,
            titleStyle: GoogleFonts.poppins(fontSize: 18.sp),
            middleTextStyle: GoogleFonts.poppins(fontSize: 15.sp),
            buttonColor: HexColor('4CA6A8'),
          );
        } else {
          Get.snackbar(
            'Pending Approval',
            'Your account is not approved yet.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.transparent,
            colorText: Colors.black,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedInCompany', true);
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedInCompany', false);
      Get.offAll(SelectionPage(),
      );
    } catch (e) {
      print("Error during sign-out: $e");
    }
  }
}
